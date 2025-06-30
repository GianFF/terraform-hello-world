#!/bin/bash

# Actualizar sistema
yum update -y

amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user

# Loggear salida por si falla
echo "Instalado Docker y corriendo" >> /var/log/user-data.log

# Autenticarse a DockerHub si es necesario
# echo "PASSWORD" | docker login -u USERNAME --password-stdin

# Correr tu contenedor
docker run -d -p 80:80 nginxdemos/hello
