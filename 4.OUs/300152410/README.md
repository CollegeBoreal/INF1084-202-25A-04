# 🧠 TP – Gestion des utilisateurs Active Directory avec PowerShell

| Champ | Détails |
|-------|----------|
| **Nom complet** | BOUDEUF I;QD |
| **Numéro étudiant** | 300152410 |
| **Instance** | 0 |
| **Domaine** | DC300152410-00.local |
| **Cours** | INF1084 – Administration des systèmes Windows Server |
| **Établissement** | Collège Boréal |

---

## 🎯 Objectif du TP
Ce TP a pour objectif de gérer les comptes utilisateurs, les OU et les groupes de sécurité dans **Active Directory** à l’aide de **PowerShell**.

À la fin, tu seras capable de :
- Créer, modifier et supprimer des utilisateurs,
- Organiser les OU,
- Gérer les comptes (désactivation, réactivation, export CSV),
- Appliquer le principe du moindre privilège.

---

## 📘 Étapes principales du script PowerShell

### 1️⃣ Configuration et Listage (`utilisateurs1.ps1`)
- Définition des variables du domaine  
- Importation du module AD  
- Liste des utilisateurs actifs  

### 2️⃣ Création et Modification (`utilisateurs2.ps1`)
- Création d’un utilisateur (Alice Dupont)  
- Modification d’attributs et description  

### 3️⃣ Gestion des comptes (`utilisateurs3.ps1`)
- Désactivation / Réactivation  
- Filtrage par nom  
- Export vers CSV  

### 4️⃣ Gestion des OU et Nettoyage (`utilisateurs4.ps1`)
- Création de l’OU *Students*  
- Déplacement d’un utilisateur  
- Vérification finale  

---

## 📸 Captures d’écran à insérer
- Étape 1 – Vérification du domaine  
- Étape 2 – Création utilisateur  
- Étape 3 – Export CSV  
- Étape 4 – OU créée  

---

## 🚀 Résultat final
Tous les scripts s’exécutent correctement et les utilisateurs sont bien créés et gérés dans le domaine **DC300152410-00.local**.
