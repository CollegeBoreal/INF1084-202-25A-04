# Fichier utilisateurs2.ps1
# Creer et modifier des utilisateurs

# Charger les variables de configuration
. .\bootstrap.ps1

Write-Host "`n[3] Creation d'un nouvel utilisateur" -ForegroundColor Yellow

# Verifier si l'utilisateur existe deja
$userExists = $false
try {
    $existingUser = Get-ADUser -Identity "alice.dupont" -ErrorAction Stop
    $userExists = $true
    Write-Host "[INFO] L'utilisateur 'alice.dupont' existe deja" -ForegroundColor Yellow
    Write-Host "  Utilisation de l'utilisateur existant pour les tests" -ForegroundColor Cyan
} catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
    Write-Host "[INFO] L'utilisateur n'existe pas, creation en cours..." -ForegroundColor Cyan
}

# Creer l'utilisateur seulement s'il n'existe pas
if (-not $userExists) {
    try {
        New-ADUser -Name "Alice Dupont" `
                   -GivenName "Alice" `
                   -Surname "Dupont" `
                   -SamAccountName "alice.dupont" `
                   -UserPrincipalName "alice.dupont@$domainName" `
                   -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
                   -Enabled $true `
                   -Path "CN=Users,DC=$netbiosName,DC=local" `
                   -Credential $cred
        
        Write-Host "[OK] Utilisateur 'Alice Dupont' cree avec succes" -ForegroundColor Green
    } catch {
        Write-Host "[ERREUR] Erreur lors de la creation de l'utilisateur: $_" -ForegroundColor Red
    }
}

# Afficher les informations de l'utilisateur
try {
    
    Get-ADUser -Identity "alice.dupont" -Properties * | 
    Select-Object Name, SamAccountName, UserPrincipalName, Enabled, DistinguishedName |
    Format-List
} catch {
    Write-Host "[ERREUR] Impossible d'afficher les informations: $_" -ForegroundColor Red
}

Write-Host "`n[4] Modification d'un utilisateur" -ForegroundColor Yellow

# Modifier l'utilisateur
try {
    Set-ADUser -Identity "alice.dupont" `
               -EmailAddress "alice.dupont@exemple.com" `
               -GivenName "Alice-Marie" `
               -Credential $cred
    
    Write-Host "[OK] Utilisateur 'alice.dupont' modifie avec succes" -ForegroundColor Green
    
    # Afficher les modifications
    Get-ADUser -Identity "alice.dupont" -Properties EmailAddress, GivenName |
    Select-Object Name, GivenName, EmailAddress |
    Format-List
    
} catch {
    Write-Host "[ERREUR] Erreur lors de la modification de l'utilisateur: $_" -ForegroundColor Red
}