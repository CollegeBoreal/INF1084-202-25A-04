# ============================
# utilisateurs1.ps1
# Liste des utilisateurs + création d’un nouvel utilisateur (Sara Benali)
# ============================

. "$PSScriptRoot\bootstrap.ps1"

Write-Host "`n=== 1) Liste des utilisateurs actifs ===`n"

Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
    Where-Object {
        $_.Enabled -eq $true -and
        $_.SamAccountName -notin @("Administrator", "Guest", "krbtgt")
    } |
    Select-Object Name, SamAccountName

Write-Host "`n=== 2) Création de l'utilisateur Sara Benali ===`n"

$password = ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force

New-ADUser -Name "Sara Benali" `
           -GivenName "Sara" `
           -Surname "Benali" `
           -SamAccountName "sara.benali" `
           -UserPrincipalName "sara.benali@$domainName" `
           -AccountPassword $password `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Credential $cred

Write-Host "Utilisateur 'Sara Benali' créé avec succès."

