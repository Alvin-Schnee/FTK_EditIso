#!/bin/bash

# Script Name   : FTK_EditIso
# Script Info   : Automatically handles the customization of an existing official Archiso, in order to add our own installation scripts in it.
# Script Ver.   : 1.0.0 (15 Oct. 2021)
# Script Author : Alvin Schnee (FoxehCorp.)

#⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⢀⣠⣴⣿⣷⣶⣾⣶⣶⣶⣶⣦⣤⣀⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⢀⣠⣆⣤⣶⣦⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⣀⣼⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣦⡀⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⡀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠶⠹⣿⣿⣿⣿⣿⣿⣿⣦⠶⠶⠶⠶⠶⠶
#⠶⠶⣠⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⠶⠶⢻⣿⣿⣿⣿⣿⣿⣿⣧⠶⠶⠶⠶⠶
#⠶⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠶⠶⠻⠿⣿⣿⣿⣿⣿⣷⡖⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⠶⠶⠶⠶
#⠶⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠶⠶⠶⠶⠶⠶⣨⣿⣿⠟⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠶⠶⠶
#⠶⢲⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣿⡆⠶⣼⣻⢯⣁⣀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠶⠶⠶
#⠶⠶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⢠⣿⣿⠉⠐⣷⣿⣝⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠶⠶⠶
#⠶⠶⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⡹⢿⡿⠁⠶⠈⣿⣿⣦⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠶⠶⠶⠶
#⠶⠶⠶⠚⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠗⠶⠶⢀⣿⣯⠽⣆⢀⡀⠻⠟⠋⠶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠙⣿⣿⣿⣿⣿⣿⣿⣿⣅⠶⠶⠈⣿⣧⣀⠶⠈⠨⠶⠶⠶⠶⣿⣿⣿⣿⣿⣿⣿⣿⠟⠃⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠼⣿⣿⣿⣿⣻⣿⣟⠽⠛⠶⠶⢿⣿⣿⠒⠶⠶⠶⠶⠶⠶⢸⣿⣿⣿⣿⣿⠟⠁⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⡿⢋⡮⠛⣿⣿⣿⣿⠶⠶⠶⠈⠁⠈⠁⠶⠶⠶⠶⠶⠶⠈⢿⣿⣿⣿⡏⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⠶⠈⠔⠘⣿⠅⠉⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠈⠻⣿⣿⣧⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠸⠏⠶⠶⠶⠶⠶⢀⣠⣶⣾⣿⣿⣿⣿⣷⣦⣄⠶⠶⠶⠈⠉⠛⠛⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠹⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶
#⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠈⠙⠛⠛⠛⠛⠋⠁⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶

###################### Global Variables #####################

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
DEFAULT='\033[0m'

programName="Strelizia"
logHeader="${RED}$programName - EditIso${DEFAULT} >"

installer="Strelizia"
initializer="StreliziaChroot"
username=$(whoami)

#############################################################

###################### Helper Functions #####################



function printSuccessOrFailure {
    if [ $? -eq 0 ]; then
        echo -e "[ ${GREEN}Done${DEFAULT} ]"
    else
        echo -e "[ ${RED}Failed${DEFAULT} ]. Exiting."
        exit 1
    fi
}

#############################################################

####################### Main Functions ######################

clear

isGitInstalled='pacman -Q git github-cli'
isDos2unixInstalled='pacman -Q dos2unix'

if [ ! -n "$isGitInstalled" ]; then
	echo -ne "$logheader Installing git ... "
	pacman --noconfirm -Sy git github-cli &> /dev/null
	printSuccessOrFailure

	gh auth login
fi

if [ ! -n "$isDos2unixInstalled" ]; then
	echo -ne "$logheader Installing dos2unix ... "
	pacman --noconfirm -Sy dos2unix &> /dev/null
	printSuccessOrFailure
fi

pacman -Sy squashfs-tools
echo $username

#############################################################

################### Downloading Installer ###################

gh repo clone Alvin-Schnee/Strelizia &> /dev/null

chmod +x /home/$username/$installer/$installer.sh
chmod +x /home/$username/$installer/$initializer.sh

dos2unix -q /home/$username/$installer/$installer.sh &> /dev/null
dos2unix -q /home/$username/$installer/$initializer.sh &> /dev/null

#############################################################

clear

####################### Main Functions ######################

echo -ne "\n$logHeader Enabling time synchronization ... "
systemctl start systemd-timesyncd

echo -ne "$logheader Expanding airootfs.sfs via unsquashfs (this is gonna take some time) ... "
unsquashfs -f -d /home/$username/customiso/arch/x86_64/squashfs-root /home/$username/customiso/arch/x86_64/airootfs.sfs &> /dev/null
printSuccessOrFailure

echo -ne "$logheader Copying the scripts to the ISO ... "
cp /home/$username/$installer/$installer.sh /home/$username/customiso/arch/x86_64/squashfs-root/bin/$installer
cp /home/$username/$installer/$initializer.sh /home/$username/customiso/arch/x86_64/squashfs-root/bin/$initializer
printSuccessOrFailure

echo -ne "\n$logheader Moving package list ... "
mv /home/$username/customiso/arch/x86_64/squashfs-root/root/pkglist.txt /home/$username/customiso/arch/pkglist.x86_64.txt
printSuccessOrFailure

rm /home/$username/customiso/arch/x86_64/airootfs.sfs
echo -ne "$logheader Recreating airootfs.sfs via mksquashfs (this is gonna take some time) ... "
mksquashfs /home/$username/customiso/arch/x86_64/squashfs-root /home/$username/customiso/arch/x86_64/airootfs.sfs -comp xz &> /dev/null
printSuccessOrFailure

rm -r /home/$username/customiso/arch/x86_64/squashfs-root
echo -ne "$logheader Generating signature ... "
md5sum /home/$username/customiso/arch/x86_64/airootfs.sfs > /home/$username/customiso/arch/x86_64/airootfs.md5
printSuccessOrFailure

cd /home/$username/customiso
echo -ne "$logheader Generating ISO image ... "
genisoimage -l -r -J -V "ARCH_202110" -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -c isolinux/boot.cat -o /home/$username/FTK_PROJECT-ARCH.iso ./ &> /dev/null
isohybrid /home/$username/FTK_PROJECT-ARCH.iso > /dev/null
printSuccessOrFailure
cd /home/$username/FTK_EditISO

echo -ne "$logheader Mounting USB device ... "
mount LABEL="ARCH_202110" /mnt/usb # -t ntfs-3g -o nls=utf8,umask=0222
printSuccessOrFailure

echo -ne "$logheader Copying ISO to USB device ... "
rm -rf /mnt/usb/*
cp /home/$username/FTK_PROJECT-ARCH.iso /mnt/usb/FTK_PROJECT-ARCH.iso
printSuccessOrFailure

echo -ne "$logheader Unmounting USB device ..."
umount LABEL="ARCH_202110"
printSuccessOrFailure

rm -rf /home/$username/$installer

echo -ne "\n$logheader Thank you for your patience, master. *bows*\n"