# ========================================
# TP Active Directory - Partie 3
# Gestion des comptes
# ========================================


. .\bootstrap.ps1   # Dot sourcing du bootstrap

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "TP Active Directory - Partie 3" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan


# ------------------------------ÉTAPE 5 : Désactiver un utilisateur
Write-Host "[ÉTAPE 5] Désactivation d'un utilisateur" -ForegroundColor Yellow

try {
    $user = Get-ADUser -Identity "alice.dupont" -Server $domainName -Properties Enabled -ErrorAction Stop
    
    if ($user.Enabled) {
        Disable-ADAccount -Identity "alice.dupont" -Server $domainName -ErrorAction Stop
        Write-Host "  ✓ Compte 'alice.dupont' désactivé avec succès`n" -ForegroundColor Green
    }
    else {
        Write-Host "  ⚠ Le compte 'alice.dupont' est déjà désactivé`n" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "  ✗ ERREUR : Impossible de désactiver le compte" -ForegroundColor Red
    Write-Host "    Détails : $($_.Exception.Message)`n" -ForegroundColor Red
}

# -----------------------------ÉTAPE 6 : Réactiver un utilisateur
Write-Host "[ÉTAPE 6] Réactivation d'un utilisateur" -ForegroundColor Yellow

try {
    $user = Get-ADUser -Identity "alice.dupont" -Server $domainName -Properties Enabled -ErrorAction Stop
    
    if (-not $user.Enabled) {
        Enable-ADAccount -Identity "alice.dupont" -Server $domainName -ErrorAction Stop
        Write-Host "  ✓ Compte 'alice.dupont' réactivé avec succès`n" -ForegroundColor Green
    }
    else {
        Write-Host "  ⚠ Le compte 'alice.dupont' est déjà actif`n" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "  ✗ ERREUR : Impossible de réactiver le compte" -ForegroundColor Red
    Write-Host "    Détails : $($_.Exception.Message)`n" -ForegroundColor Red
}

# -----------------------------ÉTAPE 7 : Supprimer un utilisateur
Write-Host "[ÉTAPE 7] Suppression d'un utilisateur" -ForegroundColor Yellow

try {
    $user = Get-ADUser -Identity "alice.dupont" -Server $domainName -ErrorAction Stop
    Remove-ADUser -Identity "alice.dupont" -Server $domainName -Confirm:$false -ErrorAction Stop
    Write-Host "  ✓ Utilisateur 'alice.dupont' supprimé avec succès" -ForegroundColor Green
    Write-Host "    ⚠ Note : Pour le recréer, exécutez .\utilisateurs2.ps1`n" -ForegroundColor Yellow
}
catch {
    Write-Host "  ✗ ERREUR : Impossible de supprimer l'utilisateur" -ForegroundColor Red
    Write-Host "    Détails : $($_.Exception.Message)`n" -ForegroundColor Red
}

# -------------------------------ÉTAPE 8 : Rechercher des utilisateurs avec un filtre
Write-Host "[ÉTAPE 8] Recherche d'utilisateurs (nom commençant par 's')" -ForegroundColor Yellow

try {
    $users = Get-ADUser -Filter "Name -like 's*'" -Server $domainName -Properties Name, SamAccountName -ErrorAction Stop
    
    if ($users.Count -gt 0) {
        Write-Host "  ✓ $($users.Count) utilisateur(s) trouvé(s)`n" -ForegroundColor Green
        $users | Select-Object Name, SamAccountName | Format-Table -AutoSize
    }
    else {
        Write-Host "  ⚠ Aucun utilisateur trouvé avec un nom commençant par 's'`n" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "  ✗ ERREUR : Impossible d'effectuer la recherche" -ForegroundColor Red
    Write-Host "    Détails : $($_.Exception.Message)`n" -ForegroundColor Red
}

# -------------------------ÉTAPE 9 : Exporter les utilisateurs dans un CSV
Write-Host "[ÉTAPE 9] Export des utilisateurs vers CSV" -ForegroundColor Yellow

try {
    $users = Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled -ErrorAction Stop |
             Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
             Select-Object Name, SamAccountName, EmailAddress, Enabled
    
    if ($users.Count -gt 0) {
        $csvPath = "TP_AD_Users.csv"
        $users | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
        Write-Host "  ✓ Export réussi : $($users.Count) utilisateur(s) exporté(s)" -ForegroundColor Green
        Write-Host "    Fichier : $((Get-Item $csvPath).FullName)`n" -ForegroundColor Gray
    }
    else {
        Write-Host "  ⚠ Aucun utilisateur à exporter`n" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "  ✗ ERREUR : Impossible d'exporter les utilisateurs" -ForegroundColor Red
    Write-Host "    Détails : $($_.Exception.Message)`n" -ForegroundColor Red
}