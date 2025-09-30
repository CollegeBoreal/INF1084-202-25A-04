# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Ajouter 2 nouveaux utilisateurs
$Users += @{Nom="boubou"; Prenom="zaza"; Login="mama"; OU="Stagiaires"}
$Users += @{Nom="gringo"; Prenom="kiki"; Login="kaka"; OU="Stagiaires"}

# Afficher tous les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs dont OU = "Stagiaires" dans GroupeFormation
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher le groupe GroupeFormation
Write-Host "`n--- GroupeFormation ---"
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Lister tous les utilisateurs dont le nom commence par "B"
Write-Host "`n--- Utilisateurs dont le nom commence par 'B' ---"
$Users | Where-Object {$_.Nom -like "B*"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Lister tous les utilisateurs dans l'OU "Stagiaires"
Write-Host "`n--- Utilisateurs dans l'OU 'Stagiaires' ---"
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Exercice 3 : Lister tous les utilisateurs dont le prénom contient "a"
Write-Host "`n--- Utilisateurs dont le prénom contient 'a' ---"
$Users | Where-Object { $_.Prenom -match "(?i)a" } | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Exporter les utilisateurs simulés
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Créer le groupe ImportGroupe et ajouter les utilisateurs importés
$Groups["ImportGroupe"] = @()
$Groups["ImportGroupe"] += $ImportedUsers

# Afficher le groupe ImportGroupe
Write-Host "`n--- ImportGroupe ---"
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }


