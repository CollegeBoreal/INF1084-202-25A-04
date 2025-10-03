# utilisateurs2.ps1
$Users = @(
    @{Nom="Durand"; Prenom="Emma"; Login="edurand"; OU="Stagiaires"},
    @{Nom="Moreau"; Prenom="Paul"; Login="pmoreau"; OU="Stagiaires"}
@{Nom="Lionel"; Prenom="Messi"; Login="LM10"; OU="Stagiaires"},
@{Nom="Cristiano"; Prenom="Ronaldo"; Login="CR7"; OU="Stagiaires"},
@{Nom="Neymar"; Prenom="junior"; Login="NJ10"; OU="Stagiaires"}
)

$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

