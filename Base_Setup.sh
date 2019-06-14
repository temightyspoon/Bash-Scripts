#!/bin/bash
#script to install all the little thing on a new system

# Set Variables for script
read -p "please enter username for git" $gitusename
read -p "please enter email for git" $gitemail_addr


sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove

sudo apt install neofetch ssh htop chromium-browser vlc git net-tools curl wget unzip filezilla -y

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg;
  sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg;
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list';
	sudo apt-get update;
	sudo apt-get install code;

git config --global user.name $gitusername
git config --global user.email $gitemail_addr
git config --sysyem core.editor nano

