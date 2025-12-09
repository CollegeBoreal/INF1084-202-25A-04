# utilisateurs2.ps1
# Création de groupes simulés

# Recréer la liste des utilisateurs (comme dans utilisateurs1.ps1)
$Users = @(
    @{Nom="Dupont";  Prenom="Alice";   Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah";   Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim";   Login="kbenali";  OU="Stagiaires"},
    @{Nom="Bouraoui"; Prenom="amine";  Login="bouqlaoui"; OU="Stagiaires"},
    @{Nom="Junior";   Prenom="imad"; Login="bouterma";   OU="Stagiaires"}
)

# Créer les groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter tous les utilisateurs dont l'OU = "Stagiaires"
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher le contenu du groupe
$Groups["GroupeFormation"] | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login)"
}