#!/bin/bash
#script to install all the little thing on a new system

echo "please enter username for git"
read $usename

echo "please enter email for git"
read $email_addr

sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove

sudo apt install neofetch ssh htop chromium-browser vlc git net-tools curl wget unzip filezilla -y

git config --global user.name $username
git config --global user.email $email_addr
git config --sysyem core.editor nano

