param(
    [Parameter(Mandatory=$true, HelpMessage="Name of State Service to be created")][String] $Name
) 

echo on


New-SPStateServiceApplication -Name $Name
