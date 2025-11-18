Import-Module ActiveDirectory
. .\bootstrap.ps1

# ÉTAPE 10 : Créer une OU "Students"
# Vérifier si l'OU existe
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -Server $domainName -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local" -Server $domainName
}

# Déplacer l'utilisateur depuis CN=Users
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Server $domainName

# Vérifier le déplacement
Get-ADUser -Identity "alice.dupont" -Server $domainName | Select-Object Name, DistinguishedName
