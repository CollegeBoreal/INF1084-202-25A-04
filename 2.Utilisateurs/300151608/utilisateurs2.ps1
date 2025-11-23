###########################################################
# 💻 INF1084 - Exercice 2 : Création de groupes simulés
# Auteur : Mohammed Aiche
# Étudiant : 300151608
###########################################################

# Liste d’utilisateurs
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Création de groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs dans le groupe GroupeFormation
$Groups["GroupeFormation"] += $Users

# Afficher les membres du groupe
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
