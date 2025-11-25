# Informations liées à l'étudiante (Tasnim)
$studentNumber = 300145940
$studentInstance = "00"

# Génération dynamique des noms utilisés pour le domaine Active Directory
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Création des informations d’authentification pour le compte Administrator
$rawPassword = "Infra@2024"
$securePassword = ConvertTo-SecureString $rawPassword -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $securePassword)

# Mise à disposition des valeurs calculées pour d'éventuels traitements ultérieurs
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

