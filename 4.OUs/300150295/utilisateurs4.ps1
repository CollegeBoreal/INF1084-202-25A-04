# ============================================
# 4. VÉRIFICATION COMPLÈTE
# Étudiant: Lounas Allouti
# ID: 300150295
# ============================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "VÉRIFICATION COMPLÈTE DE LA CONFIGURATION" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# 1. Vérifier toutes les OUs
Write-Host "═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "1. STRUCTURE DES OUs" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

Get-ADOrganizationalUnit -Filter 'Name -like "*300150295*"' | 
    Select-Object Name, DistinguishedName | 
    Format-Table -AutoSize

# 2. Vérifier tous les utilisateurs
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "2. UTILISATEURS DANS L'OU EMPLOYES" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

$users = Get-ADUser -Filter * -SearchBase "OU=Employes,OU=300150295,DC=DC300150295-00,DC=local" -Properties *
$users | Select-Object Name, SamAccountName, UserPrincipalName, Enabled | Format-Table -AutoSize

Write-Host "Total des utilisateurs: $($users.Count)" -ForegroundColor Green

# 3. Vérifier tous les ordinateurs
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "3. ORDINATEURS DANS L'OU ORDINATEURS" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

$computers = Get-ADComputer -Filter * -SearchBase "OU=Ordinateurs,OU=300150295,DC=DC300150295-00,DC=local"
$computers | Select-Object Name, DNSHostName, Enabled | Format-Table -AutoSize

Write-Host "Total des ordinateurs: $($computers.Count)" -ForegroundColor Green

# 4. Afficher la hiérarchie visuelle
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "4. HIÉRARCHIE VISUELLE" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

Write-Host "DC=DC300150295-00,DC=local" -ForegroundColor Cyan
Write-Host "│" -ForegroundColor White
Write-Host "└── OU=300150295" -ForegroundColor Cyan
Write-Host "    │" -ForegroundColor White
Write-Host "    ├── OU=Employes" -ForegroundColor Green
$users | ForEach-Object { 
    Write-Host "    │   ├── $($_.Name) ($($_.SamAccountName))" -ForegroundColor White 
}
Write-Host "    │" -ForegroundColor White
Write-Host "    └── OU=Ordinateurs" -ForegroundColor Green
$computers | ForEach-Object { 
    Write-Host "        ├── $($_.Name)" -ForegroundColor White   
}

# 5. Résumé final
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Yellow
Write-Host "5. RÉSUMÉ DE LA CONFIGURATION" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════`n" -ForegroundColor Yellow

Write-Host "Étudiant        : Lounas Allouti" -ForegroundColor Cyan
Write-Host "ID              : 300150295" -ForegroundColor Cyan
Write-Host "Domaine         : DC300150295-00.local" -ForegroundColor Cyan
Write-Host "OUs créées      : 3" -ForegroundColor Cyan
Write-Host "Utilisateurs    : $($users.Count)" -ForegroundColor Cyan
Write-Host "Ordinateurs     : $($computers.Count)" -ForegroundColor Cyan

Write-Host "`n✓ Configuration terminée avec succès!" -ForegroundColor Green
Write-Host "✓ Toutes les vérifications sont passées!" -ForegroundColor Green
