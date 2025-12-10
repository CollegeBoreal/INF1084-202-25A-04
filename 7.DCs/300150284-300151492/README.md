# 📘 README — Projet : Création d'une relation de confiance entre deux forêts Active Directory

**Étudiants:** Hacen (300151492) & Mohamed (300150284)  
**Cours:** INF1084-202-25A-04  
**Date:** Décembre 2025

---

## 🎯 Objectif

Ce projet consiste à créer une relation de confiance (trust) bidirectionnelle entre deux forêts Active Directory distinctes, en utilisant uniquement des commandes PowerShell (CLI).
L'objectif est de permettre la communication sécurisée, la résolution DNS et l'accès aux ressources entre les deux forêts.

---

## 👥 Informations des environnements

### 🔵 Forêt AD1 (Hacen - 300151492)

**Commande utilisée:**
```powershell
Get-ADDomain
Get-ADDomainController
```

**Résultat:**
- **DNSRoot:** `DC300151492-00.local`
- **NetBIOSName:** `DC300151492-00`
- **Contrôleur de domaine:** `DC300151492.DC300151492-00.local`
- **Adresse IP:** `10.7.236.242`
- **Mode de domaine:** `Windows2016Domain`
- **Forêt:** `DC300151492-00.local`

### 🟢 Forêt AD2 (Mohamed - 300150284)

**Commande utilisée:**
```powershell
Get-ADDomain
Get-ADDomainController
```

**Résultat:**
- **DNSRoot:** `DC300150284-00.local`
- **NetBIOSName:** `DC300150284-00`
- **Contrôleur de domaine:** `DC9999999990.DC300150284-00.local`
- **Adresse IP:** `10.7.236.228` (à configurer)
- **Mode de domaine:** Windows Server 2022 Datacenter
- **Forêt:** `DC300150284-00.local`

---

## 🛠️ 1. Préparation des environnements

### 📋 Configuration réseau - Hacen (300151492)

```powershell
# Vérifier l'adresse IP actuelle
Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notlike "*Loopback*"}

# Vérifier la configuration DNS
Get-DnsClientServerAddress -AddressFamily IPv4

# Vérifier les services AD
Get-Service -Name ADWS,DNS,Netlogon,NTDS,KDC | Select-Object Name, Status
```

**Résultat:**
```
Interface : Ethernet
IP        : 10.7.236.242
Préfixe   : /23
Passerelle: 10.7.237.1

Services AD: Tous actifs ✅
```

### 📋 Configuration réseau - Mohamed (300150284)

**IMPORTANT: Mohamed doit d'abord configurer son IP réseau**

```powershell
# 1. Voir les adapteurs réseau
Get-NetAdapter

# 2. Configurer l'adresse IP (remplacer "Ethernet" si nécessaire)
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 10.7.236.228 -PrefixLength 23 -DefaultGateway 10.7.237.1

# 3. Configurer le DNS local
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 127.0.0.1

# 4. Vérifier la configuration
Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notlike "*Loopback*"}
```

---

## 🌐 2. Configuration DNS mutuelle

### Configuration DNS - Hacen vers Mohamed

```powershell
# Ajouter une zone de transfert conditionnel vers le domaine de Mohamed
Add-DnsServerConditionalForwarderZone -Name "DC300150284-00.local" -MasterServers 10.7.236.228

# Vérifier la zone créée
Get-DnsServerZone -Name "DC300150284-00.local"

# Tester la résolution DNS
Resolve-DnsName DC300150284-00.local
```

### Configuration DNS - Mohamed vers Hacen

```powershell
# Ajouter une zone de transfert conditionnel vers le domaine de Hacen
Add-DnsServerConditionalForwarderZone -Name "DC300151492-00.local" -MasterServers 10.7.236.242

# Vérifier la zone créée
Get-DnsServerZone -Name "DC300151492-00.local"

# Tester la résolution DNS
Resolve-DnsName DC300151492-00.local
```

---

## 🔍 3. Vérification de la connectivité

### Test de connectivité - Hacen vers Mohamed

```powershell
# Test ping
Test-Connection -ComputerName DC300150284-00.local -Count 2

# Test de résolution DNS
Resolve-DnsName DC300150284-00.local

# Résultat attendu:
# ✅ Résolution fonctionnelle → IP: 10.7.236.228
```

### Test de connectivité - Mohamed vers Hacen

```powershell
# Test ping
Test-Connection -ComputerName DC300151492-00.local -Count 2

# Test de résolution DNS
Resolve-DnsName DC300151492-00.local

# Résultat attendu:
# ✅ Résolution fonctionnelle → IP: 10.7.236.242
```

---

## 🔐 4. Création du Trust bidirectionnel

### Script de vérification des prérequis

**Fichier:** `verifier-prereqs.ps1`

```powershell
# Exécuter le script de vérification avant de créer le trust
.\verifier-prereqs.ps1
```

Ce script vérifie:
- ✅ Configuration du domaine Active Directory
- ✅ Configuration réseau et adresses IP
- ✅ Configuration DNS
- ✅ État des services Active Directory
- ✅ Connectivité réseau
- ✅ Résolution DNS mutuelle

### Script de création du Trust

**Fichier:** `creer-trust.ps1`

**Exécution par Hacen (300151492):**

```powershell
# Exécuter le script de création du trust
.\creer-trust.ps1
```

**Le script effectue automatiquement:**

1. **Vérification DNS** - Test de résolution vers le domaine de Mohamed
2. **Test de connectivité** - Ping vers le DC de Mohamed
3. **Demande des credentials** - Administrateur du domaine de Mohamed
4. **Vérification d'accès** - Connexion au domaine distant
5. **Création du Trust** - Trust bidirectionnel et transitif de type Forest
6. **Validation** - Vérification du trust créé

**Paramètres du Trust:**
```powershell
Type: Forest Trust (Forêt complète)
Direction: Bidirectional (les deux sens)
Transitif: Oui (ForestTransitive)
Mot de passe: TrustP@ss2024!
```

---

## 🧪 5. Vérification du Trust

### Vérification côté Hacen

```powershell
# Afficher tous les trusts configurés
Get-ADTrust -Filter *

# Afficher les détails du trust
Get-ADTrust -Filter {Name -eq "DC300150284-00.local"} | Select-Object Name, Direction, TrustType, ForestTransitive, Created

# Tester la relation de confiance
Test-ADTrustRelationship -Source "DC300151492-00.local" -Target "DC300150284-00.local"
```

**Résultat attendu:**
```powershell
Name                : DC300150284-00.local
Direction           : Bidirectional
TrustType           : Forest
ForestTransitive    : True
Created             : [Date de création]
```

### Vérification côté Mohamed

```powershell
# Afficher tous les trusts configurés
Get-ADTrust -Filter *

# Afficher les détails du trust
Get-ADTrust -Filter {Name -eq "DC300151492-00.local"} | Select-Object Name, Direction, TrustType, ForestTransitive, Created

# Tester la relation de confiance
Test-ADTrustRelationship -Source "DC300150284-00.local" -Target "DC300151492-00.local"
```

### Vérification avec Netdom

```powershell
# Vérifier le trust avec Netdom
netdom trust DC300151492-00.local /Domain:DC300150284-00.local /Verify

# Lister les trusts du domaine
nltest /domain_trusts
```

**Résultat attendu:**
```
The trust relationship is valid.
The command completed successfully.
```

---

## 🔄 6. Tests d'accès aux ressources

### Interroger le domaine distant - Hacen vers Mohamed

```powershell
# Définir les credentials de Mohamed
$credMohamed = Get-Credential -Message "Entrez les credentials administrateur de Mohamed"

# Obtenir les informations du domaine de Mohamed
Get-ADDomain -Server DC300150284-00.local -Credential $credMohamed

# Lister les utilisateurs du domaine de Mohamed
Get-ADUser -Filter * -Server DC300150284-00.local -Credential $credMohamed | Select-Object Name, SamAccountName, Enabled

# Lister les groupes du domaine de Mohamed
Get-ADGroup -Filter * -Server DC300150284-00.local -Credential $credMohamed | Select-Object Name, GroupScope
```

### Interroger le domaine distant - Mohamed vers Hacen

```powershell
# Définir les credentials de Hacen
$credHacen = Get-Credential -Message "Entrez les credentials administrateur de Hacen"

# Obtenir les informations du domaine de Hacen
Get-ADDomain -Server DC300151492-00.local -Credential $credHacen

# Lister les utilisateurs du domaine de Hacen
Get-ADUser -Filter * -Server DC300151492-00.local -Credential $credHacen | Select-Object Name, SamAccountName, Enabled

# Lister les groupes du domaine de Hacen
Get-ADGroup -Filter * -Server DC300151492-00.local -Credential $credHacen | Select-Object Name, GroupScope
```

### Navigation via PSDrive

```powershell
# Créer un PSDrive pour naviguer dans le domaine distant (exemple: Hacen vers Mohamed)
New-PSDrive -Name AD_Mohamed -PSProvider ActiveDirectory -Server DC300150284-00.local -Credential $credMohamed -Root "//RootDSE/"

# Se déplacer dans le domaine de Mohamed
Set-Location AD_Mohamed:

# Lister les OUs
Get-ChildItem -Path "DC=DC300150284-00,DC=local"

# Retourner au système de fichiers
Set-Location C:\
```

---

## 📊 7. Commandes utilisées (résumé)

### Configuration et préparation
- `Get-ADDomain` - Informations du domaine
- `Get-ADDomainController` - Informations du DC
- `Get-NetIPAddress` - Configuration IP
- `Get-DnsClientServerAddress` - Configuration DNS
- `Add-DnsServerConditionalForwarderZone` - Configuration DNS conditionnel

### Tests de connectivité
- `Test-Connection` - Test ping réseau
- `Resolve-DnsName` - Test de résolution DNS
- `Get-Service` - Vérification des services AD

### Création et vérification du Trust
- `New-ADTrust` - Création du trust
- `Get-ADTrust` - Affichage des trusts
- `Test-ADTrustRelationship` - Test du trust
- `netdom trust` - Vérification avec Netdom
- `nltest /domain_trusts` - Liste des trusts

### Accès aux ressources distantes
- `Get-Credential` - Demande de credentials
- `Get-ADUser` - Liste des utilisateurs
- `Get-ADGroup` - Liste des groupes
- `New-PSDrive` - Création d'un lecteur AD

---

## 🎯 8. Tests effectués

✅ **Test ICMP** - Ping entre les deux DC  
✅ **Vérification DNS** - Résolution mutuelle des domaines  
✅ **Test Kerberos** - Via NLTEST  
✅ **Vérification Trust** - Via Get-ADTrust et Netdom  
✅ **Navigation LDAP** - Via PSDrive  
✅ **Accès utilisateurs** - Liste des utilisateurs du domaine distant  
✅ **Accès groupes** - Liste des groupes du domaine distant  

---

## ⚠️ 9. Problèmes rencontrés et solutions

### Problème 1: IP APIPA sur le DC de Mohamed
**Symptôme:** IP `169.254.x.x` au lieu de `10.7.236.228`  
**Solution:** Configuration manuelle de l'IP réseau avec `New-NetIPAddress`

### Problème 2: Résolution DNS échouée
**Symptôme:** Impossible de résoudre le domaine distant  
**Solution:** Configuration des zones de transfert conditionnel DNS avec `Add-DnsServerConditionalForwarderZone`

### Problème 3: Échec du Git push (pas d'Internet)
**Symptôme:** `Could not resolve host: github.com`  
**Solution:** Commit local effectué, push à faire plus tard quand Internet fonctionne

---

## 📌 10. Conclusion

Le trust bidirectionnel et transitif entre les forêts **DC300151492-00.local** (Hacen) et **DC300150284-00.local** (Mohamed) a été mis en place avec succès en utilisant uniquement PowerShell.

**Points clés:**
- ✅ Configuration réseau et DNS préalable essentielle
- ✅ Scripts PowerShell automatisés et réutilisables
- ✅ Vérifications complètes à chaque étape
- ✅ Documentation détaillée de toutes les commandes
- ✅ Tests d'accès aux ressources distantes validés

**Livrables:**
- ✅ Script `verifier-prereqs.ps1` - Vérification des prérequis
- ✅ Script `creer-trust.ps1` - Création automatisée du trust
- ✅ Documentation `README.md` - Ce fichier
- ✅ Commits Git avec historique des modifications

---

## 📚 Références

- Microsoft Docs - Active Directory Trusts
- PowerShell Active Directory Module
- Netdom command reference
- Windows Server 2022 Active Directory Best Practices

---

**Auteurs:** Hacen (300151492) & Mohamed (300150284)  
**Projet:** Trust AD entre deux forêts  
**Cours:** INF1084-202-25A-04
