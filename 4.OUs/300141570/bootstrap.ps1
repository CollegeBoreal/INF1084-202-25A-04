Import-Module ActiveDirectory -ErrorAction Stop

$domain      = Get-ADDomain
$domainName  = $domain.DNSRoot
$netbiosName = $domain.NetBIOSName

$plain  = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred   = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

Write-Host "Domain FQDN : $domainName"
Write-Host "NetBIOS     : $netbiosName"
