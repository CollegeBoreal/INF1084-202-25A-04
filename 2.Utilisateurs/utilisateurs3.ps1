# Définir la liste d'utilisateurs
$Users = @(
    @{ Name = "messi gui"; OU = "Stagiaires" },
    @{ Name = "paul kile"; OU = "Professeurs" },
    @{ Name = "lil baby"; OU = "Stagiaires" },
    @{ Name = "Alain Dupont"; OU = "Administratif" }
)

# Lister tous les utilisateurs dont le prénom contient "a" (majuscule/minuscule)
Write-Host "Utilisateurs dont le prénom contient 'a' (majuscule/minuscule) :"
$Users | Where-Object { ($_.Name.Split(" ")[0]) -match "(?i)a" } | ForEach-Object {
    Write-Host "- $($_.Name) ($($_.OU))"
}

# Lister tous les utilisateurs dans l'OU "Stagiaires"
Write-Host "`nUtilisateurs dans l'OU Stagiaires :"
$Users | Where-Object { $_.OU -eq "Stagiaires" } | ForEach-Object {
    Write-Host "- $($_.Name)"
}

