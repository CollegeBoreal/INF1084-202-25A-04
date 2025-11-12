# TP_AD_Users_300151841.ps1
# Exporter la liste des utilisateurs du domaine dans un CSV

. "$PSScriptRoot\bootstrap.ps1"

Get-ADUser -Filter * -Server "$domainName" -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "$PSScriptRoot\TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
