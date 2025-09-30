# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Importer ou recréer la liste d'utilisateurs
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Trache"; Prenom="Ismail"; Login="Tismail"; OU="Stagiaires"},
    @{Nom="Nemouss"; Prenom="Latif"; Login="Nlatif"; OU="Stagiaires"}
)

# Ajouter tous les utilisateurs de l'OU "Stagiaires" dans GroupeFormation
$Groups["GroupeFormation"] += $Users | Where-Object {$_.OU -eq "Stagiaires"}

# Afficher les membres du groupe
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
