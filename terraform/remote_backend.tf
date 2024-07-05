terraform {
  backend "s3" {
    bucket         = "terraform-state-backend-4993" # change it to the name of the name of your bucket
    key            = "remote"
    region         = "eu-north-1"
    dynamodb_table = "terraform-statelock"
  }
}
