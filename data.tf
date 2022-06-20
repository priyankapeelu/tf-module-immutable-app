data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraformd63"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "terraformd63"
    key    = "alb/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "terraformd63"
    key    = "databases/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket = "terraformd63"
    key    = "iam/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}


data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "${var.COMPONENT}-${var.APP_VERSION}"
  owners      = ["self"]
}


data "aws_secretsmanager_secret" "secrets" {
  name = "${var.ENV}/roboshop/secret"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}