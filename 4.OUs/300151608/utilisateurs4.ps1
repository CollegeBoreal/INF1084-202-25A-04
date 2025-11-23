. "$(Join-Path $PSScriptRoot 'bootstrap.ps1')"
Import-Module ActiveDirectory

# Vérifier si l'OU Students existe, sinon la créer
if (-not (Get-ADOrganizationalUnit -LDAPFilter '(ou=Students)' -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local" -Credential $cred
}

# Déplacer l'utilisateur Alice Dupont vers OU=Students
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
  -TargetPath "OU=Students,DC=$netbiosName,DC=local" -Credential $cred

# Vérifier que le déplacement a bien été effectué
Get-ADUser -Identity "alice.dupont" | Select-Object Name,DistinguishedName

# (Optionnel) Supprimer l'utilisateur
# Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred

