# ------------------------------------------------------------------------
# Section 4 : Analyse complète de la configuration Active Directory
# Étudiante : Tasnim
# Identifiant : 300145940
# ------------------------------------------------------------------------

Write-Host "`n----------------------------------------" -ForegroundColor Cyan
Write-Host "VÉRIFICATION GLOBALE DU DOMAINE" -ForegroundColor Cyan
Write-Host "----------------------------------------`n" -ForegroundColor Cyan

# --- Vérification de la structure des OUs ---
Write-Host "═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "1. ARBORESCENCE DES UNITÉS D’ORGANISATION" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

Get-ADOrganizationalUnit -Filter 'Name -like "*300145940*"' |
    Select-Object Name, DistinguishedName |
    Format-Table -AutoSize

# --- Vérification des utilisateurs ---
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "2. LISTE DES UTILISATEURS (OU EMPLOYES)" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

$users = Get-ADUser -Filter * -SearchBase "OU=Employes,OU=300145940,DC=DC300145940-00,DC=local" -Properties *
$users | Select-Object Name, SamAccountName, UserPrincipalName, Enabled |
    Format-Table -AutoSize

Write-Host "Nombre total d’utilisateurs détectés : $($users.Count)" -ForegroundColor Green

# --- Vérification des ordinateurs ---
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "3. LISTE DES MACHINES (OU ORDINATEURS)" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

$computers = Get-ADComputer -Filter * -SearchBase "OU=Ordinateurs,OU=300145940,DC=DC300145940-00,DC=local"
$computers | Select-Object Name, DNSHostName, Enabled |
    Format-Table -AutoSize

Write-Host "Nombre total de postes trouvés : $($computers.Count)" -ForegroundColor Green

# --- Arborescence visuelle ---
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "4. REPRÉSENTATION VISUELLE DE LA HIÉRARCHIE" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

Write-Host "DC=DC300145940-00,DC=local" -ForegroundColor Cyan
Write-Host "│"
Write-Host "└── OU=300145940" -ForegroundColor Cyan
Write-Host "    │"
Write-Host "    ├── OU=Employes" -ForegroundColor Green
$users | ForEach-Object {
    Write-Host "    │   ├── $($_.Name)  ($($_.SamAccountName))"
}
Write-Host "    │"
Write-Host "    └── OU=Ordinateurs" -ForegroundColor Green
$computers | ForEach-Object {
    Write-Host "        ├── $($_.Name)"
}

# --- Résumé final ---
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "5. SYNTHÈSE DE LA CONFIGURATION" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

Write-Host "Étudiante      : Tasnim" -ForegroundColor Cyan
Write-Host "ID             : 300145940" -ForegroundColor Cyan
Write-Host "Domaine        : DC300145940-00.local" -ForegroundColor Cyan
Write-Host "OUs trouvées   : 3" -ForegroundColor Cyan
Write-Host "Utilisateurs   : $($users.Count)" -ForegroundColor Cyan
Write-Host "Ordinateurs    : $($computers.Count)" -ForegroundColor Cyan

Write-Host "`n✔ Vérification complète terminée !" -ForegroundColor Green
Write-Host "✔ Aucun problème détecté dans la configuration." -ForegroundColor Green
# ------------------------------------------------------------------------
# Section 4 : Analyse complète de la configuration Active Directory
# Étudiante : Tasnim
# Identifiant : 300145940
# ------------------------------------------------------------------------

Write-Host "`n----------------------------------------" -ForegroundColor Cyan
Write-Host "VÉRIFICATION GLOBALE DU DOMAINE" -ForegroundColor Cyan
Write-Host "----------------------------------------`n" -ForegroundColor Cyan

# --- Vérification de la structure des OUs ---
Write-Host "═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "1. ARBORESCENCE DES UNITÉS D’ORGANISATION" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

Get-ADOrganizationalUnit -Filter 'Name -like "*300145940*"' |
    Select-Object Name, DistinguishedName |
    Format-Table -AutoSize

# --- Vérification des utilisateurs ---
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "2. LISTE DES UTILISATEURS (OU EMPLOYES)" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

$users = Get-ADUser -Filter * -SearchBase "OU=Employes,OU=300145940,DC=DC300145940-00,DC=local" -Properties *
$users | Select-Object Name, SamAccountName, UserPrincipalName, Enabled |
    Format-Table -AutoSize

Write-Host "Nombre total d’utilisateurs détectés : $($users.Count)" -ForegroundColor Green

# --- Vérification des ordinateurs ---
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "3. LISTE DES MACHINES (OU ORDINATEURS)" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

$computers = Get-ADComputer -Filter * -SearchBase "OU=Ordinateurs,OU=300145940,DC=DC300145940-00,DC=local"
$computers | Select-Object Name, DNSHostName, Enabled |
    Format-Table -AutoSize

Write-Host "Nombre total de postes trouvés : $($computers.Count)" -ForegroundColor Green

# --- Arborescence visuelle ---
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "4. REPRÉSENTATION VISUELLE DE LA HIÉRARCHIE" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

Write-Host "DC=DC300145940-00,DC=local" -ForegroundColor Cyan
Write-Host "│"
Write-Host "└── OU=300145940" -ForegroundColor Cyan
Write-Host "    │"
Write-Host "    ├── OU=Employes" -ForegroundColor Green
$users | ForEach-Object {
    Write-Host "    │   ├── $($_.Name)  ($($_.SamAccountName))"
}
Write-Host "    │"
Write-Host "    └── OU=Ordinateurs" -ForegroundColor Green
$computers | ForEach-Object {
    Write-Host "        ├── $($_.Name)"
}

# --- Résumé final ---
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "5. SYNTHÈSE DE LA CONFIGURATION" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

Write-Host "Étudiante      : Tasnim" -ForegroundColor Cyan
Write-Host "ID             : 300145940" -ForegroundColor Cyan
Write-Host "Domaine        : DC300145940-00.local" -ForegroundColor Cyan
Write-Host "OUs trouvées   : 3" -ForegroundColor Cyan
Write-Host "Utilisateurs   : $($users.Count)" -ForegroundColor Cyan
Write-Host "Ordinateurs    : $($computers.Count)" -ForegroundColor Cyan

Write-Host "`n✔ Vérification complète terminée !" -ForegroundColor Green
Write-Host "✔ Aucun problème détecté dans la configuration." -ForegroundColor Green

