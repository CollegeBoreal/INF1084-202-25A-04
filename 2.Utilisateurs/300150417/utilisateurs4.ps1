# utilisateurs4.ps1
# Exercice 4 : Importer le fichier CSV et créer un groupe ImportGroupe avec les utilisateurs importés

# Importer les utilisateurs depuis le fichier CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Créer un groupe ImportGroupe
$Groups = @{
    "ImportGroupe" = @()
}

# Ajouter tous les utilisateurs importés dans ImportGroupe
$Groups["ImportGroupe"] += $ImportedUsers

# Afficher les utilisateurs du groupe ImportGroupe
"Utilisateurs dans ImportGroupe :"
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

