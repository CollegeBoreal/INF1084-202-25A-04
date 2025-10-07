# Script utilisateurs2.ps1
# Création de groupes simulés

# Importer les utilisateurs depuis le script 1 (ou les recréer ici)
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"}
)

# Création des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs de l'OU "Stagiaires" dans GroupeFormation
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object {
    $Groups["GroupeFormation"] += $_
}

# Vérifier le contenu du groupe
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

