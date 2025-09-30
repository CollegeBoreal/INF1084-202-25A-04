# Exercice 2 : groupes + ajouter tous les Stagiaires à GroupeFormation
$Users = @(
    @{Nom="Dupont";  Prenom="Alice"; Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim"; Login="kbenali";  OU="Stagiaires"},
    @{Nom="Martin";  Prenom="Jean";  Login="jmartin";  OU="Stagiaires"},
    @{Nom="Nguyen";  Prenom="Lina";  Login="lnguyen";  OU="Stagiaires"}
)
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}
$stagiaires = $Users | Where-Object { $_.OU -eq "Stagiaires" }
$Groups["GroupeFormation"] += $stagiaires
"=== Membres de GroupeFormation ==="
$Groups["GroupeFormation"] | ForEach-Object {
    "{0} {1} ({2}) - OU: {3}" -f $_.Prenom, $_.Nom, $_.Login, $_.OU
}
