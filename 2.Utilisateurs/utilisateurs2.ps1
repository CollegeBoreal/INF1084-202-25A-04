# utilisateurs2.ps1
# -----------------
# Charger les utilisateurs depuis utilisateurs1.ps1
$Users = @(
@{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"}, 
@{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},                                                    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},                
@{Nom="durk"; Prenom="Smurkio"; Login="lil"; OU="Stagiaires"},
@{Nom="Moussa"; Prenom="Sow"; Login="soul"; OU="Stagiaires"},                                                                                                   @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},                                                      @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},                            
@{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"})
# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter tous les utilisateurs de l'OU "Stagiaires" dans GroupeFormation
foreach ($user in $Users) {
    if ($user.OU -eq "Stagiaires") {
        $Groups["GroupeFormation"] += $user
    }
}

# Afficher tous les utilisateurs
Write-Host "=== Liste des utilisateurs ==="
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

# Afficher le contenu du groupe "GroupeFormation"
Write-Host "`n=== Contenu du groupe GroupeFormation ==="
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

