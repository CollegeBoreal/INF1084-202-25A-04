# Informations de l'étudiant
$studentNumber   = 300151608
$studentInstance = 0

# Noms de domaine
$domainName  = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Informations de sécurité (mot de passe du prof)
$plain  = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred   = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)
