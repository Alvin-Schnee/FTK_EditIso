#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
DEFAULT='\033[0m'

clear

isGitInstalled='pacman -Q git'
isDos2unixInstalled='pacman -Q dos2unix'

if [ ! -n "$isGitInstalled" ]; then
	echo -ne "${RED}STRELIZIA${DEFAULT} > Installing git ... "
	pacman --noconfirm -S git
	git config --global user.name "Fenrir"
	git config --global user.email "FoxehCorporation@protonmail.com"
	echo -e "${GREEN}done${DEFAULT}."
fi

if [ ! -n "$isDos2unixInstalled" ]; then
	echo -ne "${RED}STRELIZIA${DEFAULT} > Installing dos2unix ... "
	pacman --noconfirm -S dos2unix
	echo -e "${GREEN}done${DEFAULT}."
fi

git clone https://github.com/FoxehCorp/FTK_ArchInstaller /home/fenrir/FTK_ArchInstaller
clear

echo -ne "${RED}STRELIZIA${DEFAULT} > Enabling time synchronization ... "
systemctl start systemd-timesyncd
echo -e "${GREEN}done${DEFAULT}."

echo -ne "${RED}STRELIZIA${DEFAULT} > Expanding airootfs.sfs via unsquashfs (this is gonna take some time) ... "
unsquashfs -f -d /home/fenrir/customiso/arch/x86_64/squashfs-root /home/fenrir/customiso/arch/x86_64/airootfs.sfs > /dev/null
echo -e "${GREEN}done${DEFAULT}."

echo -ne "${RED}STRELIZIA${DEFAULT} > Copying the scripts to the ISO ... "
chmod 777 /home/fenrir/FTK_ArchInstaller/FTK_ArchInstaller.sh
chmod 777 /home/fenrir/FTK_ArchInstaller/bin/FTK_Initializer.sh
chmod 777 /home/fenrir/FTK_EditISO/bin/FTK_UpdatePackage.sh
chmod 777 /home/fenrir/FTK_EditISO/bin/automated_script.sh
dos2unix -q /home/fenrir/FTK_ArchInstaller/FTK_ArchInstaller.sh
dos2unix -q /home/fenrir/FTK_ArchInstaller/bin/FTK_Initializer.sh
dos2unix -q /home/fenrir/FTK_EditISO/bin/FTK_UpdatePackage.sh
dos2unix -q /home/fenrir/FTK_EditISO/bin/automated_script.sh
cp /home/fenrir/FTK_ArchInstaller/FTK_ArchInstaller.sh /home/fenrir/customiso/arch/x86_64/squashfs-root/bin/FTK_ArchInstaller
cp /home/fenrir/FTK_ArchInstaller/bin/FTK_Initializer.sh /home/fenrir/customiso/arch/x86_64/squashfs-root/bin/FTK_Initializer
cp /home/fenrir/FTK_EditISO/bin/FTK_UpdatePackage.sh /home/fenrir/customiso/arch/x86_64/squashfs-root/bin/FTK_UpdatePackage
cp /home/fenrir/FTK_EditISO/bin/automated_script.sh /home/fenrir/customiso/arch/x86_64/squashfs-root/root/.automated_script.sh
echo -e "${GREEN}done${DEFAULT}."

echo -e "\n${RED}STRELIZIA${DEFAULT} > Chrooting into the system ... "
arch-chroot /home/fenrir/customiso/arch/x86_64/squashfs-root /bin/bash ./bin/FTK_UpdatePackage

echo -ne "\n${RED}STRELIZIA${DEFAULT} > Moving package list ... "
mv /home/fenrir/customiso/arch/x86_64/squashfs-root/root/pkglist.txt /home/fenrir/customiso/arch/pkglist.x86_64.txt
echo -e "${GREEN}done${DEFAULT}."

rm /home/fenrir/customiso/arch/x86_64/airootfs.sfs
echo -ne "${RED}STRELIZIA${DEFAULT} > Recreating airootfs.sfs via mksquashfs (this is gonna take some time) ... "
mksquashfs /home/fenrir/customiso/arch/x86_64/squashfs-root /home/fenrir/customiso/arch/x86_64/airootfs.sfs -comp xz &> /dev/null
echo -e "${GREEN}done${DEFAULT}."

rm -r /home/fenrir/customiso/arch/x86_64/squashfs-root
echo -ne "${RED}STRELIZIA${DEFAULT} > Generating signature ... "
md5sum /home/fenrir/customiso/arch/x86_64/airootfs.sfs > /home/fenrir/customiso/arch/x86_64/airootfs.md5
echo -e "${GREEN}done${DEFAULT}."

cd /home/fenrir/customiso
echo -ne "${RED}STRELIZIA${DEFAULT} > Generating ISO image ... "
genisoimage -l -r -J -V "ARCH_201901" -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -c isolinux/boot.cat -o /home/fenrir/FTK_PROJECT-ARCH.iso ./ &> /dev/null
isohybrid /home/fenrir/FTK_PROJECT-ARCH.iso > /dev/null
echo -e "${GREEN}done${DEFAULT}."
cd /home/fenrir/FTK_EditISO

echo -ne "${RED}STRELIZIA${DEFAULT} > Mounting USB device ... "
mount LABEL="ARCH_201903" /mnt/usb # -t ntfs-3g -o nls=utf8,umask=0222
echo -e "${GREEN}done${DEFAULT}."

echo -ne "${RED}STRELIZIA${DEFAULT} > Copying ISO to USB device ... "
rm -rf /mnt/usb/*
cp /home/fenrir/FTK_PROJECT-ARCH.iso /mnt/usb/FTK_PROJECT-ARCH.iso
echo -e "${GREEN}done${DEFAULT}."

echo -ne "${RED}STRELIZIA${DEFAULT} > Unmounting USB device ..."
umount LABEL="ARCH_201903"
echo -e "${GREEN}done${DEFAULT}."

rm -rf /home/fenrir/FTK_ArchInstaller

echo -ne "\n${RED}STRELIZIA${DEFAULT} > Thank you for your patience, master. *bows*\n"