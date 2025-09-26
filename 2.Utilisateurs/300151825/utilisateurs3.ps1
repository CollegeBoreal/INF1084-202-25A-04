# Fichier : utilisateurs1.ps1
# Contient les utilisateurs et les groupes simulés

# Création des utilisateurs
System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Thierry"; Login="tnguyen"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Julie"; Login="jmartin"; OU="Stagiaires"}
)

# Création des groupes
System.Collections.Hashtable = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
    "ImportGroupe" = @()
}

# Ajouter tous les utilisateurs dans les groupes appropriés
foreach (System.Collections.Hashtable in System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable) {
    if (System.Collections.Hashtable.OU -eq "Stagiaires") {
        System.Collections.Hashtable["GroupeFormation"] += System.Collections.Hashtable
        System.Collections.Hashtable["ImportGroupe"] += System.Collections.Hashtable
    }
}
