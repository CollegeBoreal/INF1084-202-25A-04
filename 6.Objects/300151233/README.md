# 300151233 - Laboratoire: Partage de ressources et RDP via PowerShell

**Étudiant :** Syphax  
**Cours :** INF1084-202-25A-04  
**Collège :** Collège Boréal

## 📋 Objectifs

- Créer un dossier partagé sur le DC
- Créer un groupe AD Students et des utilisateurs
- Partager le dossier avec le groupe
- Créer une GPO pour mapper automatiquement un lecteur réseau
- Activer RDP pour le groupe Students

## 🔧 Pré-requis

- DC Windows Server 2022 avec AD DS
- Module ActiveDirectory et GroupPolicy
- Domaine: DC300151233-00.local

## 📁 Scripts

1. **utilisateurs1.ps1** - Créer dossier partagé, groupe et utilisateurs
2. **utilisateurs2.ps1** - Créer GPO pour mapper le lecteur réseau

## 🚀 Exécution
```powershell
# Charger bootstrap
. ..\..\..\4.OUs\300151233\bootstrap.ps1

# Exécuter
.\utilisateurs1.ps1
.\utilisateurs2.ps1
```

## ⚙️ Configuration

- Dossier: C:\SharedResources
- Partage: \\\\DC300151233-00\\SharedResources
- Groupe: Students
- Utilisateurs: Etudiant1, Etudiant2
- Lecteur: Z:
- Mot de passe: Pass123!

## 📸 Captures d'écran

Les captures d'écran sont dans le dossier images/.

---

**Date :** Novembre 2025
