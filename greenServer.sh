#!/bin/bash

yum update -y
yum install -y httpd wget unzip

cd /tmp

wget https://www.tooplate.com/zip-templates/2153_fireworks_composer.zip

unzip 2153_fireworks_composer.zip

cp -r 2153_fireworks_composer/* /var/www/html/

systemctl start httpd
systemctl enable httpd
