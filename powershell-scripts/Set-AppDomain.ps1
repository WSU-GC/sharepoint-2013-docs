param(
    [Parameter(Mandatory=$true, HelpMessage="app domain without the protocol")][String] $Domain,
    [Parameter(Mandatory=$true, HelpMessage="app domain without the protocol")][String] $Prefix
) 

echo on

Set-SPAppDomain $Domain
Set-SPAppSiteSubscriptionName -Name $Prefix -Confirm:$false