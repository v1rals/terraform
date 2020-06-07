provider "aws" {
  region = "us-east-1"
}

module "task4_s3" {
  source = "./modules/task4_s3"
}

terraform {
  backend "s3" {
    bucket  = "druzev"
    key     = "task4_s3/terraform.tfstate"
    region  = "us-east-1"
  }
}
