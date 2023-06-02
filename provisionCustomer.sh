OPL_tmp=$1
OPL=`echo ${OPL_tmp:0:1} | tr  '[a-z]' '[A-Z]'`${OPL_tmp:1}



echo "Aanmaken van Dataplatform oplossing: $OPL "
echo ""

# RG
cp ./templates/rg.template customers/${OPL}-rg.tf
sed -i -e 's/___OPL___/'$OPL'/g' customers/${OPL}-rg.tf

# Databricks
cp ./templates/databricks.template customers/${OPL}-databricks.tf
sed -i -e 's/___OPL___/'$OPL'/g' customers/${OPL}-databricks.tf

# Storage
cp ./templates/storage.template customers/${OPL}-storage.tf
sed -i -e 's/___OPL___/'$OPL'/g' customers/${OPL}-storage.tf

# Keyvault
cp ./templates/keyvault.template customers/${OPL}-keyvault.tf
sed -i -e 's/___OPL___/'$OPL'/g' customers/${OPL}-keyvault.tf

# Databases
cp ./templates/database.template customers/${OPL}-database.tf
sed -i -e 's/___OPL___/'$OPL'/g' customers/${OPL}-database.tf

# cp ./templates/rbac.template customers/${OPL}-rbac.tf
# sed -i -e 's/___OPL___/'$OPL'/g' customers/${OPL}-rbac.tf
# sed -i -e 's/___OPL-GRPID___/'$objectIdGroup'/g' customers/${OPL}-rbac.tf



# NETWORK


highestIP=$(az network vnet show -g rg-cctopleiding-demodatabricks -n vnet-demodatabricks-services --query subnets[].addressPrefix -o tsv | sed 's/\/.*//g' | sed 's/"//g' | sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n | tail -1)
#blok=$(az network vnet show -g rg-cctopleiding-demodatabricks -n vnet-demodatabricks-services  --query "subnets[].{name:name,ap:addressPrefix}[?name=='snet-demodatabricks-customers']" | jq -r .[].ap)
highestBlock=$(echo $highestIP | cut -d "." -f 3 | sed 's/\/[20].*$//')

echo "hoogste IP Adres van Subnet SNET-DEMODATABRICKS-CUSTOMERS: $highestBlock"
nextIPBlock=$((highestBlock+1))

echo "snet-demodatabricks-customers${OPL}Pub with CIDR: 10.0.$nextIPBlock.0/26"
echo "variable \"snet-demodatabricks-customers${OPL}Pub\" { default = \"10.0.$nextIPBlock.0/26\" }" > customers/${OPL}-variables.tf

echo "snet-demodatabricks-customers${OPL}Prv with CIDR: 10.0.$nextIPBlock.64/26"
echo "variable \"snet-demodatabricks-customers${OPL}Prv\" { default = \"10.0.$nextIPBlock.64/26\" }" >> customers/${OPL}-variables.tf

echo "snet-demodatabricks-customers${OPL}Endpoints with CIDR: 10.0.$nextIPBlock.128/26"
echo "variable \"snet-demodatabricks-customers${OPL}Endpoints\" { default = \"10.0.$nextIPBlock.128/26\" }" >> customers/${OPL}-variables.tf

cp ./templates/subnet.template customers/${OPL}-subnet.tf
sed -i -e 's/___OPL___/'$OPL'/g' customers/${OPL}-subnet.tf


# cleanup tmp files
find ./customers -name \*tf-e -exec rm {} \;
