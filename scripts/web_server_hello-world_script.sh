#!/bin/bash

# Actualizar sistema
yum update -y

# Instalar Apache
yum install -y httpd

# Crear directorio web si no existe
mkdir -p /var/www/html

# Configurar permisos
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Crear página web
echo "Bienvenido a nuestro servidor web de Terraform" > /var/www/html/index.html

# Configurar Apache
systemctl start httpd
systemctl enable httpd

# Verificar estado de Apache
systemctl status httpd