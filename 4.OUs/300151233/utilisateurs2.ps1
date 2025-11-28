# Charger les informations du bootstrap
. .\bootstrap.ps1

# Importer le module AD
Import-Module ActiveDirectory

Write-Host "=== Création de nouveaux utilisateurs ===" -ForegroundColor Cyan

# Liste des utilisateurs à créer
$users = @(
    @{Name="Alice Dupont"; GivenName="Alice"; Surname="Dupont"; SamAccountName="alice.dupont"},
    @{Name="Bob Martin"; GivenName="Bob"; Surname="Martin"; SamAccountName="bob.martin"},
    @{Name="Claire Lemoine"; GivenName="Claire"; Surname="Lemoine"; SamAccountName="claire.lemoine"}
)

# Créer chaque utilisateur
foreach ($user in $users) {
    try {
        New-ADUser -Name $user.Name `
                   -GivenName $user.GivenName `
                   -Surname $user.Surname `
                   -SamAccountName $user.SamAccountName `
                   -UserPrincipalName "$($user.SamAccountName)@$domainName" `
                   -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
                   -Enabled $true `
                   -Path "CN=Users,$((Get-ADDomain -Server $domainName).DistinguishedName)" `
                   -Server $domainName `
                   -Credential $cred
        
        Write-Host "✓ Utilisateur '$($user.Name)' créé avec succès" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ Erreur lors de la création de '$($user.Name)': $_" -ForegroundColor Red
    }
}

Write-Host "`n=== Vérification ===" -ForegroundColor Cyan
Get-ADUser -Filter "SamAccountName -like '*.*'" -Server $domainName | Select-Object Name, SamAccountName