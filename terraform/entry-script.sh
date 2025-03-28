#!/bin/bash
sudo yum update -y 
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<h2> Created By Ahmed Samy <h2>" >/var/www/html/index.html