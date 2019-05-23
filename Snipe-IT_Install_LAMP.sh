#!/bin/bash
#script to install Snipe-IT Asset Management 

apt update 

#installs Basic LAMP stack
apt install apache2 mariadb-server mariadb-client php libapache2-mod-php php-cli curl git unzip -y

#installs needed PHP addons
apt install php-mcrypt php-curl php-mysql php-gd php-ldap php-zip php-mbstring php-xml php-bcmath php-cli -y

#enable webserver on startup
systemctl start mariadb.service

#set variables for user, app name and path,
readonly APP_USER="snipeit_user"
readonly APP_NAME="snipe-it"
readonly APP_PATH="/var/www/$APP_NAME"

#DATABASE VARIABLE INPUT
	read -p "Please enter a Database name [snipeit_db]: " DB_NAME
  DB_NAME=${DB_NAME:-snipeit_db}
  read -p "Please enter a Database user [snipeit_user]: " DB_USER
  DB_USER=${DB_USER:-snipeit_user}
  read -p "Please enter a PASSWORD to be used for the snipeit database user!" DB_PASS
  read -p "Please enter root user MySQL password!" rootpasswd

#DATABASE VARIABLE INPUT
  mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${DB_NAME};"
  mysql -uroot -p${rootpasswd} -e "show databases;"
  mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON snipeit_db.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
  mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
  echo "Database Creation Complete"
  echo " Database Name:	 ${DB_NAME}"
  echo " Username:    	 ${DB_USER}"

#Install composer - A dependancy manager for PHP
  cd /tmp
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar /usr/local/bin/composer


#clones from repository
  git clone https://github.com/snipe/snipe-it $APP_PATH

#adds ther snipeitapp user and sets permission levels
  adduser --quiet --disabled-password --gecos '""' "$APP_USER"
  chmod -R 775 "$APP_PATH/storage"
  chmod -R 755 "$APP_PATH/public/uploads"

#grants permssions to snipeitapp user
chown -R "$APP_USER":"$apache_group" "$APP_PATH"

#setup .env file
cd /var/www/snipe-it
$ sudo cp .env.example .env

#Set needed variable in .env file
tzone=$(cat /etc/timezone)
read -p "Please enter the URL for site [localhost]: " WEB_ADDR
  WEB_ADDR=${WEB_ADDR:-localhost}

  sed -i '1 i\#Created By Snipe-it Installer' "$APP_PATH/.env"
  sed -i "s|^\\(APP_TIMEZONE=\\).*|\\1$tzone|" "$APP_PATH/.env"
  sed -i "s|^\\(DB_HOST=\\).*|\\1$localhost|" "$APP_PATH/.env"
  sed -i "s|^\\(DB_DATABASE=\\).*|\\1$DB_NAME|" "$APP_PATH/.env"
  sed -i "s|^\\(DB_USERNAME=\\).*|\\1$DB_USER|" "$APP_PATH/.env"
  sed -i "s|^\\(DB_PASSWORD=\\).*|\\1$DB_PASS|" "$APP_PATH/.env"
  sed -i "s|^\\(APP_URL=\\).*|\\1http://$WEB_ADDR|" "$APP_PATH/.env"


phpenmod mcrypt
phpenmod mbstring
a2enmod rewrite
#a2ensite $APP_NAME.conf
