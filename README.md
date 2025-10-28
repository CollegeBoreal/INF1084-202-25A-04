# TP Active Directory - OU
#300150395

---

Ce TP est divisé en **4 fichiers PowerShell** :

### 📄 **utilisateurs1.ps1** - Configuration et Listage
- Configuration initiale des variables de domaine
- Vérification de l'environnement Active Directory
- Listage des utilisateurs actifs du domaine

### 📄 **utilisateurs2.ps1** - Création et Modification
- Création d’un utilisateur (Alice Dupont)
- Modification de ses attributs (email, prénom, etc.)

### 📄 **utilisateurs3.ps1** - Gestion des comptes
- Désactivation et réactivation
- Suppression d’un utilisateur
- Recherche avec filtres et export CSV

### 📄 **utilisateurs4.ps1** - Gestion des OU
- Création de l’OU “Students”
- Déplacement d’utilisateurs dans cette OU

---

## 🚀 Étapes du TP

### Étape 0 : Configuration du domaine
```powershell
$studentNumber = 300150395
$studentInstance = "00"

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"
