#!/bin/bash
myloc=$(dirname "$(realpath $0)")

mkdir -p ~/.dotfiles/config/.config
tee ~/.dotfiles/config/.config/user-dirs.dirs <<'EOF'
# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line you're
# interested in. All local changes will be retained on the next run.
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
# absolute path. No other format is supported.
#
XDG_DESKTOP_DIR="$HOME/Bureau"
XDG_DOWNLOAD_DIR="$HOME/Téléchargements"
XDG_TEMPLATES_DIR="$HOME/Modèles"
XDG_PUBLICSHARE_DIR="$HOME/Public"
XDG_DOCUMENTS_DIR="$HOME/Documents"
XDG_MUSIC_DIR="$HOME/Musique"
XDG_PICTURES_DIR="$HOME/Images"
XDG_VIDEOS_DIR="$HOME/Vidéos"
EOF

sudo tee /etc/xdg/user-dirs.defaults <<'EOF'
# Default settings for user directories
#
# The values are relative pathnames from the home directory and
# will be translated on a per-path-element basis into the users locale
DESKTOP=Bureau
DOWNLOAD=Téléchargements
TEMPLATES=Modèles
PUBLICSHARE=Public
DOCUMENTS=Documents
MUSIC=Musique
PICTURES=Images
VIDEOS=Vidéos
# Another alternative is:
#MUSIC=Documents/Musique
#PICTURES=Documents/Images
#VIDEOS=Documents/Vidéos
EOF

# Set xdg-user-dirs
xdg-user-dirs-update \
  --dummy-output ~/.dotfiles/config/.config/user-dirs.dirs \
  --set DOCUMENTS $HOME/Documents
xdg-user-dirs-update \
  --dummy-output ~/.dotfiles/config/.config/user-dirs.dirs \
  --set MUSIC $HOME/Musique
xdg-user-dirs-update \
  --dummy-output ~/.dotfiles/config/.config/user-dirs.dirs \
  --set PICTURES $HOME/Images
xdg-user-dirs-update \
  --dummy-output ~/.dotfiles/config/.config/user-dirs.dirs \
  --set VIDEOS $HOME/Vidéos
xdg-user-dirs-update \
  --dummy-output ~/.dotfiles/config/.config/user-dirs.dirs \
  --set DOWNLOAD $HOME/Téléchargements
xdg-user-dirs-update \
  --dummy-output ~/.dotfiles/config/.config/user-dirs.dirs \
  --set TEMPLATES $HOME/Templates
xdg-user-dirs-update \
  --dummy-output ~/.dotfiles/config/.config/user-dirs.dirs \
  --set PUBLICSHARE $HOME/Public
xdg-user-dirs-update \
  --dummy-output ~/.dotfiles/config/.config/user-dirs.dirs \
  --set DESKTOP $HOME/Bureau

mkdir -p $HOME/{Documents,Musique,Images,Vidéos,Téléchargements,Modèles,Public,Bureau}

xdg-user-dirs-update \
  --set DOCUMENTS $HOME/Documents
xdg-user-dirs-update \
  --set MUSIC $HOME/Musique
xdg-user-dirs-update \
  --set PICTURES $HOME/Images
xdg-user-dirs-update \
  --set VIDEOS $HOME/Vidéos
xdg-user-dirs-update \
  --set DOWNLOAD $HOME/Téléchargements
xdg-user-dirs-update \
  --set TEMPLATES $HOME/Modèles
xdg-user-dirs-update \
  --set PUBLICSHARE $HOME/Public
xdg-user-dirs-update \
  --set DESKTOP $HOME/Bureau

xdg-user-dirs-update

sed -i 's\Desktop\Bureau\g' ~/.local/share/user-places.xbel
sed -i 's\Music\Musique\g' ~/.local/share/user-places.xbel
sed -i 's\Pictures\Images\g' ~/.local/share/user-places.xbel
sed -i 's\Videos\Vidéos\g' ~/.local/share/user-places.xbel
sed -i 's\Templates\Modèles\g' ~/.local/share/user-places.xbel
sed -i 's\Downloads\Téléchargements\g' ~/.local/share/user-places.xbel

\rm -rf $HOME/Desktop
\rm -rf $HOME/Music
\rm -rf $HOME/Pictures
\rm -rf $HOME/Videos
\rm -rf $HOME/Templates
\rm -rf $HOME/Downloads
