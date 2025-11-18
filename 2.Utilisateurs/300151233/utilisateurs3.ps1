# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Bernard"; Prenom="Emma"; Login="ebernard"; OU="Stagiaires"}
)

# Lister tous les utilisateurs dont le prénom contient "a" (majuscule/minuscule)
Write-Host "Utilisateurs dont le prénom contient 'a' :"
$Users | Where-Object {$_.Prenom -like "*a*"} | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login)"
}