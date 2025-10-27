  # utilisateurs2.ps1
# Exercice 2 : Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans GroupeFormation

# Liste des utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Moulin"; Prenom="Jean"; Login="jmoulin"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Paul"; Login="pmartin"; OU="Informatique"}
)

# Création des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs avec OU = Stagiaires dans GroupeFormation
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher les utilisateurs du groupe
"Utilisateurs dans GroupeFormation :"
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

