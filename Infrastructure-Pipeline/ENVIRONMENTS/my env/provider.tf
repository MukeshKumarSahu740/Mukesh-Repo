terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.11.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "skdmp"  
    storage_account_name = "skdmpstg"                      
    container_name       = "azcontainer"                       
    key                  = "terraform.tfstate"        
  }
}

provider "azurerm" {
  features {}
  subscription_id = "41f6bdb1-3632-4ed7-8d47-0f6cc9b855f7"
}