# TP Active Directory - Partie 4
# Gestion des OU

Import-Module ActiveDirectory

$domainName = "DC300150395-00.local"

# 0 — Recreer Alice si elle n'existe pas
if (-not (Get-ADUser -Filter "SamAccountName -eq 'alice.dupont'" -ErrorAction SilentlyContinue)) {
    New-ADUser -Name "Alice Dupont" `
               -GivenName "Alice" `
               -Surname "Dupont" `
               -SamAccountName "alice.dupont" `
               -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
               -Enabled $true `
               -Path "CN=Users,DC=DC300150395-00,DC=local"
    Write-Host "Utilisateur Alice Dupont recree."
} else {
    Write-Host "Utilisateur deja present."
}

# 1 — Vérifier OU Students
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path "OU=300150395,DC=DC300150395-00,DC=local"
    Write-Host "OU 'Students' creee."
} else {
    Write-Host "OU 'Students' existe deja."
}

# 2 — Déplacer Alice vers Students
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=DC300150395-00,DC=local" `
              -TargetPath "OU=Students,OU=300150395,DC=DC300150395-00,DC=local"

Write-Host "Utilisateur deplace dans l'OU Students."

# 3 — Vérification
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName
