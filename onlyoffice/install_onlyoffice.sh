mkdir -p -m 700 ~/.gnupg
gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
chmod 644 /tmp/onlyoffice.gpg
sudo chown root:root /tmp/onlyoffice.gpg
sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg
echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list
sudo apt update && sudo apt install -y onlyoffice-desktopeditors
sudo mkdir /usr/share/icons/Crius 2> /dev/null
sudo cp ./only.png /usr/share/icons/Crius
sudo sed -i 's|Icon=onlyoffice-desktopeditors|Icon=/usr/share/icons/Crius/only.png|' /usr/share/applications/onlyoffice-desktopeditors.desktop
