#!/bin/bash
sudo apt-get update
sudo apt-get -y upgrade
# Устанавливаем русский язык
sudo apt-get -y install locales
echo 'LANG="ru_RU.UTF-8"' | sudo tee -a /etc/environment 
echo 'ru_RU.UTF-8 UTF-8' | sudo tee -a /etc/locale.gen
sudo locale-gen
# Устанавливаем PostgreSQL Pro 13
curl -o apt-repo-add.sh https://repo.postgrespro.ru/pg1c-13/keys/apt-repo-add.sh
sudo sh apt-repo-add.sh
sudo apt-get -y install postgrespro-1c-13
sudo systemctl stop postgrespro-1c-13
sudo  rm -rf /var/lib/pgpro/1c-13/data/
sudo /opt/pgpro/1c-13/bin/pg-setup initdb --tune=1c --locale=ru_RU.UTF-8
sudo systemctl start postgrespro-1c-13
# Задаем пароль для пользователя postgres ИЗМЕНИТЬ ПАРОЛЬ и имя на свои. Команда history -d $((HISTCMD-1)) удаляет из истории строку с паролем
sudo -u postgres psql -U postgres -d template1 -c "ALTER USER postgres PASSWORD 'password'"; history -d $((HISTCMD-1))