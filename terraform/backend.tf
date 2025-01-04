terraform {
  backend "s3" {
    bucket = "yaniv-terraform-statefile"
    key    = "datagrade/terraform.tfstate"
    region = "eu-central-1"
  }
}
