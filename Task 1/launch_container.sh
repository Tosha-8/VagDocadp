#!/bin/bash
printf "creating Nginx image from Dockerfile."
docker build -t nginx_image .
sleep 5
printf "creating webroot directory."
mkdir -p /webroot
printf "Creating a container running on port 80 along with host machine and webroot equal to /var/www/html from the nginx_image."
docker run -d -v /webroot:/var/www/html -p 80:80 --name nginx_image
sleep 10
printf "Checking for the running containers."
docker ps




