# === Informations de l'étudiant ===
$studentNumber = 300151841
$studentInstance = 0

# === Noms du domaine ===
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# === Informations d'identification ===
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)
