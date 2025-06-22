sudo apt install -y apt-transport-https wget
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg
echo "deb [signed-by=/usr/share/keyrings/microsoft.gpg arch=amd64] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
sudo apt update -y
sudo apt install -y microsoft-edge-stable
sudo mkdir /usr/share/icons/Crius 2> /dev/null
sudo cp ./edge.png /usr/share/icons/Crius
sudo sed -i 's|Icon=microsoft-edge|Icon=/usr/share/icons/Crius/edge.png|' /usr/share/applications/microsoft-edge.desktop
