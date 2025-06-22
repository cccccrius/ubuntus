#!/bin/bash
#Init

myloc=$(dirname "$(realpath $0)")

urlLatest="https://www.naps2.com/download"
debURL=$(curl --silent $urlLatest | grep '\.deb' | grep x64 | grep -v v7 | grep -Eo 'https://[^ >]+' | sed 's/.$//')
debFile=$(basename ${debURL})
wget -O $myloc/$debFile $debURL
sudo apt install -y $myloc/$debFile
