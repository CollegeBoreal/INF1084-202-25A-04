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

