appName=$1
echo "# ${appName} documentation:" >./customers-documentation/${appName}.md
echo  "=========================================================="  >>./customers-documentation/${appName}.md
echo  ""

dbricksws=$(az databricks workspace list -g rg-cctopleiding-demodatabricks${appName})
dbrickswsName=$(echo $dbricksws | jq -r .[].name)
dbrickswsCreated=$(echo $dbricksws | jq -r .[].createdDateTime)
dbrickswsURL=$(echo $dbricksws | jq -r .[].workspaceUrl)
dbrickswsId=$(echo $dbricksws | jq -r .[].workspaceId)
echo  "## Databricks: " >>./customers-documentation/${appName}.md
echo  "----------------------------------------------------------" >>./customers-documentation/${appName}.md
echo  "| Name | Created | URL | WSID |" >>./customers-documentation/${appName}.md
echo  "|---|---|---|---|" >>./customers-documentation/${appName}.md
echo  "| $dbrickswsName | $dbrickswsCreated | $dbrickswsURL | $dbrickswsId |" >>./customers-documentation/${appName}.md
echo  "" >>./customers-documentation/${appName}.md


storageAccountNames=$(az storage account list -g rg-cctopleiding-demodatabricks${appName} | jq -r .[].name)
echo  "## Storage Account Databricks: "  >>./customers-documentation/${appName}.md
echo  "----------------------------------------------------------"  >>./customers-documentation/${appName}.md
echo  "| Name |"  >>./customers-documentation/${appName}.md
echo  "|--- |"  >>./customers-documentation/${appName}.md
for storageAccountName in $storageAccountNames
do
	storageAccount=$(az storage account show -g rg-cctopleiding-demodatabricks${appName} -n $storageAccountName)
	name=$(echo ${storageAccount} | jq -r .name)
	echo "| ${name} |"  >>./customers-documentation/${appName}.md
done
echo  "" >>./customers-documentation/${appName}.md

keyvaults=$(az keyvault list -g rg-cctopleiding-demodatabricks${appName} --query [].name -o tsv)
echo  "## Keyvault: "  >>./customers-documentation/${appName}.md
echo  "----------------------------------------------------------"  >>./customers-documentation/${appName}.md
echo  "| Name |"  >>./customers-documentation/${appName}.md
echo  "|--- | "  >>./customers-documentation/${appName}.md
for keyvault in $keyvaults
do
  echo "| ${keyvault} |"  >>./customers-documentation/${appName}.md
done
echo  "" >>./customers-documentation/${appName}.md

echo  "## Databases: "  >>./customers-documentation/${appName}.md
echo  "----------------------------------------------------------"  >>./customers-documentation/${appName}.md
echo  "| Server Name | Database name | " >>./customers-documentation/${appName}.md
echo  "|---|---| " >>./customers-documentation/${appName}.md
echo  "| sql-demodatabricks-custdb1 | db-demodatabricks-${appName} |" >>./customers-documentation/${appName}.md
echo  ""

