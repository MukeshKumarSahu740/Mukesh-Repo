terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "azurerm" {
  subscription_id = "e6a4a2ba-47b8-4c10-9107-e4717f4ba04e"
  features {}
}
provider "random" {}



