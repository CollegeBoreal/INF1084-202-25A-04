# =====================================================
# Hocine1.ps1 - Création des utilisateurs simulés
# =====================================================

$Users = @(
    [PSCustomObject]@{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Durand"; Prenom="Emma"; Login="edurand"; OU="Stagiaires"}
)

Write-Output "=== Liste des utilisateurs simulés ==="
$Users | ForEach-Object {
    Write-Output "- $($.Prenom) $($.Nom) - Login: $($.Login) - OU: $($.OU)"
}

