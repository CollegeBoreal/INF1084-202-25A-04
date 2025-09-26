# =====================================================
# Hocine3.ps1 - Filtrage des utilisateurs
# =====================================================

. .\Hocine1.ps1

Write-Output "=== Liste complète ==="
$Users | ForEach-Object {
    Write-Output "- $($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

$Filtered = $Users | Where-Object { $_.Prenom -match "a" -or $_.Nom -match "a" }

Write-Output "`n=== Utilisateurs dont le prénom ou le nom contient 'a' (insensible à la casse) ==="
$Filtered | ForEach-Object {
    Write-Output "- $($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}



