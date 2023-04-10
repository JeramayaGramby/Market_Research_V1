resource "aws_vpc" "production_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production-vpc"
  }
}

resource "aws_internet_gateway" "production_gateway" {
  vpc_id = aws_vpc.production_vpc.id

  tags = {
    Name = "production-internet-gateway"
  }
}

resource "aws_route_table" "production_route_table" {
  vpc_id = aws_vpc.production_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.production_gateway.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.production_gateway.id
  }

  tags = {
    Name = "production-route-table"
  }
}

resource "aws_subnet" "production_subnet_1" {
  vpc_id     = aws_vpc.production_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "production-subnet-1"
  }
}

resource "aws_route_table_association" "production_route_table_association" {
  subnet_id      = aws_subnet.production_subnet_1.id
  route_table_id = aws_route_table.production_route_table.id
}

resource "aws_security_group" "production_web_security_group_1" {
  name        = "web_controller"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.production_vpc.id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "production-web-security-group-1"
  }
}
resource "aws_network_interface" "production_web_server" {
  subnet_id       = aws_subnet.production_subnet_1.id
  private_ips     = ["10.0.2.50"]
  security_groups = [aws_security_group.production_web_security_group_1.id]

}

resource "aws_eip" "eip_1" {
  vpc                       = true
  network_interface         = aws_network_interface.production_web_server.id
  associate_with_private_ip = "10.0.2.50"
  depends_on                =  [aws_internet_gateway.production_gateway]
}

resource "aws_instance" "production_web_server_instance" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "KeyPair1"

  network_interface {
    network_interface_id = aws_network_interface.production_web_server.id
    device_index         = 0
  }
# These commands are run inside of the instance as soon as it's created
# All of the below needs to be changed so it can run main.py
  user_data = <<-EOF
                #!/bin/bash
                sudo apt install apache2 -y
                sudo apt install git -y
                sudo apt install docker -y
                sudo apt install kubectl -y
                sudo systemctl start docker
                sudo bash -c 'echo Production Server Successfully Initialized! > /var/www/html/index.html'
                EOF


  tags = {
    Name = "production-web-server-instance"
  }
}
output "server_ip_address" {
  value = aws_eip.eip_1.public_ip
}
output "server_private_ip_address" {
  value = aws_eip.eip_1.private_ip
}
output "web_server_ami" {
  value = aws_instance.production_web_server_instance.ami
}
output "vpc_arn" {
  value = aws_vpc.production_vpc.arn
}