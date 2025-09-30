<# ==========================================================
 TP : Simulation Active Directory avec PowerShell
 Auteur : Niang Abdou Karim (ID 300141858)
 Dossier : 2.Utilisateurs
========================================================== #>

# Exemple : création de quelques utilisateurs
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
