param(
    [Parameter(Mandatory=$true, HelpMessage="Name of State Service Database")][String] $DBName,
    [Parameter(Mandatory=$true, HelpMessage="Name of State Service Application")][String] $AppName,
    [Parameter(Mandatory=$true, HelpMessage="Name of application pool for secure store")][String] $SSAppPool,
    [Parameter(Mandatory=$true, HelpMessage="Database name for secure store")][String] $SSDBName,
    [Parameter(Mandatory=$true, HelpMessage="Service application name for secure store")][String] $SSAppName,
    [Parameter(Mandatory=$true, HelpMessage="Secure store application proxy name")][String] $SSAppProxyName,
    [Parameter(Mandatory=$true, HelpMessage="Account used for creating the secure store app pool (domain\username)")][String] $SSAccountForAppPool,  
    [Parameter(Mandatory=$true, HelpMessage="BCS application pool name")][String] $BCSAppPool,
    [Parameter(Mandatory=$true, HelpMessage="BCS Database name")][String] $BCSDatabaseName,
    [Parameter(Mandatory=$true, HelpMessage="BCS service application name")][String] $BCSAppName,
    [Parameter(Mandatory=$true, HelpMessage="Account used for creating the BCS app pool (domain\username)")][String] $BCSAccountForAppPool
) 

echo on

#Configure State Service
New-SPStateServiceDatabase -Name $DBName | New-SPStateServiceApplication -Name $AppName | New-SPStateServiceApplicationProxy -DefaultProxyGroup

Write-Host "State Service has been configured"
Read-Host "Press ENTER to continue"

#Configure Secure Store

$appPoolSubSvc = New-SPServiceApplicationPool -Name $SSAppPool -Account $SSAccountForAppPool 
$NewlyCreatedSSApp = New-SPSecureStoreServiceApplication -ApplicationPool $SSAppPool -AuditingEnabled:$false -DatabaseName $SSDBName -Name $SSAppName
New-SPSecureStoreServiceApplicationProxy -Name $SSAppProxyName -ServiceApplication $NewlyCreatedSSApp

Write-Host "Secure Store Service has been configured"
Read-Host "Press ENTER to continue"

#This might offer a way to map the group getting access, but doesnt seem right (needs PW)...for now that will need to be manually added
#$ssApp = Get-SPSecureStoreApplication -ServiceContext http://contoso -Name "ContosoGroupTargetApplication"
#$firstCredential = ConvertTo-SecureString "LOBDATABASE\fulltimeemployees" -AsPlainText -Force
#$secondCredential = ConvertTo-SecureString "abcDEF123$%^" -AsPlainText -Force
#$credentialValues = $firstCredential,$secondCredential
#Update-SPSecureStoreGroupCredentialMapping -Identity $ssApp -Values $credentialValues

Write-Host "You will need to generate key and manually map a group to the secure store target app to grant access"
Read-Host "Press ENTER to continue"

#Configure Busines Connectivity Services
$appPoolSubSvc = New-SPServiceApplicationPool -Name $BCSAppPool -Account $BCSAccountForAppPool 
$NewlyCreatedBCSApp = New-SPBusinessDataCatalogServiceApplication -ApplicationPool $BCSAppPool -DatabaseName $BCSDatabaseName -Name $BCSAppName

Write-Host "BCS Service has been configured"
Read-Host "Press ENTER to continue"
