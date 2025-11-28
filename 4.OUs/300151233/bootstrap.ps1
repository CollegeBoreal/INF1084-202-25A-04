# vos informations
$studentNumber = 300151233
$studentInstance = "00"

# les noms respectifs
$domainName = "DC300151233-00.local"
$netbiosName = "DC300151233-00"

# les informations de sécurité
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

