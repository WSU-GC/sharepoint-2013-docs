param(
    [Parameter(Mandatory=$true, HelpMessage="domain\account")][String] $account
) 

echo on

$Name = SubscriptionSettings
$AppName = $Name + "App"
$AppPool = "Service_" + $Name + "_AppPool"
$DB = "Service_" + $Name + "_DB"
$acc = Get-SPManagedAccount $account

$service = Get-SPServiceInstance | where{$_.GetType().Name -eq "SPSubscriptionSettingsServiceInstance"}
if($service.Status -ne "Online") {
    Start-SPServiceInstance $service
}

$appPoolSubSvc = New-SPServiceApplicationPool -Name $AppPool -Account $acc
$appSubSvc = New-SPSubscriptionSettingsServiceApplication -ApplicationPool $appPoolSubSvc -Name $AppName -DatabaseName $DB
$proxySubSvc = New-SPSubscriptionSettingsServiceApplicationProxy -ServiceApplication $appSubSvc