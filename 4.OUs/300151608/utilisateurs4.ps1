. $(Join-Path  'bootstrap.ps1')
Import-Module ActiveDirectory

# S'assurer que OU=Students existe
if (-not (Get-ADOrganizationalUnit -LDAPFilter '(ou=Students)' -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=,DC=local" -Credential 
}

# Déplacer l'utilisateur vers OU=Students
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=,DC=local" 
  -TargetPath "OU=Students,DC=,DC=local" -Credential 

# Vérifier
Get-ADUser -Identity "alice.dupont" | Select-Object Name,DistinguishedName

# (Optionnel) Supprimer l'utilisateur
# Remove-ADUser -Identity "alice.dupont" -Confirm:False -Credential 
