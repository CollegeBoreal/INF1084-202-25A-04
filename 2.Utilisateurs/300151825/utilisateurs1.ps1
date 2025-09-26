# Fichier : utilisateurs1.ps1
# Contient les utilisateurs et les groupes simulés

# Création des utilisateurs (liste de hashtables)
$Utilisateurs = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Thierry"; Login="tnguyen"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Julie"; Login="jmartin"; OU="Stagiaires"}
)

# Création des groupes (hashtable qui contient des tableaux d’utilisateurs)
$Groupes = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
    "ImportGroupe"    = @()
}

# Ajouter tous les utilisateurs dans les groupes appropriés
foreach ($u in $Utilisateurs) {
    if ($u.OU -eq "Stagiaires") {
        $Groupes["GroupeFormation"] += $u
        $Groupes["ImportGroupe"]    += $u
    }
}

# Affichage de vérification
"=== Utilisateurs ==="
$Utilisateurs

"=== Groupes ==="
$Groupes

