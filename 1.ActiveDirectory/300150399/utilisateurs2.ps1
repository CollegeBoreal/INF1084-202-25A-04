# utilisateurs2.ps1
if (-not $Users) {
  $Users = @(
    @{Nom="Dupont"; Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine";Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim";  Login="kbenali";  OU="Stagiaires"},
    @{Nom="Boucher";Prenom="Amine";  Login="aboucher"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Nadia";  Login="nmartin";  OU="Stagiaires"}
  )
}
$Groups = @{"GroupeFormation"=@(); "ProfesseursAD"=@()}
$Groups["GroupeFormation"] += $Users[0]
$stagiaires = $Users | ForEach-Object { $_.OU = ($_.OU -replace '\s+',' ').Trim(); $_ } |
              Where-Object { $_.OU -ieq "Stagiaires" }
$Groups["GroupeFormation"] += $stagiaires
$Groups["GroupeFormation"] = $Groups["GroupeFormation"] | Group-Object Login | ForEach-Object { $_.Group[0] }
"== Membres de GroupeFormation =="; $Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom) [$($_.Login)]" }
