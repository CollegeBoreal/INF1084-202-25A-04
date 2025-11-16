. $(Join-Path  'bootstrap.ps1')
Import-Module ActiveDirectory

# Vérif domaine / DC
Get-ADDomain -Server 
Get-ADDomainController -Filter * -Server 

# Créer OU=Students si n'existe pas
if (-not (Get-ADOrganizationalUnit -LDAPFilter '(ou=Students)' -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=,DC=local" -Credential 
}
