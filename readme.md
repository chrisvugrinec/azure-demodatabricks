<img width="1998" alt="image" src="https://github.com/chrisvugrinec/azure-demodatabricks/assets/24852199/e5f02b98-57ed-4871-84d7-2c19d4b80efb">


# Pre requisites

- Login with the proper credentials
- Make sure you got access to a storage account 
- Configure the main.tf with the proper credentials
 
# Create initial infra for data platform

- Comment out the customers/variables.tf data references (they do not exist yet)
- terraform init
- terraform apply

# Provision databricks platform for customer

- ./provisionCustomer.sh [ name of solution ]; will create datatbricks workspace, storage account, database into a seperate resourcegroup
- ./createDocumentation.sh [ name of solution ]; will create documentation in the customers-documentation folder
