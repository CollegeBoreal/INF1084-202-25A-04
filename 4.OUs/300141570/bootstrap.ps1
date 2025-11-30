$studentNumber   = 300141570
$studentInstance = 0

$domainName  = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

$plain  = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred   = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

Import-Module ActiveDirectory

Write-Host "Domain FQDN : $domainName"
Write-Host "NetBIOS     : $netbiosName"

Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

