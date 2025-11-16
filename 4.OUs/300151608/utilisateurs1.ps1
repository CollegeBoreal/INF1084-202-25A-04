. "$(Join-Path $PSScriptRoot 'bootstrap.ps1')"
Import-Module ActiveDirectory

# Vérifier le domaine et les contrôleurs de domaine
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# Créer OU=Students si elle n'existe pas déjà
if (-not (Get-ADOrganizationalUnit -LDAPFilter '(ou=Students)' -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local" -Credential $cred
}
