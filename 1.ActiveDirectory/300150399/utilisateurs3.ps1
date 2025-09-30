# utilisateurs3.ps1
if (-not $Users) {
  $Users = @(
    @{Nom="Dupont"; Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine";Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim";  Login="kbenali";  OU="Stagiaires"},
    @{Nom="Boucher";Prenom="Amine";  Login="aboucher"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Nadia";  Login="nmartin";  OU="Stagiaires"}
  )
}
"== Nom commence par 'B' =="; $Users | Where-Object { $_.Nom -like "B*" }
"== OU = 'Stagiaires' ==";   $Users | Where-Object { $_.OU -eq "Stagiaires" }
"== Prénom contient 'a' =="; $Users | Where-Object { $_.Prenom -match '(?i)a' }
