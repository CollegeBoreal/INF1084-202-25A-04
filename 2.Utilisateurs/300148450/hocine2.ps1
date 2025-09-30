# =====================================================
# Hocine2.ps1 - Création de groupes
# =====================================================

. .\Hocine1.ps1

$Groups = @{}
$Groups["ProfesseursAD"] = @()
$Groups["GroupeFormation"] = @()
$Groups["GroupeFormation"] += $Users

Write-Output "=== Groupes créés ==="
Write-Output "ProfesseursAD :"
$Groups["ProfesseursAD"]

Write-Output "`nGroupeFormation :"
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Output " - $($.Prenom) $($.Nom) ($($_.Login))"
}


