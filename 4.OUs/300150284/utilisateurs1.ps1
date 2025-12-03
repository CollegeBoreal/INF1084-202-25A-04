# Fichier utilisateurs1.ps1
# Preparer l'environnement et lister les utilisateurs

# Charger les variables de configuration
. .\bootstrap.ps1

Write-Host "`n[1] Preparation de l'environnement" -ForegroundColor Yellow

# Importer le module Active Directory
Import-Module ActiveDirectory

# Verifier le domaine
Write-Host "`nVerification du domaine..." -ForegroundColor Cyan
try {
    Get-ADDomain -Server $domainName | Select-Object Name, Forest, DomainMode
    Write-Host "[OK] Domaine accessible" -ForegroundColor Green
} catch {
    Write-Host "[ERREUR] Erreur lors de la verification du domaine: $_" -ForegroundColor Red
    exit
}

# Verifier les controleurs de domaine
Write-Host "`nVerification des controleurs de domaine..." -ForegroundColor Cyan
try {
    Get-ADDomainController -Filter * -Server $domainName | Select-Object Name, IPv4Address, OperatingSystem
    Write-Host "[OK] Controleur de domaine accessible" -ForegroundColor Green
} catch {
    Write-Host "[ERREUR] Erreur lors de la verification du DC: $_" -ForegroundColor Red
}

Write-Host "`n[2] Liste des utilisateurs du domaine" -ForegroundColor Yellow

# Lister les utilisateurs actifs (excluant les comptes systeme)
try {
    $users = Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
    Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
    Select-Object Name, SamAccountName
    
    if ($users) {
        $users | Format-Table -AutoSize
        Write-Host "[OK] Nombre d'utilisateurs trouves: $($users.Count)" -ForegroundColor Green
    } else {
        Write-Host "[INFO] Aucun utilisateur trouve (hors comptes systeme)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "[ERREUR] Erreur lors de la recuperation des utilisateurs: $_" -ForegroundColor Red
}