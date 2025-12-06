Import-Module ActiveDirectory

. .\bootstrap.ps1

# Vérifier si l'utilisateur existe
$user = Get-ADUser -Filter "SamAccountName -eq 'alice.dupont'" -Server $domainName -ErrorAction SilentlyContinue

if (-not $user) {
    Write-Host "Création de l'utilisateur Alice..."

    New-ADUser -Name "Alice Dupont" `
               -GivenName "Alice" `
               -Surname "Dupont" `
               -SamAccountName "alice.dupont" `
               -UserPrincipalName "alice.dupont@$domainName" `
               -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
               -Enabled $true `
               -Path "CN=Users,DC=$netbiosName,DC=local" `
               -Server $domainName
} else {
    Write-Host "Utilisateur existe déjà."
}

Set-ADUser -Identity "alice.dupont" `
           -Server $domainName `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie"

