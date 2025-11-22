# vos informations
$studentNumber = 300141368
$studentInstance = 0

# les noms respectifs
$domainName = "DC300141368-0.local"
$netbiosName = "DC300141368-0"

# les informations de sécurité
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

