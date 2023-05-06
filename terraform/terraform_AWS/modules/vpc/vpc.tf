# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Create a Route Table
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Create a Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "my_rta" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_rt.id
}

# Create a Security Group
resource "aws_security_group" "my_sg" {
  name_prefix = "my_sg_"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EBS Volume
resource "aws_ebs_volume" "my_volume" {
  availability_zone = "us-west-2a"
  size              = 10
}

# Create the first EC2 Instance
resource "aws_instance" "my_instance_1" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_id   = aws_ebs_volume.my_volume.id
  }
}

# Create the second EC2 Instance
resource "aws_instance" "my_instance_2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_id   = aws_ebs_volume.my_volume.id
  }
}
