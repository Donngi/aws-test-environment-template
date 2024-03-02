provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      repository = "aws-test-environment-template"
      env        = "sample"
    }
  }
}
