#!/bin/bash
myloc=$(dirname "$(realpath $0)")

sudo apt install -y gparted nwipe hdparm

sudo \rm ~/Bureau/home.desktop 2> /dev/null
sudo
touch $HOME/Bureau/home.desktop
tee $HOME/Bureau/home.desktop <<'EOF'
[Desktop Entry]
Encoding=UTF-8
Name=Dossier personnel
GenericName=Fichiers personnels
URL[$e]=$HOME
Icon=user-home
Type=Link
EOF

sudo \rm ~/Bureau/trash.desktop 2> /dev/null
sudo tee ~/Bureau/trash.desktop >/dev/null <<'EOF'
[Desktop Entry]
Name=Corbeille
Comment=Fichiers supprimés
Icon=user-trash-full
EmptyIcon=user-trash
Type=Link
URL=trash:/
OnlyShowIn=KDE;
EOF

sudo \rm $HOME/Bureau/gparted2.desktop 2> /dev/null
sudo \rm /usr/share/applications/gparted2.desktop 2> /dev/null
sudo tee $HOME/Bureau/gparted2.desktop >/dev/null <<'EOF'
[Desktop Entry]
Version=1.0
Name=ADMIN_Gparted
Comment=Gparted
Exec=konsole -e "bash -c 'sudo gparted'"
Icon=gparted
Terminal=false
Type=Application
Categories=Application;
EOF

sudo cp $HOME/Bureau/gparted2.desktop /usr/share/applications/gparted2.desktop
sudo chown $USER:$USER $HOME/Bureau/gparted2.desktop
sudo chmod +x $HOME/Bureau/gparted2.desktop
sudo chown root:root /usr/share/applications/gparted2.desktop
sudo chmod +x /usr/share/applications/gparted2.desktop

sudo cp /usr/share/applications/org.kde.partitionmanager.desktop /usr/share/applications/org.kde.partitionmanager2.desktop
sudo sed -i "s/Name=.*/Name=ADMIN_KParted/g" /usr/share/applications/org.kde.partitionmanager2.desktop
sudo sed -i "s/Name.fr.=.*/Name[fr]=ADMIN_KParted/g" /usr/share/applications/org.kde.partitionmanager2.desktop
sudo sed -i "s/GenericName=.*/GenericName=ADMIN_Partition Editor/g" /usr/share/applications/org.kde.partitionmanager2.desktop
sudo sed -i "s/GenericName.fr.=.*/GenericName[fr]=ADMIN_Éditeur de partitions/g" /usr/share/applications/org.kde.partitionmanager2.desktop
sudo sed -i "s/Exec=.*/Exec=sudo partitionmanager/g" /usr/share/applications/org.kde.partitionmanager2.desktop

sudo cp /usr/share/applications/org.kde.partitionmanager2.desktop $HOME/Bureau
sudo chown $USER:$USER $HOME/Bureau/org.kde.partitionmanager2.desktop
sudo chmod +x $HOME/Bureau/org.kde.partitionmanager2.desktop


sudo \rm $HOME/Bureau/nwipe.desktop 2> /dev/null
sudo \rm /usr/share/applications/nwipe.desktop 2> /dev/null
sudo tee $HOME/Bureau/nwipe.desktop >/dev/null <<'EOF'
[Desktop Entry]
Version=1.0
Name=ADMIN_Nwipe
Comment=Nwipe
Exec=konsole -e "bash -c 'sudo nwipe'"
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Application;
EOF

sudo cp $HOME/Bureau/nwipe.desktop /usr/share/applications/nwipe.desktop
sudo chown $USER:$USER $HOME/Bureau/nwipe.desktop
sudo chmod +x $HOME/Bureau/nwipe.desktop
sudo chown root:root /usr/share/applications/nwipe.desktop
sudo chmod +x /usr/share/applications/nwipe.desktop

sudo mkdir /usr/share/icons/my_icons/
sudo cp $myloc/updater.png /usr/share/icons/my_icons/

sudo \rm $HOME/Bureau/mise_a_jour.desktop 2> /dev/null
sudo \rm /usr/share/applications/mise_a_jour.desktop 2> /dev/null
sudo tee $HOME/Bureau/mise_a_jour.desktop >/dev/null <<'EOF'
[Desktop Entry]
Version=1.0
Name=ADMIN_mise_a_jour
Comment=ADMIN_mise_a_jour
Exec=konsole -e "bash -c 'sudo apt update -y && sudo apt upgrade -y && flatpak update -y && snap refresh'"
Icon=/usr/share/icons/my_icons/updater.png
Terminal=false
Type=Application
Categories=Application;
EOF

sudo cp $HOME/Bureau/mise_a_jour.desktop /usr/share/applications/mise_a_jour.desktop
sudo chown $USER:$USER $HOME/Bureau/mise_a_jour.desktop
sudo chmod +x $HOME/Bureau/mise_a_jour.desktop
sudo chown root:root /usr/share/applications/mise_a_jour.desktop
sudo chmod +x /usr/share/applications/mise_a_jour.desktop
