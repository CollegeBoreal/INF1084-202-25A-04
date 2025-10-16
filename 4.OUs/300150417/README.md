# TP Gestion des utilisateurs et OUs

## Scripts utilisés

# Importer le module ActiveDirectory
Import-Module ActiveDirectory

# Vérifier le domaine et le contrôleur de domaine
Get-ADDomain
Get-ADDomainController -Filter *

# Créer un nouvel utilisateur Alice Dupont
New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@DC300150417-00.local" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=DC300150417-00,DC=local"

# Créer une OU Students si elle n'existe pas
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=DC300150417-00,DC=local"
}

# Déplacer l'utilisateur dans l'OU Students
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=DC300150417-00,DC=local" `
              -TargetPath "OU=Students,DC=DC300150417-00,DC=local"

# Vérifier l'utilisateur
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName

# TP Gestion des utilisateurs et OUs

## Objectif
Créer et gérer des utilisateurs Active Directory et organiser ces utilisateurs dans des Unités d’Organisation (OUs).

---

## Scripts utilisés

### 1. Importer le module ActiveDirectory
```powershell
Import-Module ActiveDirectory

