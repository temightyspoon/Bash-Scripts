#!/bin/bash
#script to install Snipe-IT Asset Management 

apt update 

#installs Basic LAMP stack
apt install apache2 mariadb-server mariadb-client php libapache2-mod-php php-cli curl git unzip -y

#installs needed PHP addons
apt install php-mcrypt php-curl php-mysql php-gd php-ldap php-zip php-mbstring php-xml php-bcmath php-cli -y

#enable webserver on startup
systemctl start mariadb.service


readonly APP_USER="snipeitapp"
readonly APP_NAME="snipeit"
readonly APP_PATH="/var/www/$APP_NAME"

#clones from repository
git clone https://github.com/snipe/snipe-it $APP_PATH

#adds ther snipeitapp user
adduser --quiet --disabled-password --gecos '""' "$APP_USER"

chmod -R 775 "$APP_PATH/storage"
chmod -R 755 "$APP_PATH/public/uploads"

#grants permssions to snipeitapp user
chown -R "$APP_USER":"$apache_group" "$APP_PATH"


phpenmod mcrypt
phpenmod mbstring
a2enmod rewrite
a2ensite $APP_NAME.conf

