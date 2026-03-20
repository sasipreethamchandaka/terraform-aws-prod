############################################
# 📌 SECURITY GROUP (VERY IMPORTANT)
############################################
resource "aws_security_group" "bastion_sg" {
  name   = "bastion-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow SSH from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # later restrict to your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

############################################
# 📌 BASTION EC2
############################################
resource "aws_instance" "bastion" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet

  key_name = "my-key"

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "Bastion-Host"
  }
}
