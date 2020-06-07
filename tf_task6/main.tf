provider "aws" {
  region = "us-east-1"
}

module "task6_s3" {
  source = "./modules/task6_s3"
}

terraform {
  backend "s3" {
    bucket  = "druzev2"
    key     = "task6_s3/terraform.tfstate"
    region  = "us-east-1"
  }
}
