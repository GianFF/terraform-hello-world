# Grupo de seguridad para permitir acceso a la instancia
resource "aws_security_group" "web_server" {
  name        = "terraform-web-sg" # Nombre del grupo de seguridad
  description = "Allow HTTP and SSH"
  vpc_id      = var.vpc_id # Vincula al VPC

  # Regla para permitir HTTP (puerto 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Acceso desde cualquier IP
  }

  # Regla para permitir SSH (puerto 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Acceso desde cualquier IP
  }

  # Regla para permitir todo tráfico de salida
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-web-server-security-group" # Nombre descriptivo
  }
}

# Par de claves SSH para acceso a la instancia
resource "aws_key_pair" "web_server" {
  key_name   = "terraform-web-server-key"
  public_key = file(var.public_key_path)

  tags = {
    Name = "terraform-web-server-key-pair"
  }
}

# Instancia EC2 que ejecutará el servidor web
resource "aws_instance" "web_server" {
  ami           = var.ami
  instance_type = var.instance_type

  # Configuración de red
  vpc_security_group_ids      = [aws_security_group.web_server.id] # Vincula al grupo de seguridad
  subnet_id                   = var.subnet_id                      # Vincula a la subred
  associate_public_ip_address = true                               # Asigna una IP pública 
  key_name                    = aws_key_pair.web_server.key_name   # Usa el par de claves creado

  user_data = var.user_data

  tags = {
    Name = "terraform-web-server-instance"
  }
}

