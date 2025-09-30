# Charger les utilisateurs depuis utilisateurs1.ps1
. ".\utilisateurs1.ps1"

# Convertir les hash tables en objets pour pouvoir filtrer
$UsersObj = $Users | ForEach-Object { [PSCustomObject]$_ }

# -----------------------------
# Exercice 1 : Nom commence par "B"
# -----------------------------
Write-Host "`n--- Utilisateurs dont le nom commence par 'B' ---"
$UsersObj | Where-Object { $_.Nom -like "B*" } | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# -----------------------------
# Exercice 2 : OU = "Stagiaires"
# -----------------------------
Write-Host "`n--- Utilisateurs dans l'OU 'Stagiaires' ---"
$UsersObj | Where-Object { $_.OU -eq "Stagiaires" } | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# -----------------------------
# Exercice 3 : Prénom contient "a" (insensible à la casse)
# -----------------------------
Write-Host "`n--- Utilisateurs dont le prénom contient 'a' ---"
$UsersObj | Where-Object { $_.Prenom -match "(?i)a" } | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}