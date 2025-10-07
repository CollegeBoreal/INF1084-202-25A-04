<<<<<<< HEAD:2.Utilisateurs/300098957/utilisateurs3.ps1
# Définir la liste des utilisateurs simulés
$Users = @(
    @{ Nom = "Alice Dupont"; Login = "adupont"; OU = "Stagiaires" }
    @{ Nom = "Sarah Lemoine"; Login = "slemoine"; OU = "Stagiaires" }
    @{ Nom = "Karim Benali"; Login = "kbenali"; OU = "Stagiaires" }
    @{ Nom = "Taylor Ngue"; Login = "tngue"; OU = "Etudiants" }
    @{ Nom = "Joyce Nguetsa"; Login = "joyngue"; OU = "Etudiants" }
    @{ Nom = "Bruno Costa"; Login = "bcosta"; OU = "Professeurs" }
)

# Lister tous les utilisateurs dont le nom commence par "B"
Write-Host "`nUtilisateurs dont le nom commence par B :"
$Users | Where-Object { $_.Nom -like "B*" } | ForEach-Object {
    Write-Host "- $($_.Nom)"
}

# Lister tous les utilisateurs dans l'OU "Stagiaires"
Write-Host "`nUtilisateurs dans l'OU 'Stagiaires' :"
$Users | Where-Object { $_.OU -eq "Stagiaires" } | ForEach-Object {
    Write-Host "- $($_.Nom)"
}

=======
﻿# Charger les utilisateurs depuis utilisateurs1.ps1
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
>>>>>>> c5f78d8119831c7a622b6367b6f0ed31790f6937:2.Utilisateurs/300150205/utilisateurs3.ps1
