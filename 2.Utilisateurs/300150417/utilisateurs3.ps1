# utilisateurs3.ps1
# Exercice 3 : Lister tous les utilisateurs dont le prénom contient "a"

# Liste des utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Moulin"; Prenom="Jean"; Login="jmoulin"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Paul"; Login="pmartin"; OU="Informatique"}
)

# Filtrer et afficher les prénoms qui contiennent la lettre "a"
$Users | Where-Object { $_.Prenom -match "a" } | ForEach-Object {
    "$($_.Prenom) $($_.Nom)"
}

