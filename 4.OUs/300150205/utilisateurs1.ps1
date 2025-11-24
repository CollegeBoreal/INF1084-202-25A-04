# ========================================
# TP Active Directory - Partie 1
# Configuration et Listage des utilisateurs
# ========================================


Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "TP Active Directory - Partie 1" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan


# ------------------------------ÉTAPE 0 : Configuration des variables ----------------------------------
$studentNumber = 300150205
$studentInstance = "00"

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"


Write-Host "[ÉTAPE 0] Configuration des variables" -ForegroundColor Yellow
Write-Host "  → Domaine : $domainName" -ForegroundColor Gray
Write-Host "  → NetBIOS : $netbiosName`n" -ForegroundColor Gray


# ----------------------------ÉTAPE 1 : Vérification de l'environnement --------------------------------- 
Write-Host "[ÉTAPE 1] Vérification de l'environnement Active Directory" -ForegroundColor Yellow
Import-Module ActiveDirectory

Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# -----------------------------ÉTAPE 2 : Liste des utilisateurs du domaine--------------------------
Write-Host "[ÉTAPE 2] Liste des utilisateurs actifs du domaine" -ForegroundColor Yellow

try {
    $users = Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled -ErrorAction Stop |
             Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") }
    
    if ($users.Count -gt 0) {
        Write-Host "  ✓ $($users.Count) utilisateur(s) trouvé(s)`n" -ForegroundColor Green
        $users | Select-Object Name, SamAccountName | Format-Table -AutoSize
    }
    else {
        Write-Host "  ⚠ Aucun utilisateur trouvé (hors comptes système)`n" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "  ✗ ERREUR : Impossible de lister les utilisateurs" -ForegroundColor Red
    Write-Host "    Détails : $($_.Exception.Message)`n" -ForegroundColor Red
}
