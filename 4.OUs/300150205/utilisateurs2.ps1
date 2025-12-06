# ========================================
# TP Active Directory - Partie 2
# Creation et Modification d'utilisateurs
# ========================================

. .\bootstrap.ps1   # Dot sourcing du bootstrap

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "TP Active Directory - Partie 2" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan



# =====================ETAPE 3 : Creer un nouvel utilisateur ==================================
Write-Host "[ETAPE 3] Creation d'un nouvel utilisateur" -ForegroundColor Yellow

try {
    # Verifier si l'utilisateur existe deja 
    $existingUser = Get-ADUser -Filter "SamAccountName -eq 'alice.dupont'" -Server $domainName -ErrorAction SilentlyContinue
    
    if ($existingUser) {
        Write-Host "  ATTENTION L'utilisateur 'alice.dupont' existe deja" -ForegroundColor Yellow
        Write-Host "    Suppression de l'utilisateur existant..." -ForegroundColor Gray
        Remove-ADUser -Identity "alice.dupont" -Server $domainName -Confirm:$false -ErrorAction Stop
        Write-Host "  OK Utilisateur existant supprime" -ForegroundColor Green
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
    
    Write-Host "  OK Utilisateur 'Alice Dupont' cree avec succes" -ForegroundColor Green
    Write-Host "    Login : alice.dupont" -ForegroundColor Gray
    Write-Host "    UPN : alice.dupont@$domainName`n" -ForegroundColor Gray
}
catch {
    Write-Host "  ERREUR : Impossible de creer l'utilisateur" -ForegroundColor Red
    Write-Host "    Details : $($_.Exception.Message)`n" -ForegroundColor Red
    exit
}

# ---------------------------------- ETAPE 4 : Modifier un utilisateur -----------------------------------
Write-Host "[ETAPE 4] Modification de l'utilisateur" -ForegroundColor Yellow

try {
    Set-ADUser -Identity "alice.dupont" `
               -Server $domainName `
               -EmailAddress "alice.dupont@exemple.com" `
               -GivenName "Alice-Marie" `
               -ErrorAction Stop
    
    Write-Host "  OK Utilisateur modifie avec succes" -ForegroundColor Green
    Write-Host "    Nouveau prenom : Alice-Marie" -ForegroundColor Gray
    Write-Host "    Email : alice.dupont@exemple.com`n" -ForegroundColor Gray
    
    # Afficher les informations mises a jour
    $updatedUser = Get-ADUser -Identity "alice.dupont" -Server $domainName -Properties GivenName, EmailAddress
    Write-Host "  Informations actuelles :" -ForegroundColor Gray
    Write-Host "    Nom complet : $($updatedUser.Name)" -ForegroundColor Gray
    Write-Host "    Prenom : $($updatedUser.GivenName)" -ForegroundColor Gray
    Write-Host "    Email : $($updatedUser.EmailAddress)`n" -ForegroundColor Gray
}
catch {
    Write-Host "  ERREUR : Impossible de modifier l'utilisateur" -ForegroundColor Red
    Write-Host "    Details : $($_.Exception.Message)`n" -ForegroundColor Red
}