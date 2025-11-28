# utilisateurs4.ps1
# Création de l'OU Students, déplacement d'Alice et export CSV

. "$PSScriptRoot\bootstrap.ps1"

# Créer l'OU Students si elle n'existe pas
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students"
}

# Déplacer Alice dans l'OU Students
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=DC300151841-00,DC=local" `
              -TargetPath "OU=Students,DC=DC300151841-00,DC=local"

# Vérifier
Get-ADUser -Identity "alice.dupont" |
Select-Object Name, DistinguishedName

# Export CSV
& "$PSScriptRoot\TP_AD_Users_300151841.ps1"

