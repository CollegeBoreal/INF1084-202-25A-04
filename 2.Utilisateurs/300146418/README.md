# Mini-projet PowerShell – Gestion des utilisateurs simulés

## Auteur
Ikram

---

## Description générale
Ce projet consiste à créer des utilisateurs simulés dans PowerShell, à les organiser dans des groupes, à filtrer les utilisateurs selon certains critères, et à exporter/importer les données via des fichiers CSV. Il inclut également un mini-projet complet combinant toutes ces étapes.

Ce projet consiste à :

1. Créer des utilisateurs simulés avec des informations (Nom, Prénom, Login, OU).  
2. Créer des groupes simulés et y ajouter des utilisateurs selon certaines conditions.  
3. Filtrer et afficher des utilisateurs selon des critères précis (prénom, nom, OU).  
4. Exporter et importer des utilisateurs via des fichiers CSV.  
5. Réaliser un mini-projet complet combinant toutes ces étapes.

---

## Fichiers inclus

- `Utilisateur1.ps1` : Création de 5 utilisateurs simulés.  
- `Utilisateur2.ps1` : Filtrage des utilisateurs selon différentes conditions.  
- `Utilisateur3.ps1` : Filtrage des utilisateurs dont le prénom ou le nom contient certaines lettres.  
- `Utilisateur4.ps1` : Importation depuis un CSV et création d’un groupe avec tous les utilisateurs importés.  
- `Etudiants2025.csv` : Fichier CSV généré pour le mini-projet.  
- `Projet.ps1` : Mini-projet complet combinant la création d’utilisateurs, de groupe et l’export CSV.  
- `UsersSimules.csv` : CSV des utilisateurs exporté depuis `Utilisateur1.ps1`.

---


## Commandes PowerShell utilisées

| Étape | Commande | Description |
|-------|----------|-------------|
| Modifier la politique d’exécution | `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned` | Autoriser l’exécution des scripts PowerShell bloqués par défaut |
| Exécuter les scripts | `.\Ikram1.ps1`<br>`.\Utilisateur1.ps1`<br>`.\Utilisateur2.ps1`<br>`.\Utilisateur3.ps1`<br>`.\Utilisateur4.ps1`<br>`.\Projet.ps1` | Exécution de tous les scripts du projet |
| Export CSV | `$Users \| Export-Csv -Path "C:\Users\ikram\Developer\INF1084-202-25A-03\2.Utilisateurs\300146418\UsersSimules.csv" -NoTypeInformation -Encoding UTF8` | Exporter les utilisateurs simulés vers un fichier CSV |
| Import CSV | `$ImportedUsers = Import-Csv -Path "C:\Users\ikram\Developer\INF1084-202-25A-03\2.Utilisateurs\300146418\UsersSimules.csv"` | Importer les utilisateurs depuis le fichier CSV |

---

## Commandes Git utilisées

| Étape | Commande | Description |
|-------|----------|-------------|
| Vérifier l’état du dépôt | `git status` | Voir les fichiers modifiés et non suivis |
| Ajouter tous les fichiers | `git add .` | Ajouter tous les fichiers au suivi Git |
| Supprimer un fichier du dépôt et du disque | `git rm Ikram1.ps1` | Supprimer définitivement le fichier du dépôt et du disque |
| Supprimer du dépôt seulement | `git rm --cached Ikram1.ps1` | Supprimer du dépôt mais garder le fichier local |
| Modifier le message du dernier commit | `git commit --amend -m "300146418 : Supprimer Ikram1.ps1"` | Modifier le message du dernier commit |
| Pousser les changements | `git push`<br>`git push --force` | Envoyer les changements vers GitHub |

---

## Erreurs rencontrées et solutions

| Erreur | Cause | Solution |
|--------|-------|---------|
| Scripts bloqués | PowerShell bloque l’exécution (`running scripts is disabled on this system`) | `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned` |
| CSV incorrect ou non trouvé | Export de `$Groups` au lieu de `$Users` ou chemin `C:\Temp` inexistant | Exporter `$Users` vers un chemin existant (`300146418`) et créer le dossier si nécessaire |
| Filtrage des utilisateurs incorrect | Filtrage seulement sur `Prenom` et majuscules/minuscules non gérées | Filtrer avec `Where-Object { $_.Prenom -match "[aA]" -or $_.Nom -match "[aA]" }` |

---

## Instructions d’exécution

1. Cloner le dépôt :  
```bash
git clone <URL-de-ton-repo>
```
2. Aller dans le dossier des scripts :
```bash

cd .Utilisateurs/300146418
```

3.Exécuter les scripts PowerShell dans l’ordre :
```bash

.\Utilisateur1.ps1
.\Utilisateur2.ps1
.\Utilisateur3.ps1
.\Utilisateur4.ps1
.\Projet.ps1


Les fichiers CSV seront générés automatiquement dans le dossier 300146418.
```
4.Résultat attendu
```bash

Tous les scripts PowerShell fonctionnent correctement et affichent les utilisateurs filtrés ou groupés.

Les fichiers CSV (UsersSimules.csv et Etudiants2025.csv) sont correctement générés.
```




