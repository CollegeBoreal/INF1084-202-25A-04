# TP : Simulation Active Directory avec PowerShell

[:tada: Participation](.scripts/Participation.md) 

## Objectifs

* Comprendre la structure AD (utilisateurs, groupes, OU).
* S’entraîner aux cmdlets PowerShell pour la création, la recherche et la manipulation d’objets.
* Se préparer aux scripts AD réels.

:bookmark: Nommez vos scripts Powershell selon le format suivant `utilisateurs`[1-4]`.ps1`

---

## 1️⃣ Création d’objets utilisateurs simulés

```powershell
# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
```

**Exercice 1** : Ajouter 2 nouveaux utilisateurs à la liste et vérifier qu’ils s’affichent correctement.

---

## 2️⃣ Création de groupes simulés

```powershell
# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter un utilisateur à un groupe
$Groups["GroupeFormation"] += $Users[0]   # Alice Dupont
```

**Exercice 2** : Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans "GroupeFormation".

---

## 3️⃣ Requêtes et filtres

```powershell
# Lister tous les utilisateurs dont le nom commence par "B"
$Users | Where-Object {$_.Nom -like "B*"}

# Lister tous les utilisateurs dans l'OU "Stagiaires"
$Users | Where-Object {$_.OU -eq "Stagiaires"}
```

**Exercice 3** : Lister tous les utilisateurs dont le prénom contient "a" (majuscule/minuscule).

---

## 4️⃣ Export et import CSV

```powershell
# Exporter les utilisateurs simulés
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"
$ImportedUsers
```

**Exercice 4** : Importer le fichier CSV et créer un groupe "ImportGroupe" en ajoutant tous les utilisateurs importés.

---

## 5️⃣ Mini-projet : script complet de simulation

1. Créer 5 utilisateurs simulés dans l’OU "Promo2025".
2. Créer un groupe "Etudiants2025".
3. Ajouter tous les utilisateurs de "Promo2025" dans le groupe.
4. Exporter la liste finale du groupe en CSV.

