# bootstrap.ps1
# =====================
# Informations personnelles
$studentNumber = 300141368
$studentInstance = 0  

# Noms de domaine
$domainName = "DC300141368-0.local"
$netbiosName = "DC300141368-0"

# Sécurité
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)
