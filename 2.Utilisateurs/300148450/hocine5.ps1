# =====================================================
# Hocine5.ps1 - Mini-projet final
# =====================================================

$UsersPromo2025 = @(
    [PSCustomObject]@{Nom="Moreau"; Prenom="Nina"; Login="nmoreau"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Girard"; Prenom="Hugo"; Login="hgirard"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Petit"; Prenom="Lea"; Login="lpetit"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Roux"; Prenom="Alex"; Login="aroux"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Fischer"; Prenom="Mila"; Login="mfischer"; OU="Promo2025"}
)

$Etudiants2025 = @()
$Etudiants2025 += $UsersPromo2025

$Etudiants2025 | Export-Csv -Path "C:\Temp\Etudiants2025.csv" -NoTypeInformation -Encoding UTF8
Write-Output "✅ Groupe exporté vers C:\Temp\Etudiants2025.csv"

Write-Output "=== Groupe Etudiants2025 ==="
$Etudiants2025 | ForEach-Object {
    Write-Output "- $($.Prenom) $($.Nom) ($($_.Login))"
}

