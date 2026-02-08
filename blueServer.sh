#!/bin/bash

yum update -y
yum install -y httpd wget unzip

cd /tmp

wget https://github.com/startbootstrap/startbootstrap-agency/archive/refs/heads/gh-pages.zip

unzip gh-pages.zip

cp -r */* /var/www/html/

systemctl start httpd
systemctl enable httpd
