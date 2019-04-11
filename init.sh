sudo apt-get update -y

#nginx
sudo apt-get install nginx -y

#firewall settings
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'OpenSSH'
sudo ufw --force enable
sudo ufw status

#sql
#set sql p/w to allow silent install
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password your_password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password your_password'
sudo apt-get -y install mysql-server

#to add
#mysql_secure_installation

#php
sudo apt-get install php-fpm php-mysql -y
sudo cp php.ini /etc/php/7.0/fpm/php.ini
sudo systemctl restart php7.0-fpm

#nginx - php
sudo cp default /etc/nginx/sites-available/
#config file debugging
#sudo nginx -t
sudo systemctl reload nginx

