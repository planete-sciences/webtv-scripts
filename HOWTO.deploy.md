**How to quickly deploy WebTV encoder...**

PXE Boot:

	label webtvclone
		MENU LABEL Clone WebTV (DANGER)
		kernel clonezilla/vmlinuz
		append initrd=clonezilla/initrd.img boot=live live-config noswap edd=on nomodeset ocs_live_run="ocs-live-restore" ocs_live_extra_param="-b -e1 auto -e2 -r -j2 -p true restoreparts webtv-encoder sda1" ocs_live_batch=yes locales=fr_FR.UTF-8 vga=788 nosplash fetch=tftp://10.9.0.32/clonezilla/filesystem.squashfs ocs_lang=fr_FR.UTF-8 ocs_live_keymap=/usr/share/keymaps/i386/azerty/fr.kmap.gz ocs_prerun1="mount 10.9.0.32:/nfsroot /home/partimag" noprompt ocs_postrun1="/home/partimag/webtv-postclone.sh" ocs_postrun2=poweroff


webtv-postclone.sh:

    #!/bin/bash
    
    id=`cat /home/partimag/webtv-nextid`
    echo $[$id+1] > /home/partimag/webtv-nextid
    
    hostname=webtv$id
    echo Setting new hostname: $hostname
    
    mount /dev/sda1 /mnt
    
    echo $hostname > /mnt/etc/hostname
    echo 127.0.0.1 localhost $hostname > /mnt/etc/hosts
    
    mount --bind /dev /mnt/dev
    mount --bind /proc /mnt/proc
    chroot /mnt grub-install /dev/sda
    umount /mnt/dev
    umount /mnt/proc
    
    umount /mnt
    
    echo "d
    n
    p
    1
    
    
    w
    " | fdisk /dev/sda
    e2fsck -f /dev/sda1
    resize2fs /dev/sda1
