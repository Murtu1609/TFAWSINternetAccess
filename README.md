# TFAWSINternetAccess
terraform script to provide internet access to an existing vpc using public subnet, internet gateway and nat gateway

# Usage
download this folder and edit the terraform.tfvars as per your requirement. route to the nat gateway is created in the main route table of the vpc, hence internet access will only get enabled for subnets using the main route table.
