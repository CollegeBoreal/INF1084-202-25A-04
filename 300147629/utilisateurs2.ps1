# utilisateurs2.ps1
# Exercice 2 : I'm here

# Liste des utilisateurs (mêmes que dans exercice 1)
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Linh"; Login="lnguyen"; OU="Stagiaires"}
)

# Créer les groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter tous les utilisateurs de l'OU "Stagiaires" dans GroupeFormation
$Groups["GroupeFormation"] += $Users | Where-Object {$_.OU -eq "Stagiaires"}

# Vérification
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
