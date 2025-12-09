# ========================================
# TP Active Directory - Partie 1
# Configuration et Listage des utilisateurs
# ========================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

. .\bootstrap.ps1   # Dot sourcing du bootstrap

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "TP Active Directory - Partie 1" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan



# ----------------------------ETAPE 1 : Verification de l'environnement --------------------------------- 
Write-Host "[ETAPE 1] Verification de l'environnement Active Directory" -ForegroundColor Yellow
Import-Module ActiveDirectory

Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# -----------------------------ETAPE 2 : Liste des utilisateurs du domaine--------------------------
Write-Host "[ETAPE 2] Liste des utilisateurs actifs du domaine" -ForegroundColor Yellow

try {
    $users = Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled -ErrorAction Stop |
             Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") }
    
    if ($users.Count -gt 0) {
        Write-Host "  OK $($users.Count) utilisateur(s) trouve(s)`n" -ForegroundColor Green
        $users | Select-Object Name, SamAccountName | Format-Table -AutoSize
    }
    else {
        Write-Host "  ATTENTION Aucun utilisateur trouve (hors comptes systeme)`n" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "  ERREUR : Impossible de lister les utilisateurs" -ForegroundColor Red
    Write-Host "    Details : $($_.Exception.Message)`n" -ForegroundColor Red
}