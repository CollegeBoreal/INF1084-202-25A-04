Write-Host "=== Script 3 : Requêtes et filtres ==="

# Dot-sourcing
Write-Host "Chargement des utilisateurs depuis Script 1..."
. .\utilisateurs1.ps1
Write-Host "Utilisateurs chargés."

Write-Host "--- Recherche : noms commençant par 'B' ---"
$Users | Where-Object {$_.Nom -like "B*"} | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom)"
}

Write-Host "--- Recherche : utilisateurs dans l'OU Stagiaires ---"
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom)"
}

Write-Host "--- Exercice 3 : prénoms contenant 'a' ou 'A' ---"
$Users | Where-Object {$_.Prenom -match "a"} | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom)"
}

Write-Host "Fin des requêtes."
