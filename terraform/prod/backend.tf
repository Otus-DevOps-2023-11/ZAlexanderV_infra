terraform {
  #  required_providers {
  #    yandex = {
  #      source = "yandex-cloud/yandex"
  #    }
  #  }
  #  required_version = ">= 0.13.0"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket                      = "tf-backend-b1gdpe4f6jqggbrpqgsr"
    region                      = "ru-central1"
    key                         = "terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }

}
