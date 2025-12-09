# ---------------------------------------------------------
# Script : utilisateurs1.ps1
# Auteur : Mohammed Aiche
# ID     : 300151608
# Objectif : Créer l'utilisateur test01
# ---------------------------------------------------------

Import-Module ActiveDirectory

$domainName = (Get-ADDomain).DNSRoot
$netbiosName = (Get-ADDomain).NetBIOSName

$user = Get-ADUser -Filter "SamAccountName -eq 'test01'" -ErrorAction SilentlyContinue

if ($user) {
    Write-Host "Utilisateur test01 existe déjà !" -ForegroundColor Yellow
}
else {
    New-ADUser `
        -Name "Test User01" `
        -SamAccountName "test01" `
        -UserPrincipalName "test01@$domainName" `
        -GivenName "Test" `
        -Surname "User01" `
        -AccountPassword (ConvertTo-SecureString "Test01!" -AsPlainText -Force) `
        -Enabled $true `
        -Path "CN=Users,DC=$netbiosName,DC=local"

    Write-Host "Utilisateur test01 créé avec succès !" -ForegroundColor Green
}
