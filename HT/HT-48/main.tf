provider "aws" {
  region  = "eu-central-1"
  profile = "mfa"
}

module "vpc_ec2" {
  source             = "./modules/vpc"
  enable_nat_gateway = true
}

module "security_group_ec2" {
  source = "./modules/sg"
  name   = "bukhenko-sg-ht-48"
  vpc_id = module.vpc_ec2.VPC_ID

}

module "public_ec2" {
  name            = "bukhenko-ec2"
  source          = "./modules/ec2"
  key_name        = "bukhenko-rsa"
  subnet_id       = module.vpc_ec2.public_subnet_id
  security_groups = [module.security_group_ec2.security_group_ids]
}

module "private_ec2" {
  source          = "./modules/ec2"
  name            = "bukhenko-ec2-private"
  key_name        = "bukhenko-rsa"
  subnet_id       = module.vpc_ec2.private_subnet_id
  security_groups = [module.security_group_ec2.security_group_ids]
}
