
# export_deplacement.ps1 – Export et déplacement vers OU Students
Import-Module ActiveDirectory
. .\bootstrap.ps1
# Exporter tous les utilisateurs dans un CSV
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8

# Créer l'OU Students si elle n'existe pas
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
}

# Déplacer l'utilisateur vers l'OU Students
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Credential $cred

# Vérifier le déplacement
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName

