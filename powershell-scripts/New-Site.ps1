param(
    [Parameter(Mandatory=$true, HelpMessage="url of the desired site collection")][String] $Url,
    [Parameter(Mandatory=$true, HelpMessage="domain\account the site collection owner")][String] $OwnerAlias
) 

echo on

$Template = Read-Host "Template[Optional]: The site template to use, defaults to STS#0"

if($Template.Length -eq 0) {
    $Template = Get-SPWebTemplate "STS#0"
} else {
    $Template = Get-SPWebTemplate $Template
}

New-SPSite -Url $Url -OwnerAlias $OwnerAlias -Template $Template