# ========================================
# TP Active Directory - Partie 3
# Gestion des comptes
# ========================================


. .\bootstrap.ps1   # Dot sourcing du bootstrap

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "TP Active Directory - Partie 3" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan


# ------------------------------ETAPE 5 : Desactiver un utilisateur
Write-Host "[ETAPE 5] Desactivation d'un utilisateur" -ForegroundColor Yellow

try {
    $user = Get-ADUser -Identity "alice.dupont" -Server $domainName -Properties Enabled -ErrorAction Stop
    
    if ($user.Enabled) {
        Disable-ADAccount -Identity "alice.dupont" -Server $domainName -ErrorAction Stop
        Write-Host "  OK Compte 'alice.dupont' desactive avec succes`n" -ForegroundColor Green
    }
    else {
        Write-Host "  ATTENTION Le compte 'alice.dupont' est deja desactive`n" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "  ERREUR : Impossible de desactiver le compte" -ForegroundColor Red
    Write-Host "    Details : $($_.Exception.Message)`n" -ForegroundColor Red
}

# -----------------------------ETAPE 6 : Reactiver un utilisateur
Write-Host "[ETAPE 6] Reactivation d'un utilisateur" -ForegroundColor Yellow

try {
    $user = Get-ADUser -Identity "alice.dupont" -Server $domainName -Properties Enabled -ErrorAction Stop
    
    if (-not $user.Enabled) {
        Enable-ADAccount -Identity "alice.dupont" -Server $domainName -ErrorAction Stop
        Write-Host "  OK Compte 'alice.dupont' reactive avec succes`n" -ForegroundColor Green
    }
    else {
        Write-Host "  ATTENTION Le compte 'alice.dupont' est deja actif`n" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "  ERREUR : Impossible de reactiver le compte" -ForegroundColor Red
    Write-Host "    Details : $($_.Exception.Message)`n" -ForegroundColor Red
}

# -----------------------------ETAPE 7 : Supprimer un utilisateur
Write-Host "[ETAPE 7] Suppression d'un utilisateur" -ForegroundColor Yellow

try {
    $user = Get-ADUser -Identity "alice.dupont" -Server $domainName -ErrorAction Stop
    Remove-ADUser -Identity "alice.dupont" -Server $domainName -Confirm:$false -ErrorAction Stop
    Write-Host "  OK Utilisateur 'alice.dupont' supprime avec succes" -ForegroundColor Green
    Write-Host "    ATTENTION Note : Pour le recreer, executez .\utilisateurs2.ps1`n" -ForegroundColor Yellow
}
catch {
    Write-Host "  ERREUR : Impossible de supprimer l'utilisateur" -ForegroundColor Red
    Write-Host "    Details : $($_.Exception.Message)`n" -ForegroundColor Red
}

# -------------------------------ETAPE 8 : Rechercher des utilisateurs avec un filtre
Write-Host "[ETAPE 8] Recherche d'utilisateurs (nom commencant par 'e')" -ForegroundColor Yellow

try {
    $users = Get-ADUser -Filter "Name -like 'e*'" -Server $domainName -Properties Name, SamAccountName -ErrorAction Stop
    
    if ($users.Count -gt 0) {
        Write-Host "  OK $($users.Count) utilisateur(s) trouve(s)`n" -ForegroundColor Green
        $users | Select-Object Name, SamAccountName | Format-Table -AutoSize
    }
    else {
        Write-Host "  ATTENTION Aucun utilisateur trouve avec un nom commencant par 'e'`n" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "  ERREUR : Impossible d'effectuer la recherche" -ForegroundColor Red
    Write-Host "    Details : $($_.Exception.Message)`n" -ForegroundColor Red
}

# -------------------------ETAPE 9 : Exporter les utilisateurs dans un CSV
Write-Host "[ETAPE 9] Export des utilisateurs vers CSV" -ForegroundColor Yellow

try {
    $users = Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled -ErrorAction Stop |
             Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
             Select-Object Name, SamAccountName, EmailAddress, Enabled
    
    if ($users.Count -gt 0) {
        $csvPath = "TP_AD_Users.csv"
        $users | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
        Write-Host "  OK Export reussi : $($users.Count) utilisateur(s) exporte(s)" -ForegroundColor Green
        Write-Host "    Fichier : $((Get-Item $csvPath).FullName)`n" -ForegroundColor Gray
    }
    else {
        Write-Host "  ATTENTION Aucun utilisateur a exporter`n" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "  ERREUR : Impossible d'exporter les utilisateurs" -ForegroundColor Red
    Write-Host "    Details : $($_.Exception.Message)`n" -ForegroundColor Red
}