# 🧠 TP Active Directory – Gestion des utilisateurs avec PowerShell

## 👨‍🎓 Étudiant
**Nom :** Massinissa Mameri  
**ID Boréal :** 300151841  
**Domaine :** DC300151841-00.local  
**Cours :** INF1084 – Administration Windows  
  
**Date :** 11 novembre 2025  

---

## 🎯 Objectif du TP
Ce travail pratique a pour but de manipuler les comptes utilisateurs Active Directory à l’aide de PowerShell.  
L’étudiant doit être capable de :

- Créer et gérer des utilisateurs dans un domaine AD  
- Modifier, activer, désactiver ou supprimer un utilisateur  
- Créer une unité d’organisation (OU) nommée *Students*  
- Déplacer des utilisateurs depuis *CN=Users* vers *OU=Students*  
- Exporter la liste des utilisateurs dans un fichier CSV  

---

## ⚙️ Environnement utilisé
- **Machine virtuelle Windows Server 2022 (VM du Collège Boréal)**  
- **PowerShell en mode Administrateur**  
- **Module ActiveDirectory installé et importé**  
- Domaine configuré : **DC300151841-00.local**

---

## 🧩 Étapes de réalisation

### 1️⃣ Préparation de l’environnement
Création du dossier de travail et initialisation du fichier `README.md` et `bootstrap.ps1`.
 

### 2️⃣ Clonage du dépôt du cours
Clonage du dépôt GitHub du cours dans le dossier `Developer`.
 
---

### 3️⃣ Configuration du fichier `bootstrap.ps1`
Définition des variables : numéro étudiant, instance, domaine, et informations d’authentification.

![wait](https://github.com/user-attachments/assets/891bd77b-9bca-46ac-806c-75b652afdbb5")


---

### 4️⃣ Vérification du domaine et du contrôleur AD
Utilisation de `Get-ADDomain` et `Get-ADDomainController` pour valider la configuration.


---

### 5️⃣ Liste des utilisateurs existants
Affichage de tous les comptes utilisateurs actifs dans le domaine.

![wait](https://github.com/user-attachments/assets/c9a74267-8fe1-4f61-ab29-11eb5430ccf3")


---

### 6️⃣ Création d’un utilisateur
Création d’un utilisateur nommé **Alice Dupont** via PowerShell.
![wait](https://github.com/user-attachments/assets/d8734899-c626-4b88-9f33-a59d4a0803fb")


---

### 7️⃣ Modification des informations utilisateur
Mise à jour du prénom et ajout d’une adresse courriel à l’utilisateur.

![wait](https://github.com/user-attachments/assets/a1e82260-92d9-43d2-a7f8-12d8a0efbb08")


---

### 8️⃣ Désactivation et réactivation du compte
Test des commandes `Disable-ADAccount` et `Enable-ADAccount`.


![wait](https://github.com/user-attachments/assets/1211fea0-fa43-435c-898a-c6201aabb0e0")


---
 ---

### 🔁 Réactivation du compte utilisateur
Après avoir testé la désactivation, le compte **Alice Dupont** a été réactivé avec la commande suivante :

```powershell
Enable-ADAccount -Identity "alice.dupont"
Get-ADUser -Identity "alice.dupont" -Properties Enabled | Select Name, Enabled

![wait](https://github.com/user-attachments/assets/f6222c48-e31b-4e32-888c-b2cb02e73c14")

-----

---

### 🏗️ Création de l’unité d’organisation (OU) “Students”
Une nouvelle unité d’organisation nommée **Students** a été créée à la racine du domaine à l’aide de la commande suivante :

```powershell
New-ADOrganizationalUnit -Name "Students"
Get-ADOrganizationalUnit -Filter * | Select Name, DistinguishedName

![wait](https://github.com/user-attachments/assets/05d4b7aa-5106-4323-a27e-deb3b3d2582d")

-------

---

### 👩‍💻 Déplacement de l’utilisateur vers l’OU “Students”

Une fois l’unité d’organisation **Students** créée, l’utilisateur **Alice Dupont** a été déplacé du conteneur par défaut *CN=Users* vers cette nouvelle OU.  
Cette opération permet de mieux organiser les comptes utilisateurs dans le domaine Active Directory.

**Commandes exécutées :**
```powershell
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=DC300151841-00,DC=local" `
              -TargetPath "OU=Students,DC=DC300151841-00,DC=local"
Get-ADUser -Identity "alice.dupont" | Select Name, DistinguishedName

![wait](https://github.com/user-attachments/assets/8963c122-1265-4a73-98d7-eb221fc12439")


 
