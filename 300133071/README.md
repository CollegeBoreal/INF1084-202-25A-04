# Scripts PowerShell de gestion simulée d’utilisateurs et de groupes

# 👥 Utilisateurs et Groupes simulés

> Scripts PowerShell pédagogiques pour **simuler des utilisateurs et groupes**, appliquer des filtres et **exporter/importer** en CSV.  
> ⚠️ Ces scripts **ne modifient pas** un vrai Active Directory.

---

## 📂 Structure du projet

```plaintext
2.Utilisateurs/
 └──300133071/
   ├── utilisateurs1.ps1     
   ├── utilisateurs2.ps1          
   ├── utilisateurs3.ps1          
   ├── utilisateurs4.ps1    
   └── file_utilisateurs1.csv     
```
---
## :one: utilisateur simulés

- [ ] Créer le script pour ```utilsateurs1.ps1```

```sh
nano utilisateur1.ps1
```
- [ ] Editer votre scripts pour créer vous utilisateurs

```powershell
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"}
)
```

- [ ] Exécuter le script pour Utilsateur1

```sh
.\utilisateur1.ps1
```

## 2️⃣: Groupe des utilisateurs
:secret: utiliser la commande ```"$PSScriptRoot\utilisateurs.ps1" ``` pour importer votre script utilisateur dans votre scprit groupe

## 3️⃣: Flitres
- [ ] Editer votre scripts pour créer un flitre et l'executer

## 4️⃣: Le fichier csv
- [ ] Editer votre scripts pour exporter et importer le fichier des utilisateurs
⚠️: Si apres exportation puis impoarte le resultat est vide ajouter dans votre script ```Utilsateurs1.ps1``` devant chaque utilisateur ```[PSCustomObject]```pour mettre vos utilisateur sous forme d’objets PowerShell
``` powershell
$Users = @(
    [PSCustomObject]@{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"}
)
```
Faites attention au chemin dans vos script vous pouvez utiliser ```$exportPath = "C:\Users\kelek\Documents\developer\INF1084-202-25A-03\2.Utilisateurs\300133071\UsersSimules.csv"``` pour definit un chemin 
