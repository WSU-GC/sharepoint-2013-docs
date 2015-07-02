param(
    [Parameter(Mandatory=$true, HelpMessage="IIS Name & Central Admin Display Name")][String] $Name,
    [Parameter(Mandatory=$true, HelpMessage="url including https:// protocol")][String] $Url,
    [Parameter(Mandatory=$true, HelpMessage="domain\account")][String] $account,
    [Parameter(Mandatory=$true, HelpMessage="domain\account")][String] $account2
) 

echo on

$HostHeader = Read-Host("HostHeader(IIS Server Name Indication)[Optional]: Should be left blank for the App Domain Web App")

$trimmedName = $Name.Replace(" ","_").Replace("-", "_")
$AppPool = "WebApp_" + $trimmedName + "_AppPool"
$DB = "WebApp_" + $trimmedName + "_DB"

$ap = New-SPAuthenticationProvider

if($hostheaders.Length -ne 0) {
    New-SPWebApplication -Name $Name -URL $Url -Port 443 `
    -ApplicationPool $AppPool ` 
    -ApplicationPoolAccount (Get-SPManagedAccount $account) `
    -AuthenticationProvider $ap -SecureSocketsLayer `
    -DatabaseName $DB `
    -HostHeader $HostHeader

} else {
    New-SPWebApplication -Name $Name -URL $Url -Port 443 `
    -ApplicationPool $AppPool ` 
    -ApplicationPoolAccount (Get-SPManagedAccount $account) `
    -AuthenticationProvider $ap -SecureSocketsLayer `
    -DatabaseName $DB
}

