# --- utilisateurs2.ps1 ---
# Recréer la même liste pour rendre le script autonome
$Users = @(
    @{Nom="Dupont";  Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim";  Login="kbenali";  OU="Stagiaires"},
    @{Nom="Martin";  Prenom="Nora";   Login="nmartin";  OU="Stagiaires"},
    @{Nom="Bernard"; Prenom="Amine";  Login="abernard"; OU="Stagiaires"}
)

# 2) Créer des groupes
$Groups = @{
  "GroupeFormation" = @()
  "ProfesseursAD"   = @()
}

# Exemple (déjà donné) : ajouter un utilisateur à un groupe
$Groups["GroupeFormation"] += $Users[0]   # Alice Dupont

# Exercice 2 : Ajouter tous les utilisateurs dont OU = "Stagiaires" dans "GroupeFormation"
$Groups["GroupeFormation"] += ($Users | Where-Object {$_.OU -eq "Stagiaires"})

# Afficher le contenu du groupe
$Groups["GroupeFormation"] | Select Prenom, Nom, Login, OU | Format-Table -AutoSize