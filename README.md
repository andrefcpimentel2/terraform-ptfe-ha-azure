# Readme for the Demo

## What you need

1. terraform 11 cli (you can use `get_tf.sh`)
2. DNS domain hosted by Azure
3. Terraform License file
4. azure cli logged in

## Populate the variables

```
variable "license_file" {}
variable "domain" {}
variable "domain_rg_name" {}
variable "prefix" {}
variable "owner_name" {}
variable "location" {}
variable "resource_prefix" {}
```

You can do this with a terraform.tfvars file or you could use terraform cloud.


## Deploy

Run the commands
```bash get_tf.sh```

```./create_pfx.sh ric.aws.hashidemos.io```

```./terraform init```

```./terraform plan```

```./terraform apply```
