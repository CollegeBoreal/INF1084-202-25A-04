# Gestion des Utilisateurs Active Directory - TP INF1084

Scripts PowerShell pour la gestion des utilisateurs dans Active Directory.

**Étudiant:** 300150284  
**Instance:** 00  
**Domaine:** DC300150284-00.local

---

## 📋 Table des matières

- [Prérequis](#prérequis)
- [Structure des fichiers](#structure-des-fichiers)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Scripts disponibles](#scripts-disponibles)
- [Dépannage](#dépannage)
- [Notes importantes](#notes-importantes)

---

## 🔧 Prérequis

- Windows Server avec Active Directory Domain Services (AD DS) installé
- Rôle de contrôleur de domaine configuré
- Module PowerShell Active Directory
- Droits d'administrateur de domaine
- Services requis en cours d'exécution :
  - ADWS (Active Directory Web Services)
  - DNS
  - NTDS (Active Directory Domain Services)
  - Netlogon

---

## 📁 Structure des fichiers

```
300150284/
│
├── bootstrap.ps1          # Configuration de base (domaine, credentials)
├── utilisateurs1.ps1      # Préparation et listing des utilisateurs
├── utilisateurs2.ps1      # Création et modification d'utilisateurs
├── utilisateurs3.ps1      # Désactivation, réactivation et suppression
├── utilisateurs4.ps1      # Recherche, export CSV et déplacement vers OU
├── diagnostic.ps1         # Diagnostic de l'environnement AD
├── cleanup.ps1            # Nettoyage des utilisateurs de test
└── README.md              # Ce fichier
```

---

## 🚀 Installation

1. **Cloner ou télécharger les scripts** dans un répertoire de travail :
   ```powershell
   cd C:\Users\Administrator\Developer\INF1084-202-25A-04\4.OUs\300150284
   ```

2. **Vérifier la politique d'exécution PowerShell** :
   ```powershell
   Get-ExecutionPolicy
   ```

3. **Si nécessaire, autoriser l'exécution de scripts** :
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

4. **Vérifier que le module Active Directory est disponible** :
   ```powershell
   Import-Module ActiveDirectory
   Get-Module ActiveDirectory
   ```

---

## 📖 Utilisation

### Configuration initiale

Tous les scripts chargent automatiquement le fichier `bootstrap.ps1` qui contient :
- Numéro d'étudiant : 300150284
- Instance : 00
- Nom de domaine : DC300150284-00.local
- Credentials administrateur (mot de passe : Infra@2024)

### Exécution des scripts

**Option 1 : Exécution séquentielle (recommandée pour la première fois)**
```powershell
.\diagnostic.ps1      # 1. Vérifier l'environnement
.\utilisateurs1.ps1   # 2. Lister les utilisateurs existants
.\utilisateurs2.ps1   # 3. Créer et modifier des utilisateurs
.\utilisateurs3.ps1   # 4. Désactiver/réactiver/supprimer
.\utilisateurs4.ps1   # 5. Rechercher et exporter
```

**Option 2 : Exécution individuelle**
```powershell
.\utilisateurs2.ps1   # Exécuter un script spécifique
```

**Option 3 : Nettoyage de l'environnement**
```powershell
.\cleanup.ps1         # Supprimer les utilisateurs de test
```

---

## 📜 Scripts disponibles

### 1️⃣ bootstrap.ps1
**Configuration de base**
- Définit les variables globales (domaine, credentials)
- Chargé automatiquement par tous les autres scripts
- À modifier si vos informations changent

### 2️⃣ diagnostic.ps1
**Diagnostic de l'environnement AD**
- Vérifie les informations système
- Contrôle l'état des services AD (ADWS, DNS, NTDS, Netlogon)
- Teste la résolution DNS
- Affiche la configuration réseau
- Vérifie si le serveur est un contrôleur de domaine
- Fournit des recommandations

**Utilisation :**
```powershell
.\diagnostic.ps1
```

### 3️⃣ utilisateurs1.ps1
**Préparation et listing**
- Importe le module Active Directory
- Vérifie la connexion au domaine
- Liste tous les contrôleurs de domaine
- Affiche les utilisateurs actifs (hors comptes système)

**Utilisation :**
```powershell
.\utilisateurs1.ps1
```

### 4️⃣ utilisateurs2.ps1
**Création et modification**
- Crée un nouvel utilisateur (Alice Dupont)
- Vérifie si l'utilisateur existe déjà (pas de doublon)
- Modifie les attributs d'un utilisateur (email, prénom)
- Affiche les informations de l'utilisateur

**Utilisation :**
```powershell
.\utilisateurs2.ps1
```

**Utilisateur créé :**
- Nom : Alice Dupont
- Login : alice.dupont
- UPN : alice.dupont@DC300150284-00.local
- Mot de passe : MotDePasse123!

### 5️⃣ utilisateurs3.ps1
**Gestion du cycle de vie**
- Désactive un compte utilisateur
- Réactive un compte utilisateur
- Supprime un utilisateur (avec confirmation)

**Utilisation :**
```powershell
.\utilisateurs3.ps1
# Suivre les invites pour confirmer la suppression
```

### 6️⃣ utilisateurs4.ps1
**Recherche et organisation**
- Recherche des utilisateurs par filtre (ex: prénom commençant par 'A')
- Exporte tous les utilisateurs dans un fichier CSV
- Crée une OU (Organizational Unit) "Students"
- Déplace des utilisateurs vers l'OU

**Utilisation :**
```powershell
.\utilisateurs4.ps1
```

**Fichier généré :**
- `TP_AD_Users_300150284.csv` - Liste complète des utilisateurs

### 7️⃣ cleanup.ps1
**Nettoyage des utilisateurs de test**
- Vérifie l'existence des utilisateurs de test
- Demande confirmation avant suppression
- Nettoie l'environnement pour recommencer

**Utilisation :**
```powershell
.\cleanup.ps1
# Répondre O/N pour chaque utilisateur
```

---

## 🔍 Dépannage

### Problème : "Unable to contact the server"

**Cause :** Le service ADWS n'est pas démarré ou le domaine est inaccessible

**Solution :**
```powershell
# Vérifier et démarrer ADWS
Get-Service ADWS
Start-Service ADWS

# Exécuter le diagnostic
.\diagnostic.ps1
```

### Problème : "UPN value not unique forest-wide"

**Cause :** L'utilisateur existe déjà dans Active Directory

**Solution :**
```powershell
# Option 1 : Utiliser le script de nettoyage
.\cleanup.ps1

# Option 2 : Vérifier manuellement
Get-ADUser -Filter {SamAccountName -eq "alice.dupont"}

# Option 3 : Le script utilisateurs2.ps1 gère automatiquement ce cas
.\utilisateurs2.ps1
```

### Problème : Erreurs d'encodage dans les scripts

**Cause :** Mauvais encodage du fichier (émojis, caractères spéciaux)

**Solution :**
1. Ouvrir le fichier dans PowerShell ISE ou VS Code
2. Sauvegarder avec l'encodage UTF-8 with BOM
3. Ou recréer le fichier en copiant-collant le contenu

### Problème : "Access Denied" ou erreurs de permissions

**Cause :** Credentials insuffisants

**Solution :**
```powershell
# Vérifier les credentials
$cred = Get-Credential
# Entrer : Administrator@DC300150284-00.local
# Mot de passe : Infra@2024
```

### Problème : Le domaine n'est pas trouvé

**Cause :** Nom de domaine incorrect dans bootstrap.ps1

**Solution :**
```powershell
# Vérifier le domaine réel
(Get-WmiObject Win32_ComputerSystem).Domain

# Corriger bootstrap.ps1 si nécessaire
$domainName = "VotreNomDeDomaine.local"
```

---

## 📝 Notes importantes

### Sécurité
- **Ne jamais** stocker des mots de passe en clair dans des scripts en production
- Les credentials sont codés en dur uniquement pour ce TP
- En production, utiliser `Get-Credential` ou des solutions de gestion des secrets

### Bonnes pratiques
- Toujours tester les scripts dans un environnement de développement
- Vérifier les utilisateurs existants avant création
- Faire des sauvegardes avant des suppressions massives
- Utiliser `-WhatIf` pour tester les commandes destructives

### Structure AD
- Les nouveaux utilisateurs sont créés dans `CN=Users` par défaut
- L'OU "Students" est créée à la racine du domaine
- Utilisez `Move-ADObject` pour déplacer des utilisateurs entre OUs

### Commandes utiles

**Lister tous les utilisateurs :**
```powershell
Get-ADUser -Filter * | Select-Object Name, SamAccountName, Enabled
```

**Rechercher un utilisateur spécifique :**
```powershell
Get-ADUser -Identity "alice.dupont" -Properties *
```

**Réinitialiser un mot de passe :**
```powershell
Set-ADAccountPassword -Identity "alice.dupont" -Reset -NewPassword (ConvertTo-SecureString "NouveauMotDePasse123!" -AsPlainText -Force)
```

**Voir les OUs :**
```powershell
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
```

**Exporter tous les utilisateurs :**
```powershell
Get-ADUser -Filter * -Properties * | Export-Csv "tous_les_utilisateurs.csv" -NoTypeInformation
```

---

## 📚 Références

- [Documentation Microsoft Active Directory](https://docs.microsoft.com/en-us/powershell/module/activedirectory/)
- [Cmdlets Active Directory PowerShell](https://docs.microsoft.com/en-us/powershell/module/activedirectory/)
- [Bonnes pratiques Active Directory](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory)

---

## 👤 Auteur

**Étudiant:** 300150284  
**Cours:** INF1084 - Infrastructure TI  
**Session:** 202-25A-04  
**Instance:** 00

---

## 📄 Licence

Ce projet est destiné à des fins éducatives dans le cadre du cours INF1084.

capture d`ecran :
![wait](https://github.com/user-attachments/assets/011e0e5c-0800-4b98-9b08-bc0744bdfe5b)
![wait](https://github.com/user-attachments/assets/30e002aa-6d6a-4081-8a1e-acd6541ddd99)
![wait](github.com/user-attachments/assets/a6112627-0821-47f6-945c-d849b0d4c911)
![wait](github.com/user-attachments/assets/d3615219-6b41-46ca-aa92-9497095f4298)
![wait](github.com/user-attachments/assets/8d7e87e5-f3c0-46d5-b26f-2ee3328e003c)







