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

# bootstrap.ps1

# ==========================================================
# 1. Student information (MATCHES YOUR REAL DOMAIN)
# ==========================================================

$studentNumber   = 999999999      # Domain root from Get-ADDomain → DC999999999
$studentInstance = 0              # Instance shown in your domain → DC999999999-00

# ==========================================================
# 2. Domain names generated from student number + instance
# ==========================================================

$domainName  = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# ==========================================================
# 3. Security credentials (default password used in the TP)
# ==========================================================

$plain  = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred   = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

# ==========================================================
# 4. Import Active Directory module
# ==========================================================

Import-Module ActiveDirectory

Write-Host "Domain FQDN : $domainName"
Write-Host "NetBIOS     : $netbiosName"

# ==========================================================
# 5. Check domain connectivity (optional)
# ==========================================================

Get-ADDomain -Server $domainName
