# Script configuré par : Tasnim (300145940)
# Objectif : Préparation des variables nécessaires au domaine et affichage des informations AD

# Définition de l'identifiant étudiant et de l'instance associée
$studentNumber   = 300141570
$studentInstance = 0

# Construction dynamique du nom de domaine (FQDN) et du NetBIOS
$domainName  = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Création des informations d'identification pour le compte Administrateur
$plain  = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred   = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

# Chargement du module Active Directory pour utiliser les cmdlets AD
Import-Module ActiveDirectory

# Affichage des informations de domaine calculées
Write-Host "Domain FQDN : $domainName"
Write-Host "NetBIOS     : $netbiosName"

# Récupération des informations du domaine Active Directory
Get-ADDomain -Server $domainName

# Obtention de la liste des contrôleurs de domaine actifs
Get-ADDomainController -Filter * -Server $domainName

