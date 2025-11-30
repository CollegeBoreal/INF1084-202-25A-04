## 📘 TP : Simulation Active Directory avec PowerShell
## Nom et prénom : Akrem Bouraoui
## ID : 300150527

--------------------------------------------

## 📝 Introduction

- Dans ce travail, j’ai exploré la simulation d’un environnement Active Directory en utilisant PowerShell.

- L’objectif principal était de comprendre la structure d’Active Directory (utilisateurs, groupes, OU),
et de manipuler des objets via des scripts PowerShell.

- Ce TP m’a permis de pratiquer les cmdlets PowerShell et de préparer des scripts AD réels.

---------------------------------------------------

## 🔧 Contenu du travail réalisé :
## ✔️ 1. Création d’utilisateurs simulés

J’ai exécuté le script utilisateurs1.ps1 qui permet de créer des objets utilisateurs simulés avec les attributs : Nom, Prénom, Login et OU.


<img width="837" height="210" alt="1" src="https://github.com/user-attachments/assets/69e315bc-d8fd-44af-b025-990673fc2605" />



----------------------------------------------

## ✔️ 2. Ajout des utilisateurs dans un groupe

Avec utilisateurs2.ps1, j’ai ajouté les utilisateurs dans le groupe GroupeFormation.


<img width="787" height="273" alt="2" src="https://github.com/user-attachments/assets/f8a227a4-b37e-4154-b667-720ea6ef4920" />


-------------------------------------

## ✔️ 3. Requêtes sur la liste d’utilisateurs

Dans utilisateurs3.ps1, j’ai filtré et affiché certains utilisateurs selon des conditions spécifiques (OU, lettres du nom, etc.).

<img width="762" height="185" alt="3" src="https://github.com/user-attachments/assets/2861c6dc-1abc-42af-8c1b-a3d50e5cd1a5" />


-------------------------------------------

## ✔️ 4. Export et import CSV

Le script utilisateurs4.ps1 m’a permis :
- d’importer une liste d’utilisateurs à partir d’un fichier CSV
- d’ajouter les utilisateurs dans le groupe ImportGroupe


<img width="748" height="179" alt="4" src="https://github.com/user-attachments/assets/c70f06e9-402e-40dd-8c05-9df23355bc48" />


--------------------------------------

## 📁 Structure de mon répertoire

<img width="174" height="286" alt="a" src="https://github.com/user-attachments/assets/545c4320-e8f9-4728-945e-a91de7850535" />

---------------------------------------

## 🎯 Conclusion

Ce TP m’a permis d’acquérir une meilleure compréhension du fonctionnement d’Active Directory
ainsi que de la puissance de PowerShell pour automatiser la gestion des utilisateurs et groupes.

Grâce à ces exercices, je suis maintenant plus à l’aise avec les scripts AD et prêt à travailler sur des environnements réels.
