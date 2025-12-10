$studentNumber = 300141429
$studentInstance = ""

$domainName = "DC$studentNumber.local"
$netbiosName = "DC999999999-00"

$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

#pour se connecter a Etudiant1 on met DC999999999-00\Etudiant1

