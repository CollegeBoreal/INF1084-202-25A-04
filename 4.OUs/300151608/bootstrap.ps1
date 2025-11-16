$studentNumber   = 300151608
$studentInstance = 0
$domainName  = "DC300151608-0.local"
$netbiosName = "DC300151608-0"
$plain  = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred   = New-Object System.Management.Automation.PSCredential("Administrator@DC300151608-0.local", $secure)
