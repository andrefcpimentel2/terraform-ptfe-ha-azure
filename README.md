# Readme for the Demo

## What you need

1. terraform 11 cli
2. DNS domain hosted by azure
3. Terrafrom License file
4. SSL certificate  (2048) wildcard
5. azure login
6. service principal id

## Populate the variables

variable "tenant_id" {}
variable "object_id" {}
variable "application_id" {}
variable "certificate_path" {}
variable "cert_password" {}
variable "license_file" {}
variable "domain" {}
variable "domain_rg_name" {}
variable "prefix" {}
variable "owner_name" {}
variable "location" {}
variable "resource_prefix" {}

You can do this with a terraform.tfvars file or you could use terraform cloud.

## Deploy

Run the commands

```terraform init```

```terraform plan```

```terraform apply```
