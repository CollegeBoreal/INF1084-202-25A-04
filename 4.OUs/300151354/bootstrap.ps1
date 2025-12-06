# ============================
# bootstrap.ps1
# Chargement des informations du domaine et des credentials
# ============================

# Numéro étudiant + instance  (À MODIFIER selon ton domaine)
$studentNumber = 300151354
$studentInstance = 0

# Domaines générés automatiquement
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

Write-Host "Domain FQDN : $domainName"
Write-Host "Domain NetBIOS : $netbiosName"

# Mot de passe fourni pour le TP
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force

# Credential administrateur
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

# Importer Active Directory
Import-Module ActiveDirectory

Write-Host "`nModule AD chargé avec succès.`n"

# Vérification du domaine
Write-Host "Vérification du domaine..."
Get-ADDomain -Server $domainName

Write-Host "`nContrôleurs de domaine :"
Get-ADDomainController -Filter * -Server $domainName

