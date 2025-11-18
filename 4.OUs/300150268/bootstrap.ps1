# ======================================================
# Bootstrap pour le domaine Active Directory
# Étudiant : Mohand Said Kemiche
# Numéro : 300150268
# Instance : 00
# Domaine : DC300150268-00.local
# ======================================================

# Vos informations
$studentNumber = 300150268
$studentInstance = "00"

# Noms respectifs
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Informations de sécurité
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

Write-Host "Bootstrap chargé pour le domaine $domainName"
