# Étape 1 :le chemin du fichier CSV (dans le même dossier que le script)
$CsvPath = Join-Path -Path $PSScriptRoot -ChildPath "UsersSimules.csv"

# Étape 2 : Importer le fichier CSV
$ImportedUsers = Import-Csv -Path $CsvPath

# Étape 3 : Créer un nouveau groupe simulé
$Groups = @{}
$Groups["ImportGroupe"] = @()

# Étape 4 : Ajouter tous les utilisateurs importés dans le groupe
foreach ($user in $ImportedUsers) {
    $Groups["ImportGroupe"] += $user
}

# Étape 5 : Afficher le contenu du groupe pour vérification
$Groups["ImportGroupe"]
