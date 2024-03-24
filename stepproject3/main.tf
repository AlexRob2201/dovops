provider "aws" {
  region  = "eu-central-1"
  profile = "mfa"
}


module "step3_vpc" {
  source = "./modules/vpc"

  name = "bukhenko-vpc-step3"
  cidr = "192.168.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  public_subnets  = ["192.168.6.0/24", "192.168.5.0/24", "192.168.4.0/24"]

  enable_nat_gateway = true

  tags = {
    Owner : "Olexandr Bukhenko",
    CreatedBy : "Bukhenko-step3",
    Purpose : "step3"
  }
}
