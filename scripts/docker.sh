#!/bin/bash
sudo docker system prune
sudo docker rmi $(docker images -aq)
docker login
sudo docker build -t andrewbarrett18/spring-petclinic-frontend:latest ./spring-petclinic-angular
sudo docker build -t andrewbarrett18/spring-petclinic-backend:latest .

sudo docker push andrewbarrett18/spring-petclinic-frontend:latest
sudo docker push andrewbarrett18/spring-petclinic-backend:latest

source ~/.bashrc