terraform {
  required_providers {
    tfcoremock = {
      source  = "hashicorp/tfcoremock"
      version = "0.2.0"
    }
  }
}

provider "tfcoremock" {}

import {
  to = tfcoremock_dotted.example
  id = "my-example"
}
