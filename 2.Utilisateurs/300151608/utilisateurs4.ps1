###########################################################
# 💻 INF1084 - Exercice 4 : Export et import CSV
# Auteur : Mohammed Aiche
# Étudiant : 300151608
# Collège Boréal
###########################################################

# Étape 1 : Création d’utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Étape 2 : Exporter la liste en CSV
$Path = "C:\Temp\UsersSimules.csv"
$Users | Export-Csv -Path $Path -NoTypeInformation
Write-Host "✅ Exportation terminée : $Path"

# Étape 3 : Importer le fichier CSV
$ImportedUsers = Import-Csv -Path $Path
Write-Host "`n📂 Utilisateurs importés depuis CSV :"
$ImportedUsers | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login)" }
