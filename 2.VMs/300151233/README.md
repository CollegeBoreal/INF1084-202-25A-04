# Installation Active Directory - DC300151233

## Informations du serveur
- **Nom du serveur** : DC300151233
- **ID Boréal** : 300151233
- **Domaine** : DC300151233-00.local
- **NetBIOS** : DC300151233-00
- **Adresse IP** : 10.7.236.239
- **Système** : Windows Server 2022 Datacenter
- **Date** : 14 octobre 2025

## Configuration réalisée

### 1. Vérification du nom du serveur
```powershell
hostname
# Résultat : DC300151233 ✅
```

### 2. Installation AD Domain Services
```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```
✅ Rôle AD DS installé avec succès

### 3. Création du domaine Active Directory
```powershell
Install-ADDSForest `
    -DomainName "DC300151233-00.local" `
    -DomainNetbiosName "DC300151233-00" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
    -Force
```
✅ Domaine créé avec DNS intégré

### 4. Installation des outils de gestion
```powershell
Install-WindowsFeature RSAT-AD-PowerShell, RSAT-AD-Tools -IncludeAllSubFeature
```
✅ Outils RSAT installés

### 5. Vérifications effectuées

#### Domaine
```powershell
Get-ADDomain
```
- **Name** : DC300151233-00
- **DNSRoot** : DC300151233-00.local
- **NetBIOSName** : DC300151233-00
- **DomainMode** : Windows2016Domain

#### Forêt
```powershell
Get-ADForest
```
- **Name** : DC300151233-00.local
- **ForestMode** : Windows2016Forest
- **RootDomain** : DC300151233-00.local

#### Contrôleur de domaine
```powershell
Get-ADDomainController
```
- **Name** : DC300151233
- **Domain** : DC300151233-00.local
- **IPv4Address** : 10.7.236.239
- **OperatingSystem** : Windows Server 2022 Datacenter

#### Zones DNS
```powershell
Get-DnsServerZone
```
- ✅ _msdcs.DC300151233-00.local (Primary, Secure)
- ✅ DC300151233-00.local (Primary, Secure)

## Résultats

- ✅ Contrôleur de domaine Active Directory opérationnel
- ✅ Serveur DNS intégré fonctionnel
- ✅ Domaine DC300151233-00.local actif
- ✅ Forêt Active Directory configurée (mode Windows 2016)
- ✅ Outils de gestion PowerShell disponibles
- ✅ Zones DNS sécurisées créées automatiquement

## Connexion

Le serveur est accessible via :
- **Compte local** : `.\Administrator`
- **Compte domaine** : `DC300151233\Administrator`
- **IP** : 10.7.236.239 (via RDP)

## Mot de passe DSRM

Mot de passe du mode restauration : `MotDePasseDSRM123!`
⚠️ À conserver précieusement pour la restauration d'urgence.

## Captures d'écran

Voir le dossier `images/` pour les captures d'écran des vérifications.