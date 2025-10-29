# script4_MoveUser.ps1

$studentNumber = 300141429
$studentInstance = 00
$domainName = "DC300141429.local"
$netbiosName = "DC300141429"

Import-Module ActiveDirectory
$cred = Get-Credential  # Saisir Administrator@$domainName

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

