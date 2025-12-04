# utilisateurs4.ps1
# Exercice 4 :

# Importer les utilisateurs depuis le fichier CSV (dans le même dossier que le script)
$ImportedUsers = Import-Csv -Path ".\UsersSimules.csv"

# Créer un groupe ImportGroupe (structure de données)
$Groups = @{
    "ImportGroupe" = @()
}

# Ajouter tous les utilisateurs importés dans ImportGroupe
$Groups["ImportGroupe"] += $ImportedUsers

# Afficher les utilisateurs du groupe ImportGroupe
"Utilisateurs dans ImportGroupe :"
$Groups["ImportGroupe"] | ForEach-Object {
    "$($_.Prenom) $($_.Nom)"
}