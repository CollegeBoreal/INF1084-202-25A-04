# utilisateurs1.ps1
# Exercice 1 : 

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

$Users += @{Nom="imad"; Prenom="ozgur"; Login="jimad"; OU="Stagiaires"}
$Users += @{Nom="Zebi"; Prenom="kiri"; Login="dzebi"; OU="Stagiaires"}

$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }U: $($_.OU)" }