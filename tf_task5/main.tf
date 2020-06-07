provider "aws" {
  region = "us-east-1"
}

module "task5_db" {
  source = "./modules/task5_db"
}

terraform {
  backend "s3" {
    bucket  = "druzev2"
    key     = "task5_db/terraform.tfstate"
    region  = "us-east-1"
  }
}
