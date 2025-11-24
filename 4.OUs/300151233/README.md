# 300151233

**Répertoire personnel pour le cours INF1084**  
**Étudiant :** Syphax  
**Collège :** Collège Boréal

## 📋 TP : Gestion des utilisateurs Active Directory avec PowerShell

### 🎯 Objectifs

Ce TP permet de :
- Lister tous les utilisateurs d'un domaine
- Créer, modifier, activer/désactiver et supprimer des utilisateurs
- Appliquer des filtres et exporter les données
- Déplacer des utilisateurs depuis CN=Users vers une OU spécifique

### 🔧 Configuration

**Domaine :** DC300151233-0.local  
**NetBIOS :** DC300151233-0  
**Mot de passe :** Infra@2024

### 📁 Scripts disponibles

1. `01-PrepareEnvironment.ps1` - Préparer l'environnement et vérifier le domaine
2. `02-ListUsers.ps1` - Lister les utilisateurs actifs
3. `03-CreateUser.ps1` - Créer un nouvel utilisateur (Alice Dupont)
4. `04-ModifyUser.ps1` - Modifier les propriétés d'un utilisateur
5. `05-DisableEnableUser.ps1` - Désactiver et réactiver un compte
6. `06-SearchUsers.ps1` - Rechercher des utilisateurs avec filtre
7. `07-ExportUsers.ps1` - Exporter les utilisateurs en CSV
8. `08-CreateOUAndMoveUser.ps1` - Créer l'OU Students et déplacer un utilisateur

### 🚀 Exécution

Pour exécuter les scripts :
```powershell
.\01-PrepareEnvironment.ps1
.\02-ListUsers.ps1
# etc...
```

### 📸 Captures d'écran

Les captures d'écran des résultats sont disponibles dans le dossier `images/`.
