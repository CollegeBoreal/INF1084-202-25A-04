# Fichier utilisateurs3.ps1
# Desactiver, reactiver et supprimer des utilisateurs

# Charger les variables de configuration
. .\bootstrap.ps1

Write-Host "`n[5] Desactivation d'un utilisateur" -ForegroundColor Yellow

# Desactiver l'utilisateur
try {
    Disable-ADAccount -Identity "alice.dupont" -Credential $cred
    Write-Host "[OK] Utilisateur 'alice.dupont' desactive avec succes" -ForegroundColor Green
    
    # Verifier l'etat
    Get-ADUser -Identity "alice.dupont" -Properties Enabled |
    Select-Object Name, SamAccountName, Enabled |
    Format-List
    
} catch {
    Write-Host "[ERREUR] Erreur lors de la desactivation de l'utilisateur: $_" -ForegroundColor Red
}

Write-Host "`n[6] Reactivation d'un utilisateur" -ForegroundColor Yellow

# Reactiver l'utilisateur
try {
    Enable-ADAccount -Identity "alice.dupont" -Credential $cred
    Write-Host "[OK] Utilisateur 'alice.dupont' reactive avec succes" -ForegroundColor Green
    
    # Verifier l'etat
    Get-ADUser -Identity "alice.dupont" -Properties Enabled |
    Select-Object Name, SamAccountName, Enabled |
    Format-List
    
} catch {
    Write-Host "[ERREUR] Erreur lors de la reactivation de l'utilisateur: $_" -ForegroundColor Red
}

Write-Host "`n[7] Suppression d'un utilisateur" -ForegroundColor Yellow

# Demander confirmation avant suppression
$confirmation = Read-Host "Voulez-vous vraiment supprimer l'utilisateur 'alice.dupont'? (O/N)"

if ($confirmation -eq 'O' -or $confirmation -eq 'o') {
    try {
        Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred
        Write-Host "[OK] Utilisateur 'alice.dupont' supprime avec succes" -ForegroundColor Green
    } catch {
        Write-Host "[ERREUR] Erreur lors de la suppression de l'utilisateur: $_" -ForegroundColor Red
    }
} else {
    Write-Host "[INFO] Suppression annulee par l'utilisateur" -ForegroundColor Yellow
}