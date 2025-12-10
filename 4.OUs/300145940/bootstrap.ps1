# Script configuré par : Tasnim (300145940)
# Objectif : Préparer les variables du domaine AD et afficher un résumé

# Identifiants de l'étudiant
$studentNumber   = 300145940      # <-- mis à jour
$studentInstance = 0

# Construction du nom de domaine (FQDN) et du NetBIOS
$domainName  = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Informations d'identification pour le compte Administrateur du domaine
$adminPasswordPlain  = 'Infra@2024'
$adminPasswordSecure = ConvertTo-SecureString $adminPasswordPlain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential(
    "Administrator@$domainName",
    $adminPasswordSecure
)

# Chargement du module Active Directory
Import-Module ActiveDirectory -ErrorAction Stop

# Affichage des informations calculées
Write-Host "Domaine (FQDN) : $domainName"
Write-Host "Nom NetBIOS    : $netbiosName"
Write-Host ""

# Affichage des infos AD réelles
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
