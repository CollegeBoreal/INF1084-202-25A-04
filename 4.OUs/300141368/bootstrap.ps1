# vos informations
$studentNumber = 300141368
<<<<<<<< HEAD:bootstrap.ps1
$studentInstance = 0
========
$studentInstance = "00"
>>>>>>>> 38adc23bffbf530ed051c8402e537ce9479c9a7c:4.OUs/300141368/bootstrap.ps1

# les noms respectifs
$domainName = "DC300141368-0.local"
$netbiosName = "DC300141368-0"

# les informations de sécurité
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

