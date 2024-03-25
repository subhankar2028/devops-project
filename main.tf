
provider "aws" {
  region     = "us-west-2"
}

resource "aws_ecr_repository" "machine-id-checker" {
  name                 = "machine-id-checker-name"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}