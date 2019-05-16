#run updates
apt-get update -y
#check

#nginx
apt-get install nginx -y


#firewall settings
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'OpenSSH'
sudo ufw --force enable
sudo ufw status

#to add
#sql
#set sql p/w to allow silent install
#debconf-set-selections <<< 'mysql-server mysql-server/root_password password your_password'
#debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password your_password'
#apt-get -y install mysql-server

#mysql_secure_installation
#END to add

#php
apt-get install php-fpm php-mysql -y
cp /home/ubuntu/php.ini /etc/php/7.0/fpm/php.ini
systemctl restart php7.0-fpm

#nginx - php
cp /home/ubuntu/default /etc/nginx/sites-available/
#config file debugging
#sudo nginx -t
systemctl reload nginx

#copy "index.php to nginx root
cp /home/ubuntu/index.php /var/www/html/index.php
