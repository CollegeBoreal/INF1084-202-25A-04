# ============================
# TP Active Directory – OUs
# Étudiant : Mohand Said Kemiche
# ID : 300150268
# Domaine : DC300150268-40.local
# ============================

# 1️⃣ Variables de base
$studentNumber = 300150268
$studentInstance = "40"

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# 2️⃣ Importer le module Active Directory
Import-Module ActiveDirectory

# 3️⃣ Afficher des informations sur le domaine
Write-Host "---- Informations du domaine ----" -ForegroundColor Cyan
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# 4️⃣ Lister les utilisateurs actuels
Write-Host "`n---- Utilisateurs actifs ----" -ForegroundColor Yellow
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName

# 5️⃣ Créer OU Students si elle n’existe pas
Write-Host "`n---- Vérification OU Students ----" -ForegroundColor Cyan
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -Server $domainName)) {
    Write-Host "OU Students non trouvée → Création..." -ForegroundColor Green
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
} else {
    Write-Host "OU Students déjà existante." -ForegroundColor Green
}

# 6️⃣ Création d'un utilisateur exemple (Alice Dupont)
Write-Host "`n---- Création utilisateur : Alice Dupont ----" -ForegroundColor Magenta
New-ADUser -Name "Alice Dupont" `
    -GivenName "Alice" `
    -Surname "Dupont" `
    -SamAccountName "alice.dupont" `
    -UserPrincipalName "alice.dupont@$domainName" `
    -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
    -Enabled $true `
    -Path "CN=Users,DC=$netbiosName,DC=local"

# 7️⃣ Déplacer Alice vers l’OU Students
Write-Host "`n---- Déplacement d'Alice dans l'OU Students ----" -ForegroundColor Yellow
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local"

# 8️⃣ Confirmation
Write-Host "`n---- Vérification du déplacement ----" -ForegroundColor Green
Get-ADUser -Identity "alice.dupont" -Properties DistinguishedName |
Select-Object Name, DistinguishedName
