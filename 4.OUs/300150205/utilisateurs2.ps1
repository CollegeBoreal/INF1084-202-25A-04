# ========================================
# TP Active Directory - Partie 2
# Création et Modification d'utilisateurs
# ========================================

. .\bootstrap.ps1   # Dot sourcing du bootstrap


Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "TP Active Directory - Partie 2" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan



# =====================ÉTAPE 3 : Créer un nouvel utilisateur ==================================
Write-Host "[ÉTAPE 3] Création d'un nouvel utilisateur" -ForegroundColor Yellow

try {
    # Vérifier si l'utilisateur existe déjà
    $existingUser = Get-ADUser -Filter "SamAccountName -eq 'alice.dupont'" -Server $domainName -ErrorAction SilentlyContinue
    
    if ($existingUser) {
        Write-Host "  ⚠ L'utilisateur 'alice.dupont' existe déjà" -ForegroundColor Yellow
        Write-Host "    Suppression de l'utilisateur existant..." -ForegroundColor Gray
        Remove-ADUser -Identity "alice.dupont" -Server $domainName -Confirm:$false -ErrorAction Stop
        Write-Host "  ✓ Utilisateur existant supprimé" -ForegroundColor Green
    }
    
    New-ADUser -Name "Alice Dupont" `
               -GivenName "Alice" `
               -Surname "Dupont" `
               -SamAccountName "alice.dupont" `
               -UserPrincipalName "alice.dupont@$domainName" `
               -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
               -Enabled $true `
               -Path "CN=Users,DC=$netbiosName,DC=local" `
               -Server $domainName `
               -ErrorAction Stop
    
    Write-Host "  ✓ Utilisateur 'Alice Dupont' créé avec succès" -ForegroundColor Green
    Write-Host "    Login : alice.dupont" -ForegroundColor Gray
    Write-Host "    UPN : alice.dupont@$domainName`n" -ForegroundColor Gray
}
catch {
    Write-Host "  ✗ ERREUR : Impossible de créer l'utilisateur" -ForegroundColor Red
    Write-Host "    Détails : $($_.Exception.Message)`n" -ForegroundColor Red
    exit
}

# ---------------------------------- ÉTAPE 4 : Modifier un utilisateur -----------------------------------
Write-Host "[ÉTAPE 4] Modification de l'utilisateur" -ForegroundColor Yellow

try {
    Set-ADUser -Identity "alice.dupont" `
               -Server $domainName `
               -EmailAddress "alice.dupont@exemple.com" `
               -GivenName "Alice-Marie" `
               -ErrorAction Stop
    
    Write-Host "  ✓ Utilisateur modifié avec succès" -ForegroundColor Green
    Write-Host "    Nouveau prénom : Alice-Marie" -ForegroundColor Gray
    Write-Host "    Email : alice.dupont@exemple.com`n" -ForegroundColor Gray
    
    # Afficher les informations mises à jour
    $updatedUser = Get-ADUser -Identity "alice.dupont" -Server $domainName -Properties GivenName, EmailAddress
    Write-Host "  Informations actuelles :" -ForegroundColor Gray
    Write-Host "    Nom complet : $($updatedUser.Name)" -ForegroundColor Gray
    Write-Host "    Prénom : $($updatedUser.GivenName)" -ForegroundColor Gray
    Write-Host "    Email : $($updatedUser.EmailAddress)`n" -ForegroundColor Gray
}
catch {
    Write-Host "  ✗ ERREUR : Impossible de modifier l'utilisateur" -ForegroundColor Red
    Write-Host "    Détails : $($_.Exception.Message)`n" -ForegroundColor Red
}