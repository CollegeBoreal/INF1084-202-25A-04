# Fichier utilisateurs4.ps1
# Rechercher, exporter et deplacer des utilisateurs

# Charger les variables de configuration
. .\bootstrap.ps1

Write-Host "`n[8] Recherche d'utilisateurs avec filtre" -ForegroundColor Yellow

# Rechercher les utilisateurs dont le prenom commence par 'A'
try {
    $filteredUsers = Get-ADUser -Filter "GivenName -like 'A*'" -Properties Name, SamAccountName, GivenName |
    Select-Object Name, SamAccountName, GivenName
    
    if ($filteredUsers) {
        $filteredUsers | Format-Table -AutoSize
        Write-Host "[OK] Nombre d'utilisateurs trouves: $($filteredUsers.Count)" -ForegroundColor Green
    } else {
        Write-Host "[INFO] Aucun utilisateur trouve avec un prenom commencant par 'A'" -ForegroundColor Yellow
    }
} catch {
    Write-Host "[ERREUR] Erreur lors de la recherche: $_" -ForegroundColor Red
}

Write-Host "`n[9] Export des utilisateurs dans un CSV" -ForegroundColor Yellow

# Exporter tous les utilisateurs dans un fichier CSV
try {
    $exportPath = "TP_AD_Users_$studentNumber.csv"
    Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
    Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
    Select-Object Name, SamAccountName, EmailAddress, Enabled |
    Export-Csv -Path $exportPath -NoTypeInformation -Encoding UTF8
    
    Write-Host "[OK] Utilisateurs exportes dans le fichier: $exportPath" -ForegroundColor Green
    
    # Afficher un apercu
    Import-Csv $exportPath | Format-Table -AutoSize
    
} catch {
    Write-Host "[ERREUR] Erreur lors de l'export: $_" -ForegroundColor Red
}

Write-Host "`n[10] Deplacement d'un utilisateur vers une OU 'Students'" -ForegroundColor Yellow

# Verifier si l'OU Students existe, sinon la creer
try {
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local" -Credential $cred
        Write-Host "[OK] OU 'Students' creee avec succes" -ForegroundColor Green
    } else {
        Write-Host "[INFO] OU 'Students' existe deja" -ForegroundColor Cyan
    }
} catch {
    Write-Host "[ERREUR] Erreur lors de la creation de l'OU: $_" -ForegroundColor Red
}

# Deplacer l'utilisateur alice.dupont vers l'OU Students (si elle existe)
try {
    $userDN = (Get-ADUser -Identity "alice.dupont").DistinguishedName
    
    Move-ADObject -Identity $userDN `
                  -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
                  -Credential $cred
    
    Write-Host "[OK] Utilisateur deplace vers l'OU 'Students'" -ForegroundColor Green
    
    # Verifier le deplacement
    Get-ADUser -Identity "alice.dupont" | 
    Select-Object Name, DistinguishedName |
    Format-List
    
} catch {
    Write-Host "[ERREUR] Erreur lors du deplacement: $_" -ForegroundColor Red
    Write-Host "  Note: L'utilisateur 'alice.dupont' doit exister pour etre deplace" -ForegroundColor Yellow
}