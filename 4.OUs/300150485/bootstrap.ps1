# ==============================================
# Script bootstrap.ps1 — INF1084 - OUs
# Étudiant : Nadir FETIS (300150485)
# Domaine du labo : DC999999999-00.local
# Collège Boréal - TP Active Directory (OUs)
# ==============================================

# 1. Informations de base
$domainName  = "DC999999999-00.local"
$netbiosName = "DC999999999-00"
$plain  = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred   = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

Write-Host "=== Début du script pour le domaine $domainName ==="

# 2. Chargement du module AD
if (-not (Get-Module -Name ActiveDirectory -ListAvailable)) {
    Install-WindowsFeature RSAT-AD-PowerShell
}
Import-Module ActiveDirectory

# 3. Vérification du domaine et du contrôleur
Write-Host "`n--- Vérification du domaine et du contrôleur ---"
Get-ADDomain -Server $domainName | Select-Object Name, DNSRoot
Get-ADDomainController -Filter * -Server $domainName | Select-Object HostName, Domain

# 4. Création de l’OU Students
Write-Host "`n--- Vérification / création de l’OU Students ---"
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
    Write-Host "OU 'Students' créée."
}
else {
    Write-Host "OU 'Students' existe déjà."
}

# 5. Création de l’utilisateur Alice Dupont
Write-Host "`n--- Vérification / création de l’utilisateur Alice Dupont ---"
$targetPath = "OU=Students,DC=$netbiosName,DC=local"

if (-not (Get-ADUser -Filter "SamAccountName -eq 'alice.dupont'")) {
    New-ADUser -Name "Alice Dupont" `
      -GivenName "Alice" `
      -Surname "Dupont" `
      -SamAccountName "alice.dupont" `
      -UserPrincipalName "alice.dupont@$domainName" `
      -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
      -Enabled $true `
      -Path $targetPath `
      -Credential $cred
    Write-Host "Utilisateur Alice Dupont créé dans l’OU Students."
}
else {
    Write-Host "L’utilisateur Alice Dupont existe déjà."
}

# 6. Vérification finale
Write-Host "`n--- Vérification de la présence de l’utilisateur ---"
Get-ADUser -Filter "SamAccountName -eq 'alice.dupont'" -Properties DistinguishedName, Enabled |
Select-Object Name, Enabled, DistinguishedName

Write-Host "`n=== Script terminé avec succès pour le domaine $domainName ==="
