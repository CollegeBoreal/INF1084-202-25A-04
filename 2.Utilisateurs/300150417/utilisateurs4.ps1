# utilisateurs4.ps1
# Exercice 4 : Importer le fichier CSV et créer un groupe ImportGroupe avec les utilisateurs

# Importer les utilisateurs depuis le fichier CSV (dans le même dossier que le script)
$ImportedUsers = Import-Csv -Path ".\UsersSimules.csv"

# Créer un groupe ImportGroupe
$Groups = @{
    "ImportGroupe" = @()
}

# Ajouter tous les utilisateurs importés dans ImportGroupe
$Groups["ImportGroupe"] += $ImportedUsers

# Afficher les utilisateurs du groupe ImportGroupe
"Utilisateurs dans ImportGroupe :"
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

