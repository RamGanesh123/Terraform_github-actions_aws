env = "stage"

vpc_cidr = "10.1.0.0/16"
public_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24"]
azs = ["us-east-1a", "us-east-1b"]

instance_type    = "t2.micro"
allowed_ssh_cidr = "0.0.0.0/0"
