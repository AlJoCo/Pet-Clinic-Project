#!/bin/bash
sudo docker system prune -f
# sudo docker rmi $(docker images -aq)
sudo usermod -aG docker $(whoami)
docker login --username $DOCKER_USERNAME --password $DOCKER_PASSWORD

cd spring-petclinic-rest-master/
docker build -t spring-petclinic-rest-master:latest .
cd ..
cd spring-petclinic-angular-master/
docker build -t spring-petclinic-angular-master:latest .

docker tag spring-petclinic-rest-master:latest andrewbarrett18/spring-petclinic-backend:latest
docker tag spring-petclinic-angular-master:latest andrewbarrett18/spring-petclinic-frontend:latest

docker push andrewbarrett18/spring-petclinic-backend
docker push andrewbarrett18/spring-petclinic-frontend

source ~/.bashrc