# 🧠 Laboratoire Active Directory : Objets gérables et GPO

## 👤 Étudiant

* **Nom :** HAMMICHE
* **Prénom :** MOHAND L'hacene
* **ID Étudiant :** 300151492

---

## 🌐 Sujet du laboratoire

**Titre :** Objets gérables par Active Directory et automatisation via GPO (Group Policy Object)
Ce laboratoire vise à manipuler les principaux objets Active Directory (utilisateurs, groupes, OU, ordinateurs, etc.) et à automatiser la gestion des ressources réseau à l'aide de PowerShell et des GPO.

---

## 🎯 Objectifs

1. Comprendre les objets AD et leur utilité.
2. Créer et partager un dossier réseau SMB.
3. Créer des utilisateurs et groupes AD.
4. Mapper un lecteur réseau (Z:) via un GPO.
5. Activer le RDP pour un groupe spécifique.
6. Tester les accès et permissions.

---

## 🧩 Environnement requis

* Windows Server 2022 avec AD DS installé
* Modules PowerShell : `ActiveDirectory`, `GroupPolicy`
* VM membre du domaine pour les tests
* Domaine : `DC300151492-00.local`
* OU : `Students`

---

## 🏗️ Étapes du laboratoire

### 1️⃣ Création du dossier partagé et du groupe AD

**Script : `utilisateurs1.ps1`**
```powershell
