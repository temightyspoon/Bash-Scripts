#!/bin/bash

 APP_PATH=/tmp

tzone=$(cat /etc/timezone)
read -p "Enter Database Host: " DB_HOST
read -p "Enter Database Name: " DB_NAME
read -p "Enter Database User: " DB_USER
read -p "Enter App URL for Site: " WEB_ADDR
USER_PASS='$nipe1t'


  sed -i '1 i\#Created By Snipe-it Installer' "$APP_PATH/.env"
  sed -i "s|^\\(APP_TIMEZONE=\\).*|\\1$tzone|" "$APP_PATH/.env"
  sed -i "s|^\\(DB_HOST=\\).*|\\1$localhost|" "$APP_PATH/.env"
  sed -i "s|^\\(DB_DATABASE=\\).*|\\1$DB_NAME|" "$APP_PATH/.env"
  sed -i "s|^\\(DB_USERNAME=\\).*|\\1$DB_USER|" "$APP_PATH/.env"
  sed -i "s|^\\(DB_PASSWORD=\\).*|\\1$USER_PASS|" "$APP_PATH/.env"
  sed -i "s|^\\(APP_URL=\\).*|\\1http://$WEB_ADDR|" "$APP_PATH/.env"



