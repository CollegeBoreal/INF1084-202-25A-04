###########################################################
# 💻 INF1084 - Exercice 3 : Filtres et requêtes
# Auteur : Mohammed Aiche
# Étudiant : 300151608
###########################################################

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

Write-Host "Utilisateurs dont le nom commence par B :"
$Users | Where-Object { $_.Nom -like "B*" }

Write-Host "`nUtilisateurs dont le prénom contient la lettre a :"
$Users | Where-Object { $_.Prenom -match "a" }
