<img width="1998" alt="image" src="https://github.com/chrisvugrinec/azure-demodatabricks/assets/24852199/e5f02b98-57ed-4871-84d7-2c19d4b80efb">

```
Please note that this demo only rolls out the dataplatform spoke....the hub is illustrated as a production example
```

# Pre requisites

- Login with the proper credentials; credentials that are able to create resources in your Azure subscription
- Make sure you got access to an existing storage account; to store the Terraform state 
- Configure the main.tf with the proper credentials
 
# Create initial infra for data platform

- Comment out the customers/variables.tf data references (they do not exist yet)
- terraform init
- terraform apply; after this the required infra (network/ database server) is created
- Remove the Comment out the customers/variables.tf data references; the data reference should exist now


# Provision databricks platform for customer

- ./provisionCustomer.sh [ name of solution ]; will create datatbricks workspace, storage account, database into a seperate resourcegroup
- ./createDocumentation.sh [ name of solution ]; will create documentation in the customers-documentation folder


Please note that this is for demo purposes

For production it is recommended to use the Private Endpoints for network connectivity and configure RBAC based on least priviledged...you can find an initial disabled setup in the code.
