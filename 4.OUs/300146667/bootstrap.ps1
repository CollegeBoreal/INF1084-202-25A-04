$studentNumber = 300146667
$studentInstance = ""

$domainName = "DC$studentNumber.local"
$netbiosName = "DC$studentNumber"

$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)
