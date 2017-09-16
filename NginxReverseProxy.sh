#!/bin/bash
# ******************************************
# Program: Nginx Reverse Proxy Installation Script
# ******************************************
#    sudo yum -y install redhat-lsb-core;
if [ "`lsb_release -is`" == "Ubuntu" ] || [ "`lsb_release -is`" == "Debian" ]
then
#   lsb_release -rs
    sudo rm /var/lib/apt/lists/lock;
    sudo rm /var/cache/apt/archives/lock;
    sudo rm /var/lib/dpkg/lock;
    sudo apt-get update;
    sudo apt-get -y install apache2 libapache2-mod-fastcgi php-fpm;
    sudo sed -i 's/80/8080/g' /etc/apache2/ports.conf;
    sudo a2enmod actions;
    sudo systemctl restart apache2;
    sudo mv /etc/apache2/mods-enabled/fastcgi.conf /etc/apache2/mods-enabled/fastcgi.conf.bak;
    sudo mv fastcgi-ubuntu-nginxreverseproxy.conf /etc/apache2/mods-enabled/fastcgi.conf;
    sudo echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php;
    sudo apt-get -y install nginx;
    sudo rm /etc/nginx/sites-enabled/default;
    sudo rm /etc/nginx/sites-available/default;
    sudo mv default-ubuntu-nginxreverseproxy.conf /etc/nginx/conf.d/default.conf;
    sudo echo "Install Nginx Reverse Proxy Complete" >> /var/www/html;
    sudo systemctl restart apache2;
    sudo systemctl start nginx;

    sudo echo " Install Nginx Reverse Proxy Complete" >> /var/www/html/index.html;
elif [ "`lsb_release -is`" == "CentOS" ] || [ "`lsb_release -is`" == "RedHat" ]
then
#    sudo yum -y update;
    sudo yum -y install epel-release;
    sudo yum -y install php;
    sudo yum -y install nginx;
    sudo yum -y install httpd;
    sudo systemctl enable nginx;
    sudo systemctl enable httpd;
    sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak;
    sudo mv nginxreverseproxy-centos.conf /etc/nginx/nginx.conf;
    sudo echo "<?php phpinfo(); ?>" >> /var/www/html/info.php;
    sudo sed -i 's/80/127.0.0.1:8080/g' /etc/httpd/conf/httpd.conf;
    sudo echo "Setup Nginx Reverse Proxy Complete" >> /var/www/html/index.html
    sudo systemctl start nginx;
    sudo systemctl start httpd;
    curl -I http://127.0.0.1/
else
    echo "Unsupported Operating System";
fi
