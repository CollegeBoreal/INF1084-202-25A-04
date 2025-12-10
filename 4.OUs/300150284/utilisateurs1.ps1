# ============================================
# Script : utilisateurs1.ps1
# Objectif : Préparer l'environnement AD et lister les utilisateurs
# ============================================

# Charger les variables de configuration
. .\bootstrap.ps1

Write-Host "`n[1] Préparation de l'environnement" -ForegroundColor Yellow

# Importer le module Active Directory
try {
    Import-Module ActiveDirectory -ErrorAction Stop
} catch {
    Write-Host "[ERREUR] Le module ActiveDirectory n'est pas installé." -ForegroundColor Red
    Write-Host "Installe-le avec : Install-WindowsFeature AD-Domain-Services -IncludeManagementTools"
    exit
}

# Vérifier le domaine
Write-Host "`nVérification du domaine..." -ForegroundColor Cyan
try {
    $domain = Get-ADDomain -Server $domainName -ErrorAction Stop
    Write-Host "[OK] Domaine accessible : $($domain.Name)" -ForegroundColor Green
} catch {
    Write-Host "[ERREUR] Impossible de contacter le domaine '$domainName'." -ForegroundColor Red
    Write-Host "Cause possible :"
    Write-Host "- La machine n'est pas un contrôleur de domaine (AD DS non installé)" -ForegroundColor Red
    Write-Host "- Le domaine n'existe pas encore" -ForegroundColor Red
    Write-Host "- Active Directory Web Services n'est pas en cours d'exécution" -ForegroundColor Red
    exit
}

# Vérifier les contrôleurs de domaine
Write-Host "`nVérification des contrôleurs de domaine..." -ForegroundColor Cyan
try {
    $dcs = Get-ADDomainController -Filter * -Server $domainName -ErrorAction Stop |
           Select-Object Name, IPv4Address, OperatingSystem

    $dcs | Format-Table -AutoSize

    Write-Host "[OK] Contrôleur(s) de domaine accessible(s)" -ForegroundColor Green
} catch {
    Write-Host "[ERREUR] Impossible de récupérer les informations du DC." -ForegroundColor Red
}

# Liste des utilisateurs
Write-Host "`n[2] Liste des utilisateurs du domaine" -ForegroundColor Yellow
try {
    $users = Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
             Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
             Select-Object Name, SamAccountName

    if ($users.Count -gt 0) {
        $users | Format-Table -AutoSize
        Write-Host "`n[OK] Nombre d'utilisateurs trouvés : $($users.Count)" -ForegroundColor Green
    } else {
        Write-Host "[INFO] Aucun utilisateur non-système trouvé dans le domaine." -ForegroundColor Yellow
    }
} catch {
    Write-Host "[ERREUR] Impossible de récupérer la liste des utilisateurs." -ForegroundColor Red
}
