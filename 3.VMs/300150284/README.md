# 🖥️ Installation et Configuration d'un Contrôleur de Domaine Active Directory

> Guide complet pour déployer un contrôleur de domaine Active Directory sur Windows Server 2022 avec PowerShell

## 📋 Table des matières

- [Prérequis](#prérequis)
- [Installation](#installation)
  - [Étape 1 : Renommer le serveur](#étape-1--renommer-le-serveur)
  - [Étape 2 : Installer le rôle AD DS](#étape-2--installer-le-rôle-ad-ds)
  - [Étape 3 : Créer une nouvelle forêt](#étape-3--créer-une-nouvelle-forêt)
  - [Étape 4 : Vérification](#étape-4--vérification)
- [Configuration réseau recommandée](#configuration-réseau-recommandée)
- [Dépannage](#dépannage)
- [Références](#références)

---

## 🎯 Prérequis

- Windows Server 2022 (Standard ou Datacenter)
- Droits administrateur local
- Adresse IP statique configurée
- Connexion réseau stable
- Au moins 2 Go de RAM disponible
- PowerShell 5.1 ou supérieur

---

## 🚀 Installation

### Étape 1 : Renommer le serveur

Ouvrez PowerShell en tant qu'**Administrateur** et exécutez :

```powershell
Rename-Computer -NewName "300150284" -Restart
```

> ⚠️ **Note** : Le serveur redémarrera automatiquement après cette commande.

**Paramètres :**
- `-NewName` : Nom du nouveau contrôleur de domaine (max 15 caractères)
- `-Restart` : Redémarre automatiquement le serveur

---

### Étape 2 : Installer le rôle AD DS

Après le redémarrage, reconnectez-vous et installez le rôle Active Directory Domain Services :

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

**Ce que fait cette commande :**
- ✅ Installe le rôle AD DS
- ✅ Installe les outils de gestion (RSAT-ADDS)
- ✅ Prépare le serveur pour la promotion

**Résultat attendu :**
```
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, ...}
```

---

### Étape 3 : Créer une nouvelle forêt

Promotion du serveur en contrôleur de domaine avec création d'une nouvelle forêt :

```powershell
Install-ADDSForest `
    -DomainName "300150284-00.local" `
    -DomainNetbiosName "300150284-00" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
    -Force
```

#### 📝 Explication des paramètres

| Paramètre | Description | Exemple |
|-----------|-------------|---------|
| `-DomainName` | Nom DNS complet du domaine (FQDN) | `300150284-00.local` |
| `-DomainNetbiosName` | Nom NetBIOS (max 15 caractères) | `300150284-00` |
| `-InstallDns` | Installe et configure le serveur DNS | `$true` |
| `-SafeModeAdministratorPassword` | Mot de passe DSRM (mode restauration) | Mot de passe sécurisé |
| `-Force` | Évite les invites de confirmation | - |

> ⚠️ **Important** : Le mot de passe DSRM doit être complexe et bien conservé. Il sera nécessaire en cas de restauration du domaine.

> 🔄 **Le serveur redémarrera automatiquement** après cette opération (3-5 minutes).

---

### Étape 4 : Vérification

Après le redémarrage, connectez-vous avec le compte du domaine :

**Nom d'utilisateur :** 300150284-00\Administrator`  
**Mot de passe :** Votre mot de passe administrateur

#### Vérifier le domaine

```powershell
Get-ADDomain
```

**Résultat attendu :**
```
ComputersContainer        : CN=Computers,DC=300150284-00,DC=local
DomainMode               : Windows2016Domain
Forest                   : 300150284-00.local
Name                     : 300150284-00
NetBIOSName              : 300150284-00
...
```

#### Vérifier la forêt

```powershell
Get-ADForest
```

**Résultat attendu :**
```
ApplicationPartitions : {DC=DomainDnsZones,DC=300150284-00,DC=local, ...}
DomainNamingMaster   : 300150284.300150284-00.local
ForestMode           : Windows2016Forest
Name                 : 300150284-00.local
...
```

#### Vérifier le service DNS

```powershell
Get-DnsServerZone
```

---

## 🌐 Configuration réseau recommandée

### Configuration IP statique

Avant l'installation, configurez une adresse IP statique :

```powershell
# Exemple de configuration IP
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.1.10 -PrefixLength 24 -DefaultGateway 192.168.1.1

# Configurer le DNS (pointant vers lui-même après installation)
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 127.0.0.1
```

### Pare-feu

Les ports suivants doivent être ouverts :

| Service | Ports | Protocole |
|---------|-------|-----------|
| DNS | 53 | TCP/UDP |
| Kerberos | 88 | TCP/UDP |
| LDAP | 389 | TCP/UDP |
| LDAPS | 636 | TCP |
| LDAP GC | 3268 | TCP |
| SMB | 445 | TCP |
| RPC | 135, 49152-65535 | TCP |

---

## 🔧 Dépannage

### Problème : "Le nom de domaine spécifié existe déjà"

**Solution :** Vérifiez qu'aucun domaine avec ce nom n'existe déjà sur le réseau.

### Problème : Échec de l'installation DNS

**Solution :** 
```powershell
# Vérifier le service DNS
Get-Service DNS

# Démarrer le service si nécessaire
Start-Service DNS
```

### Problème : Impossible de se connecter après redémarrage

**Solution :** Utilisez le compte local si nécessaire :
- Nom d'utilisateur : `.\Administrator`
- Ou redémarrez en mode sans échec

### Vérifier les journaux d'événements

```powershell
Get-EventLog -LogName "Directory Service" -Newest 20
Get-EventLog -LogName "DNS Server" -Newest 20
```

---

## 📚 Références

- [Documentation Microsoft - Active Directory Domain Services](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/active-directory-domain-services)
- [PowerShell ADDSDeployment Module](https://docs.microsoft.com/en-us/powershell/module/addsdeployment/)
- [Best Practices for AD DS Deployment](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory)

---

## 📄 Licence

Ce document est fourni à des fins éducatives et de laboratoire.

## 👥 Contribution

N'hésitez pas à proposer des améliorations via des pull requests ou à signaler des problèmes dans les issues.

---

**Dernière mise à jour :** Novembre 2025  
**Version Windows Server :** 2022  
**PowerShell :** 5.1+
