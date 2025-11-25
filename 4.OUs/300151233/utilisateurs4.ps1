# Charger les informations du bootstrap
. .\bootstrap.ps1

# Importer le module AD
Import-Module ActiveDirectory

Write-Host "=== Création de l'OU Students ===" -ForegroundColor Cyan

# Obtenir le DN du domaine
$domainDN = (Get-ADDomain -Server $domainName).DistinguishedName

# Vérifier si l'OU existe, sinon la créer
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -Server $domainName -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path $domainDN -Server $domainName -Credential $cred
    Write-Host "✓ OU 'Students' créée" -ForegroundColor Green
} else {
    Write-Host "⚠ OU 'Students' existe déjà" -ForegroundColor Yellow
}

# Déplacer les utilisateurs vers l'OU Students
Write-Host "`n=== Déplacement des utilisateurs vers OU=Students ===" -ForegroundColor Cyan

$usersToMove = @("Alice Dupont", "Bob Martin", "Claire Lemoine")

foreach ($userName in $usersToMove) {
    try {
        Move-ADObject -Identity "CN=$userName,CN=Users,$domainDN" `
                      -TargetPath "OU=Students,$domainDN" `
                      -Server $domainName `
                      -Credential $cred
        Write-Host "✓ '$userName' déplacé vers OU=Students" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ Erreur lors du déplacement de '$userName': $_" -ForegroundColor Red
    }
}

# Vérifier le déplacement
Write-Host "`n=== Vérification des utilisateurs dans OU=Students ===" -ForegroundColor Cyan
Get-ADUser -Filter * -SearchBase "OU=Students,$domainDN" -Server $domainName |
Select-Object Name, SamAccountName, DistinguishedName |
Format-Table -AutoSize

# Exporter tous les utilisateurs en CSV
Write-Host "`n=== Export des utilisateurs en CSV ===" -ForegroundColor Cyan
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled, DistinguishedName |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled, DistinguishedName |
Export-Csv -Path ".\TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8

Write-Host "✓ Export terminé: TP_AD_Users.csv" -ForegroundColor Green

# Afficher un résumé
Write-Host "`n=== Résumé final ===" -ForegroundColor Cyan
Write-Host "Utilisateurs dans CN=Users:" (Get-ADUser -Filter * -SearchBase "CN=Users,$domainDN" -Server $domainName | Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") }).Count
Write-Host "Utilisateurs dans OU=Students:" (Get-ADUser -Filter * -SearchBase "OU=Students,$domainDN" -Server $domainName).Count