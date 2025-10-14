# ============================================
# TP Active Directory - Gestion des utilisateurs
# Étudiant : 300150295
# Domaine : DC300150295-0.local
# ============================================

\ = 300150295
\ = 0
\ = "DC\-\.local"
\ = "DC\-\"

Import-Module ActiveDirectory

Write-Host "🔍 Vérification du domaine : \"
Get-ADDomain -Server \

\ = Get-Credential -Message "Entrez les identifiants de l’administrateur du domaine \"

New-ADUser -Name "Alice Dupont" 
           -GivenName "Alice" 
           -Surname "Dupont" 
           -SamAccountName "alice.dupont" 
           -UserPrincipalName "alice.dupont@\" 
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) 
           -Enabled \True 
           -Path "CN=Users,DC=\,DC=local" 
           -Credential \

if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    Write-Host "🧩 Création de l’OU Students..."
    New-ADOrganizationalUnit -Name "Students" -Path "DC=\,DC=local"
}

Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=\,DC=local" 
              -TargetPath "OU=Students,DC=\,DC=local" 
              -Credential \

Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName

Write-Host "✅ TP terminé avec succès pour \"
