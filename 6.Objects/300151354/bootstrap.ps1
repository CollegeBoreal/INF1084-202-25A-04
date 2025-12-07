# ==========================================
# bootstrap.ps1
# Initialisation du domaine et des credentials
# ==========================================

# Numéro étudiant + instance
$studentNumber = 300151354
$studentInstance = "00"

# Noms du domaine
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

Write-Host "Domain FQDN  : $domainName"
Write-Host "NetBIOS Name : $netbiosName"

# Credentials
$plain = "Infra@2024"
$secure = ConvertTo-SecureString $plain -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential(
    "Administrator@$domainName",
    $secure
)

# Modules
Import-Module ActiveDirectory
Import-Module GroupPolicy

# Vérification
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

