# TP : Simulation Active Directory avec PowerShell

## Objectifs

* Comprendre la structure AD (utilisateurs, groupes, OU).
* S’entraîner aux cmdlets PowerShell pour la création, la recherche et la manipulation d’objets.
* Se préparer aux scripts AD réels.

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

# :books: References

## 🗃️ Fichier Perdu

- [ ] Rechercher la version du fichier perdu

```sh
git log --pretty=format:"%h %ad %an %s" -- 2.Utilisateurs/README.md
```
<details>
    <summary>Output</summary>
    
```powershell

97776e7 Fri Sep 26 01:29:41 2025 -0400 adjaoud-git Update README.md
f0277b5 Fri Sep 26 01:08:03 2025 -0400 adjaoud-git Ajout du README.md pour mes scripts
48a066f Fri Sep 26 00:46:31 2025 +0200 Brice Update README.md
7ad5c8c Thu Sep 25 22:20:54 2025 +0200 Brice Create README.md
```
    
</details>

- [ ] Récuperer le fichier perdu

```sh
git checkout 48a066f -- 2.Utilisateurs/README.md
git add 2.Utilisateurs/README.md
git commit -m "Restore README.md from commit 48a066f"
git push
```
