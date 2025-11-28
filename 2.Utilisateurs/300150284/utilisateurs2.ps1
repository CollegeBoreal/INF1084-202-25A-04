# Exercice 2 - Groupes et ajout utilisateurs

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Tahar"; Prenom="Aroua"; Login="atahar"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Julie"; Login="jmartin"; OU="Stagiaires"}
)

$Groups = @{
    GroupeFormation = @()
    ProfesseursAD   = @()
}

foreach ($u in $Users) {
    if ($u.OU -eq "Stagiaires") {
        $Groups["GroupeFormation"] += $u
    }
}

Write-Output "Membres du groupe GroupeFormation :"
$Groups["GroupeFormation"]
