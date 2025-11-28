###############################
# utilisateurs1.ps1
# Initialisation du domaine
###############################

# Vos informations étudiantes
$studentNumber = 300098957
$studentInstance = 40

# Noms dérivés
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

Write-Host "Domaine FQDN      : $domainName"
Write-Host "Nom NetBIOS       : $netbiosName"

# Informations de sécurité
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

# Importer le module AD
Import-Module ActiveDirectory

# Vérifications
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
