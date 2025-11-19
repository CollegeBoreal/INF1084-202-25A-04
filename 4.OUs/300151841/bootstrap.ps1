# bootstrap.ps1
# Configuration de base pour le TP AD – Massinissa Mameri

# Numéro étudiant et instance
$studentNumber  = 300151841
$studentInstance = 0

# Noms de domaine
$domainName  = "DC$studentNumber-0.local"      # FQDN
$netbiosName = "DC$studentNumber-0"           # NetBIOS

# Mot de passe administrateur du domaine
$plain  = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force

# Identifiants administrateur du domaine
$cred = New-Object System.Management.Automation.PSCredential(
    "Administrator@$domainName",
    $secure
)

# Import du module AD
Import-Module ActiveDirectory
