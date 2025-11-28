# ================================
# Fichier : bootstrap.ps1
# Objectif : Initialiser le domaine étudiant
# ================================

# Ton numéro étudiant et instance
$studentNumber = 300151292
$studentInstance = 0

# Nom complet du domaine et NetBIOS
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Identifiants de l’administrateur
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

# Vérification à l'écran
Write-Host "✅ Domaine : $domainName"
Write-Host "✅ NetBIOS : $netbiosName"
Write-Host "✅ Identifiant : Administrator@$domainName"
