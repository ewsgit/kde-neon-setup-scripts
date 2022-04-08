# install dependancies

sudo apt install curl
sudo apt install wget
sudo apt install xclip
sudo apt install libqt5svg5 qml-module-qtquick-controls

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

sudo apt upgrade

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

ssh-keygen -t ed25519 -C "$github_email" | xclip -sel clip

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

bash

# install nodejs lts from nvm

nvm install --lts

# install neovim

cd tmp

curl --url "https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage" --output "neovim.appimage" 

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

yes_or_no "allow reboot to apply changes?" && sudo reboot

# licenses
# material-cursors https://github.com/varlesh/material-cursors
# gruvbox_lines_wallpaper https://www.pling.com/p/1436388
# ocs-url https://www.opendesktop.org/p/1136805/
