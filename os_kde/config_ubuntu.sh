#!/usr/bin/env bash

sudo echo -e "\n\033[31;5mKubuntu finish script by CRIUS - 20250221\033[0m\n" && sleep 4

myloc=$(dirname "$(realpath $0)")

WGETOPT='-q --show-progress'

WGETVERSION=$(wget -V | head -n 1 | awk '{ print substr($3,1,1) }')

if [ "$WGETVERSION" = 2 ]
then
	WGETOPT='-nv'
fi

sudo cat /etc/sudoers | grep $USER > /dev/null 2>&1
if [ $? -eq "1" ]
then
	echo "" | sudo tee -a /etc/sudoers
	echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
	echo "" | sudo tee -a /etc/sudoers
	echo "ALL ALL=NOPASSWD: /usr/bin/wg-quick" | sudo tee -a /etc/sudoers
fi
echo -e "[*] No sudo passwd set for user $USER\n"

sudo apt purge -y hexchat quassel* brasero evolution
sudo apt update && sudo apt install -y curl wget bzip2 xournal ofono p7zip-full p7zip-rar exfatprogs openjdk-21-jre pdfsam imagemagick p7zip p7zip-full p7zip-rar transmission-qt gparted gufw nwipe libfuse2t64 hdparm snap snapd detox filezilla libavcodec-extra61 libavcodec-extra gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-ugly unrar rar fonts-liberation ttf-mscorefonts-installer x264 x265 okular cifs-utils onlyoffice-desktopeditors vlc
sudo snap install xournalpp gtk-common-themes gtk2-common-themes dg-adw-gtk3-theme

#installation shadow drive
sudo mkdir /usr/share/icons/my_icons/
sudo \rm -rf ~/zappimage
mkdir ~/zappimages
mkdir ~/.local/share/applications
sudo cp $myloc/APPIMAGES/Nextcloud.png /usr/share/icons/my_icons/
cp $myloc/APPIMAGES/tech.shadow.drive.shadow-drive.desktop $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i 's|Icon=Nextcloud|Icon=/usr/share/icons/my_icons/Nextcloud.png|' $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i 's|Icon=shadow-drive|Icon=/usr/share/icons/my_icons/Nextcloud.png|' $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s|Icon.fr.=.*|Icon[fr]=/usr/share/icons/my_icons/Nextcloud.png|g" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s|Exec=shadow-drive %u|Exec=$HOME/zappimages/ShadowDrive-Linux64.AppImage %u|" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s|Exec=shadow-drive --quit|Exec=$HOME/zappimages/ShadowDrive-Linux64.AppImage --quit|" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s/GenericName=.*/GenericName=Shadow Drive/g" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s/GenericName.fr.=.*/GenericName[fr]=Shadow Drive/g" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s/Name=.*/Name=Shadow Drive/g" $myloc/APPIMAGES/shadow.drive.desktop
sudo sed -i "s/Name.fr.=.*/Name[fr]=Shadow Drive/g" $myloc/APPIMAGES/shadow.drive.desktop
sudo \rm /usr/share/applications/tech.shadow.drive.shadow-drive.desktop
sudo \rm ~/.local/share/applications/tech.shadow.drive.shadow-drive.desktop
sudo \rm $HOME/Bureau/tech.shadow.drive.shadow-drive.desktop
sudo \rm $HOME/zappimages/ShadowDrive-Linux64.AppImage
wget -O $HOME/zappimages/ShadowDrive-Linux64.AppImage 'https://drive.shadow.tech/s/jg7WfDJJ9GYWNYn/download?path=%2F&files=ShadowDrive-Linux64.AppImage' $WGETOPT
cd $myloc && cp ./APPIMAGES/shadow.drive.desktop ~/.local/share/applications
cd $myloc && cp ./APPIMAGES/shadow.drive.desktop $HOME/Bureau

###modeles
echo -e "[*] Copie des modèles de documents\n"
cd $myloc && cp ./modèles/* ~/Modèles/

###flatpak
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.github.tchx84.Flatseal com.poweriso.PowerISO com.warlordsoftwares.media-downloader com.warlordsoftwares.youtube-downloader-4ktube org.keepassxc.KeePassXC #org.videolan.VLC

###polices marianne et spectral
sudo mkdir -p "/tmp/fonts/"
sudo mkdir /usr/share/fonts/{Marianne,Spectral} > /dev/null 2>&1
sudo wget -O /tmp/fonts/marianne.zip $WGETOPT https://www.systeme-de-design.gouv.fr/uploads/Marianne_fd0ba9c190.zip
sudo wget -O /tmp/fonts/spectral.zip $WGETOPT https://www.systeme-de-design.gouv.fr/uploads/Spectral_2a059d2f08.zip
sudo unzip "/tmp/fonts/*.zip" -d /tmp/fonts > /dev/null 2>&1
sudo mv /tmp/fonts/Marianne/fontes\ desktop /tmp/fonts/Marianne/fontes_desktop
sudo mv /tmp/fonts/Marianne/fontes_desktop/*.otf /usr/share/fonts/Marianne
sudo mv /tmp/fonts/*.ttf /usr/share/fonts/Spectral
sudo \rm -rf /tmp/fonts

###icones tela
mkdir -p /tmp/tela > /dev/null
wget -O /tmp/tela/tela.zip $WGETOPT https://github.com/vinceliuice/Tela-icon-theme/archive/refs/heads/master.zip
sudo unzip /tmp/tela/tela.zip -d /tmp/tela > /dev/null
cd /tmp/tela/Tela-icon-theme-master
sudo ./install.sh > /dev/null
cd $myloc
sudo \rm -rf /tmp/tela

###icones breeze round
mkdir -p /tmp/breeze > /dev/null 2>&1
wget -O /tmp/breeze/breeze.zip $WGETOPT https://github.com/L4ki/Breeze-Chameleon-Icons/archive/refs/heads/master.zip
sudo unzip /tmp/breeze/breeze.zip -d /tmp/breeze > /dev/null 2>&1
sudo mv /tmp/breeze/Breeze-Chameleon-Icons-master/'Breeze-Round-Chameleon Dark Icons' /tmp/breeze/Breeze-Chameleon-Icons-master/Breeze-Round-Chameleon_Dark_Icons
sudo mv /tmp/breeze/Breeze-Chameleon-Icons-master/'Breeze-Round-Chameleon Light Icons' /tmp/breeze/Breeze-Chameleon-Icons-master/Breeze-Round-Chameleon_Light_Icons
sudo cp -R /tmp/breeze/Breeze-Chameleon-Icons-master/Breeze-Round-Chameleon_Dark_Icons /usr/share/icons
sudo cp -R /tmp/breeze/Breeze-Chameleon-Icons-master/Breeze-Round-Chameleon_Light_Icons /usr/share/icons
sudo \rm -rf /tmp/breeze
sudo cp $myloc/fedora-logo-icon.svg /usr/share/icons/Breeze-Round-Chameleon_Dark_Icons/apps/48/fedora-logo-icon.svg
sudo cp $myloc/fedora-logo-icon.svg /usr/share/icons/Breeze-Round-Chameleon_Dark_Icons/apps/32/fedora-logo-icon.svg
sudo cp $myloc/fedora-logo-icon.svg /usr/share/icons/Breeze-Round-Chameleon_Light_Icons/apps/48/fedora-logo-icon.svg
sudo cp $myloc/fedora-logo-icon.svg /usr/share/icons/Breeze-Round-Chameleon_Light_Icons/apps/32/fedora-logo-icon.svg

###forçage icone vlc
sudo mkdir -p /usr/share/icons/Crius/
sudo cp $myloc/vlc.png /usr/share/icons/Crius/vlc.png
sudo sed -i 's|Icon=vlc|Icon=/usr/share/icons/Crius/vlc.png|' /usr/share/applications/vlc.desktop

echo -e "\n[*] Suppression du logo sur écran de connexion\n"
sudo mv /usr/share/plymouth/ubuntu-logo.png /usr/share/plymouth/ubuntu-logo.png2
sudo touch /usr/share/plymouth/ubuntu-logo.png

echo -e "\n[*] Installation du thème grub\n"
cd $myloc/GRUB
sudo mkdir -p /boot/grub/themes/Zorin-16/
sudo cp -R ./Zorin-16/* /boot/grub/themes/Zorin-16/
sudo cp -an /etc/default/grub /etc/default/grub.bak
grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sudo sed -i '/GRUB_THEME=/d' /etc/default/grub
echo "GRUB_THEME=\"/boot/grub/themes/Zorin-16/theme.txt\"" | sudo tee -a /etc/default/grub
sudo update-grub

echo -e "[*] Optimisation conversion pdf\n"
sudo sed -i 's|<policy domain="coder" rights="none" pattern="PDF" />|<!-- <policy domain="coder" rights="none" pattern="PDF" /> -->|g' /etc/ImageMagick-7/policy.xml
sudo sed -i 's/1GiB/8GiB/g' /etc/ImageMagick-7/policy.xml

sudo sed -i 's|<policy domain="coder" rights="none" pattern="PDF" />|<!-- <policy domain="coder" rights="none" pattern="PDF" /> -->|g' /etc/ImageMagick-6/policy.xml
sudo sed -i 's/1GiB/8GiB/g' /etc/ImageMagick-6/policy.xml
