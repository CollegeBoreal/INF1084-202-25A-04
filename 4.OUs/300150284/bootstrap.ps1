# Informations de l'étudiant
$studentNumber = 300150284
$studentInstance = "00"

# Les noms respectifs
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Les informations de sécurité
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

# Afficher les informations de configuration
Write-Host "=== Configuration Active Directory ===" -ForegroundColor Green
Write-Host "Numéro étudiant: $studentNumber" -ForegroundColor Cyan
Write-Host "Instance: $studentInstance" -ForegroundColor Cyan
Write-Host "Nom de domaine: $domainName" -ForegroundColor Cyan
Write-Host "Nom NetBIOS: $netbiosName" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Green