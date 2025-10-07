# Exercice 2 : Création de groupes simulés

# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Garcia"; Prenom="Maria"; Login="mgarcia"; OU="Stagiaires"}
)

# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs dont l'OU = "Stagiaires" dans "GroupeFormation"
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object {
    $Groups["GroupeFormation"] += $_
}

# Afficher le contenu du groupe
Write-Host "`n=== Membres de GroupeFormation ===" -ForegroundColor Cyan
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "- $($_.Prenom) $($_.Nom) ($($_.Login))" -ForegroundColor Green
}

Write-Host "`nNombre de membres: $($Groups['GroupeFormation'].Count)" -ForegroundColor Yellow