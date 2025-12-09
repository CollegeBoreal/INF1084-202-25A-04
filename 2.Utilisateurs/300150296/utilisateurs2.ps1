# ============================================
# Exercice 2 : Création de groupes simulés
# ============================================

# Créer les utilisateurs (avec les 5 utilisateurs)
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Jean"; Login="jmartin"; OU="Stagiaires"},
    @{Nom="Garcia"; Prenom="Maria"; Login="mgarcia"; OU="Stagiaires"}
)

# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter un utilisateur à un groupe (exemple de base)
$Groups["GroupeFormation"] += $Users[0]   # Alice Dupont

Write-Host "`n=== Groupe Formation (avant ajout automatique) ===" -ForegroundColor Cyan
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "- $($_.Prenom) $($_.Nom)"
}

# ✅ EXERCICE 2 : Ajouter TOUS les utilisateurs dont OU = "Stagiaires"
$Groups["GroupeFormation"] = @()  # Vider le groupe
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object {
    $Groups["GroupeFormation"] += $_
}

Write-Host "`n=== Groupe Formation (après ajout automatique) ===" -ForegroundColor Green
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "- $($_.Prenom) $($_.Nom) ($($_.Login))"
}

Write-Host "`n✅ Total dans GroupeFormation : $($Groups['GroupeFormation'].Count) membres" -ForegroundColor Yellow