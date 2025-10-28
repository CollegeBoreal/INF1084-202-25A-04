# 🖥️ Projet : VM's – Active Directory et Administration Windows

**Cours :** INF1084 – Administration Windows  
**Étudiant :** Chakib Rahmani (300150399)  
**Professeur :** Bryce Robert  
**Session :** Automne 2025  
**Collège :** Collège Boréal – Campus de Toronto  

---

## 🎯 Objectif du projet
Ce projet a pour but de **mettre en place une infrastructure Active Directory fonctionnelle** à l’aide de **Windows Server 2022**.  
L’objectif est de comprendre la gestion centralisée des ressources d’un réseau à travers un **domaine Active Directory (AD DS)**, en configurant les rôles de base nécessaires pour l’administration d’entreprise.

---

## 🧠 Introduction
Le projet "VM's" vise à déployer un environnement virtuel complet sous **Windows Server**, comprenant :
- l’installation du rôle **Active Directory Domain Services (AD DS)** ;
- la **création d’un domaine** (`entreprise.local`) et de sa forêt associée ;
- la **configuration du DNS intégré** ;
- la **création des unités d’organisation (OU)**, des utilisateurs, des groupes, et des GPOs ;
- la gestion des **postes clients** et **imprimantes** rattachés au domaine.

Ce travail a permis de consolider les compétences en **administration système Windows**, **PowerShell**, et **virtualisation (Hyper-V ou VirtualBox)**.

---

## 🧩 Structure du domaine Active Directory

Active Directory
└── Forêt : entreprise.local
├── Domaine principal : entreprise.local
│ ├── Contrôleur de domaine : DC-ENT-01
│ ├── OU : Utilisateurs
│ │ ├── Alice
│ │ └── Bob
│ ├── Groupe : Comptabilité
│ ├── OU : Ordinateurs
│ │ ├── PC01
│ │ ├── PC02
│ │ └── Laptop-Admin
│ ├── OU : Imprimantes
│ │ ├── HP-LaserJet
│ │ └── Canon-Color
│ └── GPOs
│ ├── Mot de passe fort
│ └── Fond d’écran uniforme
└── Domaine enfant : forma.entreprise.local
└── OU : Étudiants
├── Étudiant1
├── Étudiant2
└── PC-Classe01

yaml
Copier le code

---

## ⚙️ Étapes principales du déploiement

### 1️⃣ Préparation du serveur
- Configuration du nom d’hôte et de l’adresse IP statique  
- Installation du rôle **AD DS** via PowerShell  

### 2️⃣ Création du domaine et de la forêt
```powershell
Install-ADDSForest `
  -DomainName "entreprise.local" `
  -DomainNetbiosName "ENTREPRISE" `
  -InstallDns:$true `
  -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
  -Force
3️⃣ Vérification du domaine
powershell
Copier le code
Get-ADDomain
Get-ADForest
Get-ADDomainController -Discover
4️⃣ Création des unités et objets AD
powershell
Copier le code
Start-Process dsa.msc
.\scripts\10-ou-users.ps1
5️⃣ Application de stratégies (GPO)
Mot de passe fort : longueur minimale 12, complexité activée

Fond d’écran uniforme : déployé à l’ouverture de session

📂 Livrables du projet
Dossier / Fichier	Contenu
/scripts	Scripts PowerShell d’installation et de configuration
/captures	(optionnel) captures d’écran du domaine et des OUs
.github/workflows/ci.yml	GitHub Actions (lint PowerShell + Markdown)
README.md	Documentation complète du projet

⚡ Intégration Continue (GitHub Actions)
Ce dépôt inclut un workflow CI automatisé :

Vérifie la qualité du code PowerShell via PSScriptAnalyzer

Vérifie la mise en forme du README via markdownlint

yaml
Copier le code
.github/workflows/ci.yml
Badge de statut :


🧾 Conclusion
Grâce à ce laboratoire, l’étudiant a :

appris à installer et administrer un contrôleur de domaine Active Directory ;

compris le rôle du DNS et des GPOs dans une infrastructure réseau ;

automatisé plusieurs tâches via PowerShell ;

utilisé GitHub pour documenter et valider le travail grâce à des Actions CI.

Ce projet représente une étape importante dans la maîtrise de l’administration des systèmes Windows en environnement professionnel.

🪪 Informations
Étudiant : Chakib Rahmani (300150399)

Professeur : Bryce Robert

Cours : INF1084 – Administration Windows

Session : Automne 2025

Collège Boréal – Toronto