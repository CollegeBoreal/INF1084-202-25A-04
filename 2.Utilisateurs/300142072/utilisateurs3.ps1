# Importer la liste des utilisateurs
. .\utilisateurs1.ps1

Write-Output "=== Utilisateurs dont le prénom ou le nom contient 'a' (insensible à la casse) ==="

# Filtrer sur prénom OU nom
$Users | Where-Object { $_.Prenom -match "a"} | ForEach-Object {
    Write-Output "$($_.Prenom)"
}


