# utilisateurs4.ps1
# Création de l’OU “Students”, déplacement d’Alice et export CSV

. "$PSScriptRoot\bootstrap.ps1"

# Créer l’OU si elle n’existe pas
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
}

# Déplacer Alice
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local"

# Vérifier le déplacement
Get-ADUser -Identity "Alice Dupont" | Select-Object Name, DistinguishedName

# Exporter en CSV
& "$PSScriptRoot\TP_AD_Users_300150385.ps1"
