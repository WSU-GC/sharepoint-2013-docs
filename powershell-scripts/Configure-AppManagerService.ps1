param(
    [Parameter(Mandatory=$true, HelpMessage="domain\account")][String] $account
) 

echo on

$Name = AppManager
$AppName = $Name + "App"
$AppPool = "Service_" + $Name + "_AppPool"
$DB = "Service_" + $Name + "_DB"
$acc = Get-SPManagedAccount $account

$service = Get-SPServiceInstance | where{$_.GetType().Name -eq "AppManagementServiceInstance"}
if($service.Status -ne "Online") {
    Start-SPServiceInstance $service
}

$appPoolAppSvc = New-SPServiceApplicationPool -Name $AppPool -Account $acc
$appSvc = New-SPAppManagementServiceApplication -ApplicationPool $appPoolAppSvc -Name $AppName -DatabaseName $DB
$proxyAppSvc = New-SPAppManagementServiceApplicationProxy -ServiceApplication $appSvc