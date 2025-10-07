  # utilisateurs2.ps1
# Exercice 2 : Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans GroupeFormation
# utilisateurs2.ps1
Write-Host "--- Membres de GroupeFormation ---"

# Liste des utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Moulin"; Prenom="Jean"; Login="jmoulin"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Paul"; Login="pmartin"; OU="Informatique"}
)
# Exécuter le script utilisateur1.ps1 pour charger les données
& ".\utilisateurs1.ps1"

# Création des groupes
# Initialiser les groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
    "ProfesseursAD"   = @()
}

# Ajouter tous les utilisateurs avec OU = Stagiaires dans GroupeFormation
# Ajouter tous les stagiaires
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher les utilisateurs du groupe
"Utilisateurs dans GroupeFormation :"
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
# Afficher les membres du groupe
Write-Host "--- Membres de GroupeFormation ---"
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom)"
}
