# postgresql_1c ubuntu
Установка PostgreSQL

1. Настраиваем локаль:
dpkg-reconfigure locales
Выбрать ru_RU.UTF-8 UTF-8
В следующем окне выбрать ru_RU.UTF-8

2. Устанавливаем PostgreSQL Pro 13
curl -o apt-repo-add.sh https://repo.postgrespro.ru/pg1c-13/keys/apt-repo-add.sh
sh apt-repo-add.sh

Если наш продукт единственный Postgres на вашей машине и вы хотите
сразу получить готовую к употреблению базу:

apt-get install postgrespro-1c-13

Если у вас уже установлен другой Postgres и вы хотите чтобы он
продолжал работать параллельно (в том числе и для апгрейда с более
старой major-версии):

apt-get install postgrespro-1c-13-contrib
/opt/pgpro/1c-13/bin/pg-setup initdb
/opt/pgpro/1c-13/bin/pg-setup service enable
/opt/pgpro/1c-13/bin/pg-setup service start

3. Останавливаем сервис postgrespro-1c-13
systemctl stop postgrespro-1c-13

4. Удаляем содержимое каталога data:
rm -rf /var/lib/pgpro/1c-13/data/

5. Инициализируем базу:
/opt/pgpro/1c-13/bin/pg-setup initdb --tune=1c --locale=ru_RU.UTF-8

6. Запускаем сервис postgrespro-1c-13
systemctl start postgrespro-1c-13

7. Задаем пароль для пользователя postgres:
sudo -u postgres psql -U postgres -d template1 -c "ALTER USER postgres PASSWORD 'password'"; history -d $((HISTCMD-1))
команда history -d $((HISTCMD-1)) удаляет из истории строку с паролем.


