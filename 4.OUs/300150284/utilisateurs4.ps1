# ============================================
# Script : utilisateurs4.ps1
# Objectif : Rechercher, exporter et déplacer des utilisateurs
# ============================================

# Charger la configuration
. .\bootstrap.ps1

Write-Host "`n[8] Recherche d'utilisateurs avec filtre" -ForegroundColor Yellow

# Recherche des utilisateurs dont le prénom commence par A
try {
    $filteredUsers = Get-ADUser -Filter "GivenName -like 'A*'" -Properties Name, SamAccountName, GivenName

    if ($filteredUsers.Count -gt 0) {
        $filteredUsers | Format-Table -AutoSize
        Write-Host "[OK] Nombre d'utilisateurs trouvés : $($filteredUsers.Count)" -ForegroundColor Green
    }
    else {
        Write-Host "[INFO] Aucun utilisateur trouvé avec un prénom commençant par 'A'" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "[ERREUR] Erreur lors de la recherche : $_" -ForegroundColor Red
}

Write-Host "`n[9] Export des utilisateurs dans un CSV" -ForegroundColor Yellow

# Export CSV
try {
    $exportPath = "TP_AD_Users_$studentNumber.csv"

    Get-ADUser -Filter * -Properties Name, SamAccountName, EmailAddress, Enabled |
    Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
    Select-Object Name, SamAccountName, EmailAddress, Enabled |
    Export-Csv -Path $exportPath -NoTypeInformation -Encoding UTF8

    Write-Host "[OK] Utilisateurs exportés dans le fichier : $exportPath" -ForegroundColor Green

    Import-Csv $exportPath | Format-Table -AutoSize
}
catch {
    Write-Host "[ERREUR] Erreur lors de l'export : $_" -ForegroundColor Red
}

Write-Host "`n[10] Déplacement d'un utilisateur vers la OU 'Students'" -ForegroundColor Yellow

# Créer l'OU Students si nécessaire
try {
    $ouPath = "OU=Students,DC=DC300150284-00,DC=local"

    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name "Students" -Path "DC=DC300150284-00,DC=local"
        Write-Host "[OK] OU 'Students' créée avec succès" -ForegroundColor Green
    }
    else {
        Write-Host "[INFO] OU 'Students' existe déjà" -ForegroundColor Cyan
    }
}
catch {
    Write-Host "[ERREUR] Erreur lors de la création de l'OU : $_" -ForegroundColor Red
}

# Vérifier si alice.dupont existe AVANT le déplacement
try {
    $user = Get-ADUser -Identity "alice.dupont" -ErrorAction Stop

    # S’il existe → déplacer
    Move-ADObject -Identity $user.DistinguishedName -TargetPath $ouPath

    Write-Host "[OK] Utilisateur déplacé vers 'Students'" -ForegroundColor Green

    Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName | Format-List
}
catch {
    Write-Host "[ERREUR] Impossible de déplacer l'utilisateur." -ForegroundColor Red
    Write-Host "  Note : L'utilisateur 'alice.dupont' n'existe pas. Il a peut-être été supprimé dans utilisateurs3.ps1" -ForegroundColor Yellow
}
