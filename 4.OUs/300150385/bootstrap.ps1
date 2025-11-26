# --- bootstrap.ps1 ---
# Informations de l'étudiant
$studentNumber = 300150385
$studentInstance = 0

# Noms du domaine et du NetBIOS
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Informations de sécurité (mot de passe administrateur)
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

Write-Host "✅ Domaine chargé : $domainName"
Write-Host "✅ Identifiants prêts pour : Administrator@$domainName"
