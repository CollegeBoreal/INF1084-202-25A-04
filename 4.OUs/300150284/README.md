# TP Active Directory – Gestion des utilisateurs via PowerShell

Ce dépôt contient l’ensemble des scripts PowerShell nécessaires pour :

- Préparer l’environnement Active Directory
- Gérer les utilisateurs (CRUD)
- Rechercher et exporter les comptes
- Créer une OU et déplacer un utilisateur

Chaque étudiant possède un domaine unique basé sur son **numéro d’étudiant**.

---

## 📁 Contenu du Projet

| Fichier | Description |
|--------|-------------|
| **utilisateurs1.ps1** | Initialisation du domaine, variables, connexion sécurisée |
| **utilisateurs2.ps1** | Création, modification, désactivation, suppression d'utilisateurs |
| **utilisateurs3.ps1** | Recherche d'utilisateurs + export CSV |
| **utilisateurs4.ps1** | Création de l’OU Students + Move-ADObject |

---

## 🧩 1. Variables étudiantes

```powershell
$studentNumber = 300098957
$studentInstance = 40
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"
