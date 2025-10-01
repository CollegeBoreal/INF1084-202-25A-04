# =========================================================
# Script : utilisateurs2.ps1
# Description : Création de groupes simulés et ajout des stagiaires
# =========================================================

# 1. Créer une liste d'utilisateurs simulés
$users = @(
    @{Nom="Dupont";     Prenom="Alice";    Login="adupont";      OU="Stagiaires"},
    @{Nom="Lemoine";    Prenom="Sarah";    Login="slemoine";     OU="Stagiaires"},
    @{Nom="Benali";     Prenom="Karim";    Login="kbenali";      OU="Stagiaires"},
    @{Nom="Saoudi";     Prenom="Allaoua";  Login="asaoudi";      OU="Stagiaires"},
    @{Nom="Boukacouma"; Prenom="Mahmoud";  Login="mboukacouma";  OU="Stagiaires"}
)

# 2. Créer des groupes simulés
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# 3. Exercice 2 : Ajouter tous les utilisateurs dont OU = "Stagiaires" dans GroupeFormation
$Groups["GroupeFormation"] += $users | Where-Object { $_.OU -eq "Stagiaires" }

# 4. Afficher les membres du groupe GroupeFormation
Write-Output "`nMembres du groupe GroupeFormation :"
$Groups["GroupeFormation"] | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login)"
}




  


