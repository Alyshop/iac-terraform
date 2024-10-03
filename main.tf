provider "aws" {
  region = "us-east-1"  # Substitua pela sua região
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source      = "./ec2"
  vpc_id     = module.vpc.vpc_id
  subnet_id  = module.vpc.private_subnet_ids[0]
}

module "rds" {
  source         = "./rds"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
  db_password     = var.db_password
}

module "s3" {
  source = "./s3"
  bucket_name = var.s3_bucket_name
  iam_role_arn = module.ec2.iam_role_arn
}
