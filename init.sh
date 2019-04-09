sudo apt-get update -y
sudo apt-get install nginx -y
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'OpenSSH'
sudo ufw enable
sudo ufw status
