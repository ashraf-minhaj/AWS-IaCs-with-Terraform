#!/bin/sh
# set -euo pipefail

db_user_name="$1"
db_admin_pass="$2"

# for visual confirmation that the script ran
touch setup_start1.txt

# variables
## php vars (sudo nano /etc/php/*/fpm/php.ini)
upload_max_filesize=200M
post_max_filesize=500M
memory_limit=512M
# cgi.fix_pathinfo=0
max_execution_time=361

# cd /root
apt update && sudo apt upgrade -y
echo "system update done"

# install mysql
apt-get install mysql-server -y
# set the root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${db_admin_pass}';FLUSH PRIVILEGES;"
systemctl restart mysql

## create new user in mysql
mysql -p${db_admin_pass} -e "CREATE USER '${db_user_name}'@'localhost' IDENTIFIED WITH mysql_native_password BY '${db_admin_pass}';"
mysql -p${db_admin_pass} -e "GRANT ALL PRIVILEGES ON *.* TO '${db_user_name}'@'localhost';"
mysql -p${db_admin_pass} -e "CREATE DATABASE wp;"
mysql -p${db_admin_pass} -e "GRANT ALL PRIVILEGES ON wp.* TO '${db_user_name}'@localhost;"
mysql -p${db_admin_pass} -e "FLUSH PRIVILEGES;"
touch setup_complete_mysql2.txt

# install, setup apache
apt-get install apache2 -y
ufw app list
ufw app info "Apache Full"
ufw allow "Apache Full"
touch setup_complete_apache3.txt

# install and setup php
apt-get install -y  php-dom libapache2-mod-php php-simplexml php-ssh2 php-xml php-xmlreader php-curl php-exif php-ftp php-gd php-iconv php-imagick php-json php-mbstring php-posix php-sockets php-tokenizer php-fpm php-mysql php-gmp php-intl php-cli
## configure php
cd etc/php/
cd *
cd fpm/
# for key in upload_max_filesize post_max_filesize memory_limit max_execution_time
# do
#     sed -i "s/^\($key\).*/\1 $(eval echo = \${$key})/" php.ini
# done
sed -i "s/^\(201M\).*/\1 $(eval echo = \${upload_max_filesize})/" php.ini
sed -i "s/^\(500M\).*/\1 $(eval echo = \${post_max_filesize})/" php.ini
sed -i "s/^\(512M\).*/\1 $(eval echo = \${memory_limit})/" php.ini
sed -i "s/^\(361\).*/\1 $(eval echo = \${max_execution_time})/" php.ini
sed -i "s/^\(361\).*/\1 $(eval echo = \${cgi/.fix_pathinfo})/" php.ini 

systemctl restart php*-fpm.service

cd ../../../../
touch setup_complete_php4.txt

# install wordpress, move to var directory and provide permissions
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
cd /var
mkdir www
cd ../
mv wordpress /var/www/
chown -R www-data:www-data /var/www/wordpress/
chown -R $USER:$USER /var/www/wordpress
chmod -R 755 /var/www/wordpress/
touch setup_complete_wp5.txt

# create .conf file
# /etc/apache2/sites-available/wordpress.conf
echo "<VirtualHost *:80>" > /etc/apache2/sites-available/wordpress.conf
echo "    ServerAdmin webmaster@localhost" >> /etc/apache2/sites-available/wordpress.conf
echo "    ServerName wordpress" >> /etc/apache2/sites-available/wordpress.conf
echo "    ServerAlias www.wordpress" >> /etc/apache2/sites-available/wordpress.conf
echo "    DocumentRoot /var/www/wordpress" >> /etc/apache2/sites-available/wordpress.conf
echo "    ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/wordpress.conf
echo "    CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/wordpress.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/wordpress.conf
touch setup_complete_config6.txt

cd /etc/apache2/sites-available/
a2ensite wordpress.conf
a2dissite 000-default.conf

# restart apache server
systemctl restart apache2
cd ../../../
touch setup_complete_all7.txt

## wordpress.conf file
# <VirtualHost *:80>
#     ServerAdmin webmaster@localhost
#     ServerName wordpress  
#     ServerAlias www.wordpress  
#     DocumentRoot /var/www/wordpress  
#     ErrorLog ${APACHE_LOG_DIR}/error.log
#     CustomLog ${APACHE_LOG_DIR}/access.log combined
# </VirtualHost>