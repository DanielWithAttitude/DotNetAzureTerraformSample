terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name = "terraform-rg-blobstore"
    storage_account_name = "tfstoragedanielw"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
}


provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "terraform_test" {
    name = "mainrg"
    location = "westeurope"
}

resource "azurerm_container_group" "terraform_congrp" {
    name = "weatherapi"
    location = azurerm_resource_group.terraform_test.location
    resource_group_name = azurerm_resource_group.terraform_test.name

    ip_address_type = "Public"
    dns_name_label = "testsite"
    os_type = "Linux"

    container {
        name = "weatherapi"
        image = "daniel2299/weatherapi:RELEASE.0.0.2"
        cpu = "1"
        memory = "1"
        ports {
          port = 80
          protocol = "TCP"
        }
    }
}

