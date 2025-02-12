module "VPC" {
  source              = "./VPC-code"
  tag                 = "eg-tf"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.4.0/24"]
  private_subnet_cidr = ["10.0.3.0/24", "10.0.8.0/24", "10.0.11.0/24"]
}

module "EC2" {
  source        = "./EC2-code"
  ami           = "ami-0c50b6f7dc3701ddd"
  instance_type = "t2.micro"
  key_name      = "demo-key"
  tags          = "demo-server" 
  public_ip     = true
  subnet_id     = module.VPC.public_subnet_id[0] // this will choose the first public subnet range defined in the var.rf file.
  vpc_id        = module.VPC.vpc_id              // this is for vpc id as it is not deined till the vpc is created.
  security_group = [module.EC2.security_group_id] // this is in brackets because the security-group-ids from vpc will be in list.
  ingress_ports = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "S3" {
  source     = "./S3-code"
  count      = 5
  bucketname = "prathameshs3buckethh-${count.index + 1}"
}

module "IAM" {
  source = "./IAM-code"
  group_tag = "demo"
  given_user = ["user1", "user2"]
  policy_names = ["AmazonEC2FullAccess", "AmazonS3FullAccess"]
}
