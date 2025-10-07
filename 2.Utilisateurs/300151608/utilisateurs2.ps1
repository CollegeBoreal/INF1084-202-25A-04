# On importe ou redéfinit la liste des utilisateurs simulés
$Users = @(
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Keller"; Prenom="Marc"; Login="mkeller"; OU="Stagiaires"},
    @{Nom="Boucher"; Prenom="Amira"; Login="aboucher"; OU="Stagiaires"},
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"}
)

# Création des groupes simulés
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs avec OU = "Stagiaires" dans GroupeFormation
$Users | Where-Object { $_.OU -eq "Stagiaires" } | ForEach-Object {
    $Groups["GroupeFormation"] += $_
}

Write-Host "Utilisateurs ajoutés dans GroupeFormation :"
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom)"
}

