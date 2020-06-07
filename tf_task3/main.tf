provider "aws" {
  region = "us-east-1"
}

module "task3_lambdas" {
  source = "./modules/task3"
}

terraform {
  backend "s3" {
    bucket  = "druzev2"
    key     = "task3/terraform.tfstate"
  }
}
