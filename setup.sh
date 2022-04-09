# install dependancies

sudo apt install curl
sudo apt install wget
sudo apt install xclip
sudo apt install libqt5svg5 qml-module-qtquick-controls

mkdir tmp

function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

sudo apt update

yes_or_no "run \"ubuntu-drivers install\"? (only if you are sure this is an ubuntu distro)" && sudo ubuntu-drivers install

sudo pkcon update

# copy kde config

cp ./assets/.kde/ ~/.kde/ -r

# install nala

echo "deb [arch=amd64,arm64,armhf] http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
sudo apt update && sudo apt install nala

# get wallpapers

cd tmp

curl --url https://wallpapercave.com/download/statistics-wallpapers-wp3098860 --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.60 Safari/537.36 Edg/100.0.1185.29" --output "lines_wallpaper.jpg"

cp ./assets/gruvbox_lines_wallpaper.jpg .

# copy wallpapers to ~/.local/share/wallpapers/

cp ./* ~/.local/share/wallpapers/ -r
rm ./*

cd ..

# install nvm

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# install python 3

sudo apt install python3

# create a github ssh key

# request user input for email

read -p "Please enter your github email (this is not verified): " github_email

# copy result to clipboard

ssh-keygen -t ed25519 -C "$github_email"
cat ~/.ssh/id_ed25519.pub | xclip -sel clip

python3 -mwebbrowser "https://github.com/settings/keys"

read -p "Please create a new ssh key using the value copied to the clipboard, then press Enter to continue."

# install ocs-url

sudo dpkg -i ./assets/ocs-url.deb

# install vscode

cd ./tmp/

curl --url "https://az764295.vo.msecnd.net/stable/8dfae7a5cd50421d10cd99cb873990460525a898/code_1.66.1-1649257842_amd64.deb" --output "vscode.deb"

sudo dpkg -i "vscode.deb"

rm ./*
cd ..

# install build-essential

sudo nala install build-essential

# copy .bashrc

cp ./assets/.bashrc ~/.bashrc

# reload bash

~/.bashrc

# install pip

sudo nala install python3-pip

# install nodejs lts from nvm

nvm install --lts

# install neovim

cd tmp

curl --url "https://objects.githubusercontent.com/github-production-release-asset-2e65be/16408992/16e6beba-fea4-4ff7-a09d-422929fbdf3d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220409%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220409T124454Z&X-Amz-Expires=300&X-Amz-Signature=4b6c5f13b71ff189e5ac5c285c36eac55944e5a4ce6acb8f2f2da83a0e5c5817&X-Amz-SignedHeaders=host&actor_id=69800526&key_id=0&repo_id=16408992&response-content-disposition=attachment%3B%20filename%3Dnvim.appimage&response-content-type=application%2Foctet-stream" --output "neovim.appimage" 

mkdir ~/.neovimApp
cp ./neovim.appimage ~/.neovimApp/nvim.appimage

rm ./*
cd ..

# copy neovim conifg

cp ./assets/neovim_config ~/.config/nvim/ -r

# install materia-dark

python3 -mwebbrowser "https://www.pling.com/c/1462863"

read -p "please install all of the materia dark themes then press Enter to continue."

# install vimplug

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install mpv and play-with-mpv for chromium browsers
# install mpv
sudo nala install mpv

# install play-with-mpv
pip install git+https://github.com/thann/play-with-mpv --user

# remove youtube-dl
rm ~/.local/bin/youtube-dl

# install yt-dlp
python3 -m pip install -U yt-dlp

# replace youtube-dl with yt-dlp (improves performance drastically)
mv ~/.local/bin/yt-dlp ~/.local/bin/youtube-dl

# add to autostart script
echo "#!/bin/bash\nplay-with-mpv" >> ~/.config/autostart/play-with-mpv-autostart.sh

yes_or_no "allow reboot to apply changes?" && sudo reboot

# licenses
# material-cursors https://github.com/varlesh/material-cursors
# gruvbox_lines_wallpaper https://www.pling.com/p/1436388
# ocs-url https://www.opendesktop.org/p/1136805/
