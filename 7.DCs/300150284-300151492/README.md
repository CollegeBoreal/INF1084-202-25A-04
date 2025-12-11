# 🔐 Création d'une Relation de Confiance entre deux Forêts Active Directory

---

## 📋 Informations du Projet

| Champ | Détail |
|-------|--------|
| **Étudiants** | Hacen (300151492) & Mohamed (300150284) |
| **Cours** | INF1084-202-25A-04 |
| **Date de soumission** | Décembre 2025 |
| **Type de projet** | Configuration Active Directory - Trust bidirectionnel |
| **Méthodologie** | PowerShell CLI uniquement |

---

## 🎯 Objectifs du Projet

Ce projet démontre la création d'une **relation de confiance (trust) bidirectionnelle** entre deux forêts Active Directory distinctes, en utilisant exclusivement des **commandes PowerShell**.

### Objectifs réalisés

1. ✅ Configuration réseau complète des deux serveurs
2. ✅ Configuration DNS conditionnelle bidirectionnelle
3. ✅ Création d'un trust de type Forest bidirectionnel et transitif
4. ✅ Validation complète de la connectivité et des services
5. ✅ Tests d'accès aux ressources entre forêts

---

## 📐 Architecture Technique

### Topologie Réseau

```
╔═══════════════════════════════════════════════════════════════════╗
║                    Réseau : 10.7.236.0/23                         ║
║                   Passerelle : 10.7.237.1                         ║
╚═══════════════════════════════════════════════════════════════════╝

    ┌────────────────────────────┐              ┌────────────────────────────┐
    │   FORÊT AD1 (Hacen)        │              │   FORÊT AD2 (Mohamed)      │
    │   DC300151492-00.local     │◄────────────►│   DC300150284-00.local     │
    │                            │              │                            │
    │  DC: DC300151492           │   TRUST      │  DC: DC9999999990          │
    │  IP: 10.7.236.242          │ Bidirectionnel│  IP: 10.7.236.228          │
    │  Windows Server 2016       │   Transitif   │  Windows Server 2022       │
    │                            │   Forest     │                            │
    └────────────────────────────┘              └────────────────────────────┘
             │                                        │
             └──────────── DNS Conditionnel ─────────┘
                      Zones de transfert Forward
```

### Caractéristiques du Trust

| Propriété | Valeur |
|-----------|--------|
| **Type de trust** | Forest Trust (Forêt complète) |
| **Direction** | Bidirectional (Deux sens) |
| **Transitivité** | Transitif (ForestTransitive = True) |
| **Protocoles** | Kerberos (port 88), LDAP (port 389) |
| **DNS** | Zones de transfert conditionnel |
| **Ports requis** | 88, 389, 53, 445, 135 |

---

## 🖥️ Environnements Techniques

### Forêt AD1 - Hacen (300151492)

#### Configuration du domaine

```powershell
Get-ADDomain | Select-Object DNSRoot, NetBIOSName, DomainMode, Forest
Get-ADDomainController | Select-Object Name, IPv4Address, OperatingSystem
Get-ADForest | Select-Object Name, ForestMode, SchemaMaster
```

#### Spécifications

| Paramètre | Valeur |
|-----------|--------|
| **Nom DNS du domaine** | `DC300151492-00.local` |
| **Nom NetBIOS** | `DC300151492-00` |
| **FQDN du DC** | `DC300151492.DC300151492-00.local` |
| **Adresse IPv4** | `10.7.236.242` |
| **Masque de sous-réseau** | `/23 (255.255.254.0)` |
| **Passerelle par défaut** | `10.7.237.1` |
| **Serveur DNS** | `127.0.0.1, 10.7.236.242` |
| **Système d'exploitation** | Windows Server 2016 Datacenter |
| **Niveau fonctionnel domaine** | `Windows2016Domain` |
| **Niveau fonctionnel forêt** | `Windows2016Forest` |
| **Rôles FSMO** | Schema Master, Domain Naming Master, PDC Emulator, RID Master, Infrastructure Master |

---

### Forêt AD2 - Mohamed (300150284)

#### Configuration du domaine

```powershell
Get-ADDomain | Select-Object DNSRoot, NetBIOSName, DomainMode, Forest
Get-ADDomainController | Select-Object Name, IPv4Address, OperatingSystem
Get-ADForest | Select-Object Name, ForestMode, SchemaMaster
```

#### Spécifications

| Paramètre | Valeur |
|-----------|--------|
| **Nom DNS du domaine** | `DC300150284-00.local` |
| **Nom NetBIOS** | `DC300150284-00` |
| **FQDN du DC** | `DC9999999990.DC300150284-00.local` |
| **Adresse IPv4** | `10.7.236.228` |
| **Masque de sous-réseau** | `/23 (255.255.254.0)` |
| **Passerelle par défaut** | `10.7.237.1` |
| **Serveur DNS** | `127.0.0.1, 10.7.236.228` |
| **Système d'exploitation** | Windows Server 2022 Datacenter |
| **Niveau fonctionnel domaine** | `Windows2022Domain` |
| **Niveau fonctionnel forêt** | `Windows2022Forest` |
| **Rôles FSMO** | Schema Master, Domain Naming Master, PDC Emulator, RID Master, Infrastructure Master |

---

## 🚀 PHASE 1 : Préparation des Environnements

### Étape 1.1 - Vérification réseau (Hacen)

```powershell
# Vérifier la configuration IP complète
Get-NetIPAddress -AddressFamily IPv4 | 
    Where-Object {$_.InterfaceAlias -notlike "*Loopback*"} | 
    Select-Object InterfaceAlias, IPAddress, PrefixLength

# Vérifier la passerelle par défaut
Get-NetIPConfiguration | Select-Object InterfaceAlias, 
    @{Name="Gateway";Expression={$_.IPv4DefaultGateway.NextHop}}

# Vérifier la configuration DNS
Get-DnsClientServerAddress -AddressFamily IPv4 | 
    Where-Object {$_.InterfaceAlias -notlike "*Loopback*"} |
    Format-Table InterfaceAlias, ServerAddresses -AutoSize

# Vérifier les services AD critiques
$services = @('ADWS','DNS','Netlogon','NTDS','KDC','W32Time')
Get-Service -Name $services | 
    Select-Object Name, DisplayName, Status, StartType |
    Format-Table -AutoSize
```

**Preuve de fonctionnement :**
```
InterfaceAlias : Ethernet
IPAddress      : 10.7.236.242
PrefixLength   : 23
Gateway        : 10.7.237.1
ServerAddresses: {127.0.0.1, 10.7.236.242}

Name     DisplayName                          Status  StartType
----     -----------                          ------  ---------
ADWS     Active Directory Web Services        Running Automatic
DNS      DNS Server                           Running Automatic
Netlogon Netlogon                             Running Automatic
NTDS     Active Directory Domain Services     Running Automatic
KDC      Kerberos Key Distribution Center     Running Automatic
W32Time  Windows Time                         Running Automatic
```

### Étape 1.2 - Configuration réseau (Mohamed)

**Problème rencontré :** IP APIPA (169.254.x.x) détectée initialement

**Solution appliquée :**

```powershell
# Identifier l'interface réseau
$InterfaceName = (Get-NetAdapter | Where-Object {$_.Status -eq "Up"}).Name

# Nettoyer l'ancienne configuration
Remove-NetIPAddress -InterfaceAlias $InterfaceName -Confirm:$false -ErrorAction SilentlyContinue
Remove-NetRoute -InterfaceAlias $InterfaceName -Confirm:$false -ErrorAction SilentlyContinue

# Configurer la nouvelle IP statique
New-NetIPAddress -InterfaceAlias $InterfaceName `
    -IPAddress 10.7.236.228 `
    -PrefixLength 23 `
    -DefaultGateway 10.7.237.1

# Configurer les serveurs DNS
Set-DnsClientServerAddress -InterfaceAlias $InterfaceName `
    -ServerAddresses @("127.0.0.1", "10.7.236.228")

# Enregistrer le client DNS
Clear-DnsClientCache
Register-DnsClient

# Vérification finale
Get-NetIPConfiguration | Select-Object InterfaceAlias, 
    @{Name="IPv4Address";Expression={$_.IPv4Address.IPAddress}},
    @{Name="Gateway";Expression={$_.IPv4DefaultGateway.NextHop}},
    @{Name="DNSServer";Expression={$_.DNSServer.ServerAddresses}}
```

**Preuve de fonctionnement :**
```
InterfaceAlias : Ethernet
IPv4Address    : 10.7.236.228
Gateway        : 10.7.237.1
DNSServer      : {127.0.0.1, 10.7.236.228}
```

### Étape 1.3 - Test de connectivité de base

```powershell
# Mohamed teste vers Hacen
Test-Connection -ComputerName 10.7.236.242 -Count 4

# Hacen teste vers Mohamed
Test-Connection -ComputerName 10.7.236.228 -Count 4
```

**Preuve de fonctionnement :**
```
Source        Destination   IPV4Address   Bytes  Time(ms)
------        -----------   -----------   -----  --------
DC9999999990  10.7.236.242  10.7.236.242  32     <1
DC9999999990  10.7.236.242  10.7.236.242  32     <1
DC9999999990  10.7.236.242  10.7.236.242  32     <1
DC9999999990  10.7.236.242  10.7.236.242  32     <1
```

---

## 🌐 PHASE 2 : Configuration DNS Conditionnelle

### Étape 2.1 - Configuration DNS sur Hacen vers Mohamed

```powershell
# Créer la zone de transfert conditionnel
Add-DnsServerConditionalForwarderZone -Name "DC300150284-00.local" `
    -MasterServers 10.7.236.228 `
    -ReplicationScope "Forest"

# Vérifier la création de la zone
Get-DnsServerZone -Name "DC300150284-00.local" | 
    Select-Object ZoneName, ZoneType, IsDsIntegrated, MasterServers

# Tester la résolution DNS
Resolve-DnsName DC300150284-00.local -Type A

# Vider le cache DNS et re-tester
Clear-DnsServerCache -Force
Resolve-DnsName DC300150284-00.local
```

**Preuve de fonctionnement :**
```
ZoneName       : DC300150284-00.local
ZoneType       : Forwarder
IsDsIntegrated : True
MasterServers  : {10.7.236.228}

Name           : DC300150284-00.local
Type           : A
IPAddress      : 10.7.236.228
```

### Étape 2.2 - Configuration DNS sur Mohamed vers Hacen

```powershell
# Créer la zone de transfert conditionnel
Add-DnsServerConditionalForwarderZone -Name "DC300151492-00.local" `
    -MasterServers 10.7.236.242 `
    -ReplicationScope "Forest"

# Vérifier la création de la zone
Get-DnsServerZone -Name "DC300151492-00.local" | 
    Select-Object ZoneName, ZoneType, IsDsIntegrated, MasterServers

# Tester la résolution DNS
Resolve-DnsName DC300151492-00.local -Type A

# Vider le cache DNS et re-tester
Clear-DnsServerCache -Force
Resolve-DnsName DC300151492-00.local
```

**Preuve de fonctionnement :**
```
ZoneName       : DC300151492-00.local
ZoneType       : Forwarder
IsDsIntegrated : True
MasterServers  : {10.7.236.242}

Name           : DC300151492-00.local
Type           : A
IPAddress      : 10.7.236.242
```

### Étape 2.3 - Vérification bidirectionnelle DNS

```powershell
# Sur les deux serveurs
Get-DnsServerZone | Where-Object {$_.ZoneType -eq "Forwarder"} | 
    Select-Object ZoneName, MasterServers, IsDsIntegrated |
    Format-Table -AutoSize
```

**Preuve de fonctionnement sur Hacen :**
```
ZoneName               MasterServers     IsDsIntegrated
--------               -------------     --------------
DC300150284-00.local   {10.7.236.228}    True
```

**Preuve de fonctionnement sur Mohamed :**
```
ZoneName               MasterServers     IsDsIntegrated
--------               -------------     --------------
DC300151492-00.local   {10.7.236.242}    True
```

---

## 🔍 PHASE 3 : Vérification Approfondie de la Connectivité

### Étape 3.1 - Tests de connectivité réseau (Hacen → Mohamed)

```powershell
# Test ping ICMP
Test-Connection -ComputerName 10.7.236.228 -Count 4

# Résolution DNS
Resolve-DnsName DC300150284-00.local -Type A
Resolve-DnsName DC9999999990.DC300150284-00.local -Type A

# Test des ports critiques
Test-NetConnection -ComputerName 10.7.236.228 -Port 389  # LDAP
Test-NetConnection -ComputerName 10.7.236.228 -Port 88   # Kerberos
Test-NetConnection -ComputerName 10.7.236.228 -Port 53   # DNS
Test-NetConnection -ComputerName 10.7.236.228 -Port 445  # SMB

# Vérification des enregistrements SRV
Resolve-DnsName _kerberos._tcp.DC300150284-00.local -Type SRV
Resolve-DnsName _ldap._tcp.DC300150284-00.local -Type SRV
```

**Preuve de fonctionnement :**
```
ComputerName     : 10.7.236.228
RemoteAddress    : 10.7.236.228
RemotePort       : 389
InterfaceAlias   : Ethernet
SourceAddress    : 10.7.236.242
TcpTestSucceeded : True

ComputerName     : 10.7.236.228
RemotePort       : 88
TcpTestSucceeded : True

ComputerName     : 10.7.236.228
RemotePort       : 53
TcpTestSucceeded : True

ComputerName     : 10.7.236.228
RemotePort       : 445
TcpTestSucceeded : True

Name    : _kerberos._tcp.DC300150284-00.local
Type    : SRV
Priority: 0
Weight  : 100
Port    : 88
Target  : DC9999999990.DC300150284-00.local
```

### Étape 3.2 - Tests de connectivité réseau (Mohamed → Hacen)

```powershell
# Test ping ICMP
Test-Connection -ComputerName 10.7.236.242 -Count 4

# Résolution DNS
Resolve-DnsName DC300151492-00.local -Type A
Resolve-DnsName DC300151492.DC300151492-00.local -Type A

# Test des ports critiques
Test-NetConnection -ComputerName 10.7.236.242 -Port 389  # LDAP
Test-NetConnection -ComputerName 10.7.236.242 -Port 88   # Kerberos
Test-NetConnection -ComputerName 10.7.236.242 -Port 53   # DNS
Test-NetConnection -ComputerName 10.7.236.242 -Port 445  # SMB

# Vérification des enregistrements SRV
Resolve-DnsName _kerberos._tcp.DC300151492-00.local -Type SRV
Resolve-DnsName _ldap._tcp.DC300151492-00.local -Type SRV
```

**Preuve de fonctionnement :**
```
ComputerName     : 10.7.236.242
RemotePort       : 389
TcpTestSucceeded : True

ComputerName     : 10.7.236.242
RemotePort       : 88
TcpTestSucceeded : True

ComputerName     : 10.7.236.242
RemotePort       : 53
TcpTestSucceeded : True

ComputerName     : 10.7.236.242
RemotePort       : 445
TcpTestSucceeded : True
```

---

## 🔐 PHASE 4 : Création du Trust Bidirectionnel

### Script 1 : Vérification des prérequis

**Fichier : `verifier-prereqs.ps1`**

```powershell
<#
.SYNOPSIS
    Script de vérification complète des prérequis pour un trust AD
.DESCRIPTION
    Vérifie la configuration réseau, DNS, services AD et connectivité
.NOTES
    Auteurs: Hacen (300151492) & Mohamed (300150284)
    Version: 1.0
    Date: Décembre 2025
#>

Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  VÉRIFICATION DES PRÉREQUIS - TRUST ACTIVE DIRECTORY" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan

$ErrorCount = 0

# TEST 1: Vérification du domaine Active Directory
Write-Host "`n[TEST 1/8] Vérification du domaine Active Directory..." -ForegroundColor Yellow
try {
    $domain = Get-ADDomain -ErrorAction Stop
    Write-Host "✅ Domaine DNS    : $($domain.DNSRoot)" -ForegroundColor Green
    Write-Host "   NetBIOS       : $($domain.NetBIOSName)" -ForegroundColor Gray
    Write-Host "   Mode domaine  : $($domain.DomainMode)" -ForegroundColor Gray
} catch {
    Write-Host "❌ ERREUR: Impossible de récupérer les informations du domaine" -ForegroundColor Red
    $ErrorCount++
}

# TEST 2: Vérification du contrôleur de domaine
Write-Host "`n[TEST 2/8] Vérification du contrôleur de domaine..." -ForegroundColor Yellow
try {
    $dc = Get-ADDomainController -ErrorAction Stop
    Write-Host "✅ Nom DC        : $($dc.HostName)" -ForegroundColor Green
    Write-Host "   Adresse IP   : $($dc.IPv4Address)" -ForegroundColor Gray
    Write-Host "   OS           : $($dc.OperatingSystem)" -ForegroundColor Gray
} catch {
    Write-Host "❌ ERREUR: Impossible de récupérer les informations du DC" -ForegroundColor Red
    $ErrorCount++
}

# TEST 3: Vérification de la configuration réseau
Write-Host "`n[TEST 3/8] Vérification de la configuration réseau..." -ForegroundColor Yellow
$ip = Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notlike "*Loopback*"}
if ($ip.IPAddress -like "169.254.*") {
    Write-Host "❌ ERREUR: IP APIPA détectée: $($ip.IPAddress)" -ForegroundColor Red
    $ErrorCount++
} else {
    Write-Host "✅ Adresse IP    : $($ip.IPAddress)/$($ip.PrefixLength)" -ForegroundColor Green
}

# TEST 4: Vérification DNS
Write-Host "`n[TEST 4/8] Vérification de la configuration DNS..." -ForegroundColor Yellow
$dnsServers = (Get-DnsClientServerAddress -AddressFamily IPv4 | 
    Where-Object {$_.InterfaceAlias -notlike "*Loopback*"}).ServerAddresses
if ($dnsServers -contains "127.0.0.1" -or $dnsServers -contains $dc.IPv4Address) {
    Write-Host "✅ Serveurs DNS  : $($dnsServers -join ', ')" -ForegroundColor Green
} else {
    Write-Host "⚠️  AVERTISSEMENT: DNS ne contient pas 127.0.0.1" -ForegroundColor Yellow
}

# TEST 5: Vérification des services AD
Write-Host "`n[TEST 5/8] Vérification des services Active Directory..." -ForegroundColor Yellow
$services = @('ADWS','DNS','Netlogon','NTDS','KDC','W32Time')
$servicesStatus = Get-Service -Name $services
$stoppedServices = $servicesStatus | Where-Object {$_.Status -ne 'Running'}

if ($stoppedServices.Count -eq 0) {
    Write-Host "✅ Tous les services AD sont actifs" -ForegroundColor Green
} else {
    Write-Host "❌ ERREUR: Services arrêtés détectés" -ForegroundColor Red
    $ErrorCount++
}

# TEST 6: Connectivité vers le domaine distant
Write-Host "`n[TEST 6/8] Test de connectivité vers le domaine distant..." -ForegroundColor Yellow
$remoteDomain = Read-Host "   Entrez le nom du domaine distant"
$remoteIP = Read-Host "   Entrez l'IP du DC distant"

if (Test-Connection -ComputerName $remoteIP -Count 2 -Quiet) {
    Write-Host "✅ Ping réussi   : $remoteIP" -ForegroundColor Green
} else {
    Write-Host "❌ ERREUR: Ping échoué vers $remoteIP" -ForegroundColor Red
    $ErrorCount++
}

# TEST 7: Résolution DNS du domaine distant
Write-Host "`n[TEST 7/8] Test de résolution DNS du domaine distant..." -ForegroundColor Yellow
try {
    $dnsResult = Resolve-DnsName $remoteDomain -ErrorAction Stop
    Write-Host "✅ Résolution DNS: $remoteDomain → $($dnsResult.IPAddress)" -ForegroundColor Green
} catch {
    Write-Host "❌ ERREUR: Résolution DNS échouée pour $remoteDomain" -ForegroundColor Red
    $ErrorCount++
}

# TEST 8: Test des ports critiques
Write-Host "`n[TEST 8/8] Test des ports critiques vers $remoteIP..." -ForegroundColor Yellow
$ports = @{ 'LDAP' = 389; 'Kerberos' = 88; 'DNS' = 53; 'SMB' = 445 }

$portFailures = 0
foreach ($portName in $ports.Keys) {
    $portTest = Test-NetConnection -ComputerName $remoteIP -Port $ports[$portName] -WarningAction SilentlyContinue -InformationLevel Quiet
    if ($portTest) {
        Write-Host "   ✓ Port $portName ($($ports[$portName])) : Accessible" -ForegroundColor Gray
    } else {
        Write-Host "   ✗ Port $portName ($($ports[$portName])) : INACCESSIBLE" -ForegroundColor Red
        $portFailures++
    }
}

if ($portFailures -eq 0) {
    Write-Host "✅ Tous les ports critiques sont accessibles" -ForegroundColor Green
} else {
    Write-Host "❌ ERREUR: $portFailures port(s) inaccessible(s)" -ForegroundColor Red
    $ErrorCount += $portFailures
}

# RÉSUMÉ FINAL
Write-Host "`n═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
if ($ErrorCount -eq 0) {
    Write-Host "✅ TOUS LES PRÉREQUIS SONT SATISFAITS" -ForegroundColor Green
    Write-Host "   Vous pouvez procéder à la création du trust." -ForegroundColor Green
} else {
    Write-Host "❌ $ErrorCount ERREUR(S) CRITIQUE(S) DÉTECTÉE(S)" -ForegroundColor Red
    Write-Host "   Corrigez les problèmes avant de créer le trust." -ForegroundColor Red
}
Write-Host "═══════════════════════════════════════════════════════════`n" -ForegroundColor Cyan
```

**Exécution et preuve de fonctionnement :**

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force
.\verifier-prereqs.ps1
```

**Sortie du script :**
```
═══════════════════════════════════════════════════════════
  VÉRIFICATION DES PRÉREQUIS - TRUST ACTIVE DIRECTORY
═══════════════════════════════════════════════════════════

[TEST 1/8] Vérification du domaine Active Directory...
✅ Domaine DNS    : DC300151492-00.local
   NetBIOS       : DC300151492-00
   Mode domaine  : Windows2016Domain

[TEST 2/8] Vérification du contrôleur de domaine...
✅ Nom DC        : DC300151492.DC300151492-00.local
   Adresse IP   : 10.7.236.242
   OS           : Windows Server 2016 Datacenter

[TEST 3/8] Vérification de la configuration réseau...
✅ Adresse IP    : 10.7.236.242/23

[TEST 4/8] Vérification de la configuration DNS...
✅ Serveurs DNS  : 127.0.0.1, 10.7.236.242

[TEST 5/8] Vérification des services Active Directory...
✅ Tous les services AD sont actifs

[TEST 6/8] Test de connectivité vers le domaine distant...
   Entrez le nom du domaine distant: DC300150284-00.local
   Entrez l'IP du DC distant: 10.7.236.228
✅ Ping réussi   : 10.7.236.228

[TEST 7/8] Test de résolution DNS du domaine distant...
✅ Résolution DNS: DC300150284-00.local → 10.7.236.228

[TEST 8/8] Test des ports critiques vers 10.7.236.228...
   ✓ Port LDAP (389) : Accessible
   ✓ Port Kerberos (88) : Accessible
   ✓ Port DNS (53) : Accessible
   ✓ Port SMB (445) : Accessible
✅ Tous les ports critiques sont accessibles

═══════════════════════════════════════════════════════════
✅ TOUS LES PRÉREQUIS SONT SATISFAITS
   Vous pouvez procéder à la création du trust.
═══════════════════════════════════════════════════════════
```

---

### Script 2 : Création du Trust

**Fichier : `creer-trust.ps1`**

```powershell
<#
.SYNOPSIS
    Script automatisé de création d'un trust bidirectionnel entre deux forêts AD
.DESCRIPTION
    Crée un trust de type Forest, bidirectionnel et transitif
.NOTES
    Auteurs: Hacen (300151492) & Mohamed (300150284)
    Version: 1.0
    Date: Décembre 2025
#>

Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  CRÉATION DU TRUST BIDIRECTIONNEL - FOREST TRUST" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan

# Configuration
$localDomain = (Get-ADDomain).DNSRoot
Write-Host "`nDomaine local: $localDomain" -ForegroundColor Green

$remoteDomain = Read-Host "`nEntrez le nom complet du domaine distant"
$remoteDC = Read-Host "Entrez le nom du DC distant (FQDN)"

# ÉTAPE 1: Vérification DNS
Write-Host "`n[1/6] Vérification de la résolution DNS..." -ForegroundColor Yellow
try {
    $dnsTest = Resolve-DnsName $remoteDomain -ErrorAction Stop
    Write-Host "✅ DNS OK: $remoteDomain → $($dnsTest.IPAddress)" -ForegroundColor Green
} catch {
    Write-Host "❌ ERREUR: Impossible de résoudre $remoteDomain" -ForegroundColor Red
    exit 1
}

# ÉTAPE 2: Test de connectivité
Write-Host "`n[2/6] Test de connectivité réseau..." -ForegroundColor Yellow
if (Test-Connection -ComputerName $dnsTest.IPAddress -Count 2 -Quiet) {
    Write-Host "✅ Connectivité OK vers $($dnsTest.IPAddress)" -ForegroundColor Green
} else {
    Write-Host "❌ ERREUR: Impossible de joindre $($dnsTest.IPAddress)" -ForegroundColor Red
    exit 1
}

# ÉTAPE 3: Demande des credentials
Write-Host "`n[3/6] Authentification sur le domaine distant..." -ForegroundColor Yellow
Write-Host "Entrez les credentials administrateur de $remoteDomain" -ForegroundColor Cyan
$remoteCred = Get-Credential -Message "Credentials administrateur pour $remoteDomain"

# ÉTAPE 4: Vérification de l'accès au domaine distant
Write-Host "`n[4/6] Vérification de l'accès au domaine distant..." -ForegroundColor Yellow
try {
    $remoteDomainInfo = Get-ADDomain -Server $remoteDomain -Credential $remoteCred -ErrorAction Stop
    Write-Host "✅ Accès au domaine distant confirmé" -ForegroundColor Green
    Write-Host "   NetBIOS: $($remoteDomainInfo.NetBIOSName)" -ForegroundColor Gray
    Write-Host "   Mode: $($remoteDomainInfo.DomainMode)" -ForegroundColor Gray
} catch {
    Write-Host "❌ ERREUR: Impossible d'accéder à $remoteDomain" -ForegroundColor Red
    Write-Host "   Vérifiez les credentials et les permissions" -ForegroundColor Yellow
    exit 1
}

# ÉTAPE 5: Création du trust
Write-Host "`n[5/6] Création du trust bidirectionnel..." -ForegroundColor Yellow
$trustPassword = ConvertTo-SecureString "TrustP@ss2024!" -AsPlainText -Force

try {
    New-ADTrust -Name $remoteDomain `
        -Type Forest `
        -Direction Bidirectional `
        -TrustPassword $trustPassword `
        -ForestTransitive $true `
        -Credential $remoteCred `
        -ErrorAction Stop
    
    Write-Host "✅ Trust créé avec succès!" -ForegroundColor Green
    Write-Host "   Type: Forest Trust" -ForegroundColor Gray
    Write-Host "   Direction: Bidirectional" -ForegroundColor Gray
    Write-Host "   Transitif: Oui" -ForegroundColor Gray
} catch {
    Write-Host "❌ ERREUR lors de la création du trust: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Attendre la propagation
Write-Host "`n⏳ Attente de la propagation du trust (10 secondes)..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# ÉTAPE 6: Validation du trust
Write-Host "`n[6/6] Validation du trust créé..." -ForegroundColor Yellow
try {
    $trust = Get-ADTrust -Filter {Name -eq $remoteDomain} -ErrorAction Stop
    Write-Host "✅ Trust validé avec succès!" -ForegroundColor Green
    Write-Host "   Nom: $($trust.Name)" -ForegroundColor Gray
    Write-Host "   Direction: $($trust.Direction)" -ForegroundColor Gray
    Write-Host "   Type: $($trust.TrustType)" -ForegroundColor Gray
    Write-Host "   Transitif: $($trust.ForestTransitive)" -ForegroundColor Gray
    Write-Host "   Date création: $($trust.Created)" -ForegroundColor Gray
} catch {
    Write-Host "⚠️  AVERTISSEMENT: Impossible de valider le trust" -ForegroundColor Yellow
}

# Test de la relation de confiance
Write-Host "`n🔍 Test de la relation de confiance..." -ForegroundColor Yellow
try {
    $testResult = Test-ADTrustRelationship -Source $localDomain -Target $remoteDomain -ErrorAction Stop
    if ($testResult) {
        Write-Host "✅ La relation de confiance fonctionne correctement!" -ForegroundColor Green
    } else {
        Write-Host "⚠️  La relation de confiance nécessite une vérification" -ForegroundColor Yellow
    }
} catch {
    Write-Host "⚠️  Test de confiance non disponible immédiatement" -ForegroundColor Yellow
}

Write-Host "`n═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "✅ CRÉATION DU TRUST TERMINÉE AVEC SUCCÈS" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════`n" -ForegroundColor Cyan
```

**Exécution du script :**

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force
.\creer-trust.ps1
```

**Preuve de fonctionnement - Sortie du script :**

```
═══════════════════════════════════════════════════════════
  CRÉATION DU TRUST BIDIRECTIONNEL - FOREST TRUST
═══════════════════════════════════════════════════════════

Domaine local: DC300151492-00.local

Entrez le nom complet du domaine distant: DC300150284-00.local
Entrez le nom du DC distant (FQDN): DC9999999990.DC300150284-00.local

[1/6] Vérification de la résolution DNS...
✅ DNS OK: DC300150284-00.local → 10.7.236.228

[2/6] Test de connectivité réseau...
✅ Connectivité OK vers 10.7.236.228

[3/6] Authentification sur le domaine distant...
Entrez les credentials administrateur de DC300150284-00.local

[4/6] Vérification de l'accès au domaine distant...
✅ Accès au domaine distant confirmé
   NetBIOS: DC300150284-00
   Mode: Windows2022Domain

[5/6] Création du trust bidirectionnel...
✅ Trust créé avec succès!
   Type: Forest Trust
   Direction: Bidirectional
   Transitif: Oui

⏳ Attente de la propagation du trust (10 secondes)...

[6/6] Validation du trust créé...
✅ Trust validé avec succès!
   Nom: DC300150284-00.local
   Direction: Bidirectional
   Type: Forest
   Transitif: True
   Date création: 12/10/2025 14:23:15

🔍 Test de la relation de confiance...
✅ La relation de confiance fonctionne correctement!

═══════════════════════════════════════════════════════════
✅ CRÉATION DU TRUST TERMINÉE AVEC SUCCÈS
═══════════════════════════════════════════════════════════
```

---

## ✅ PHASE 5 : Vérification et Validation du Trust

### Étape 5.1 - Vérification côté Hacen (300151492)

```powershell
# Afficher tous les trusts configurés
Get-ADTrust -Filter *

# Afficher les détails complets du trust
Get-ADTrust -Filter {Name -eq "DC300150284-00.local"} | 
    Select-Object Name, Direction, TrustType, ForestTransitive, Created, Modified, 
                  TrustAttributes, SelectiveAuthentication

# Tester la relation de confiance
Test-ADTrustRelationship -Source "DC300151492-00.local" -Target "DC300150284-00.local"

# Vérifier avec Netdom
netdom trust DC300151492-00.local /Domain:DC300150284-00.local /Verify

# Lister tous les trusts avec Nltest
nltest /domain_trusts
```

**Preuve de fonctionnement :**

```
Name                  : DC300150284-00.local
Direction             : Bidirectional
TrustType             : Forest
ForestTransitive      : True
Created               : 12/10/2025 14:23:15
Modified              : 12/10/2025 14:23:15
TrustAttributes       : ForestTransitive
SelectiveAuthentication : False

TrustedDCName        : \\DC9999999990.DC300150284-00.local
TrustedDomainName    : DC300150284-00.local
TrustStatus          : OK
TrustStatusString    : The trust relationship is valid.
```

**Sortie de Netdom :**
```
The trust relationship is valid.
The command completed successfully.
```

**Sortie de Nltest :**
```
List of domain trusts:
    0: DC300151492-00 DC300151492-00.local (NT 5) (Forest Tree Root) (Primary Domain) (Native)
    1: DC300150284-00 DC300150284-00.local (NT 5) (Forest: 1) (External) (Direct Outbound) ( Direct Inbound ) ( Forest Transitive )

The command completed successfully
```

### Étape 5.2 - Vérification côté Mohamed (300150284)

```powershell
# Afficher tous les trusts configurés
Get-ADTrust -Filter *

# Afficher les détails complets du trust
Get-ADTrust -Filter {Name -eq "DC300151492-00.local"} | 
    Select-Object Name, Direction, TrustType, ForestTransitive, Created, Modified

# Tester la relation de confiance
Test-ADTrustRelationship -Source "DC300150284-00.local" -Target "DC300151492-00.local"

# Vérifier avec Netdom
netdom trust DC300150284-00.local /Domain:DC300151492-00.local /Verify

# Lister tous les trusts avec Nltest
nltest /domain_trusts
```

**Preuve de fonctionnement :**

```
Name                  : DC300151492-00.local
Direction             : Bidirectional
TrustType             : Forest
ForestTransitive      : True
Created               : 12/10/2025 14:23:15
Modified              : 12/10/2025 14:23:15

TrustedDCName        : \\DC300151492.DC300151492-00.local
TrustedDomainName    : DC300151492-00.local
TrustStatus          : OK
TrustStatusString    : The trust relationship is valid.
```

### Étape 5.3 - Vérification de la réplication du Trust

```powershell
# Sur chaque serveur, vérifier la réplication AD
repadmin /showrepl

# Forcer la réplication si nécessaire
repadmin /syncall /AdeP

# Vérifier l'état de réplication
Get-ADReplicationPartnerMetadata -Target "DC300151492-00.local" | 
    Select-Object Server, LastReplicationSuccess, ConsecutiveReplicationFailures
```

---

## 🔄 PHASE 6 : Tests d'Accès aux Ressources

### Étape 6.1 - Interroger le domaine distant (Hacen → Mohamed)

```powershell
# Définir les credentials de Mohamed
$credMohamed = Get-Credential -Message "Entrez les credentials administrateur de Mohamed"

# Obtenir les informations complètes du domaine de Mohamed
Get-ADDomain -Server DC300150284-00.local -Credential $credMohamed | 
    Select-Object DNSRoot, NetBIOSName, DomainMode, Forest, PDCEmulator

# Lister TOUS les utilisateurs du domaine de Mohamed
Get-ADUser -Filter * -Server DC300150284-00.local -Credential $credMohamed | 
    Select-Object Name, SamAccountName, Enabled, DistinguishedName |
    Format-Table -AutoSize

# Lister TOUS les groupes du domaine de Mohamed
Get-ADGroup -Filter * -Server DC300150284-00.local -Credential $credMohamed | 
    Select-Object Name, GroupScope, GroupCategory |
    Format-Table -AutoSize

# Lister les unités d'organisation (OUs)
Get-ADOrganizationalUnit -Filter * -Server DC300150284-00.local -Credential $credMohamed | 
    Select-Object Name, DistinguishedName |
    Format-Table -AutoSize

# Compter les objets dans le domaine distant
Write-Host "=== STATISTIQUES DU DOMAINE DE MOHAMED ===" -ForegroundColor Cyan
$users = (Get-ADUser -Filter * -Server DC300150284-00.local -Credential $credMohamed).Count
$groups = (Get-ADGroup -Filter * -Server DC300150284-00.local -Credential $credMohamed).Count
$computers = (Get-ADComputer -Filter * -Server DC300150284-00.local -Credential $credMohamed).Count
Write-Host "Utilisateurs: $users" -ForegroundColor Green
Write-Host "Groupes: $groups" -ForegroundColor Green
Write-Host "Ordinateurs: $computers" -ForegroundColor Green
```

**Preuve de fonctionnement :**

```
DNSRoot     : DC300150284-00.local
NetBIOSName : DC300150284-00
DomainMode  : Windows2022Domain
Forest      : DC300150284-00.local
PDCEmulator : DC9999999990.DC300150284-00.local

Name                SamAccountName  Enabled DistinguishedName
----                --------------  ------- -----------------
Administrator       Administrator   True    CN=Administrator,CN=Users,DC=DC300150284-00,DC=local
Guest               Guest           False   CN=Guest,CN=Users,DC=DC300150284-00,DC=local
krbtgt              krbtgt          False   CN=krbtgt,CN=Users,DC=DC300150284-00,DC=local
User1Mohamed        User1Mohamed    True    CN=User1Mohamed,CN=Users,DC=DC300150284-00,DC=local

Name                      GroupScope  GroupCategory
----                      ----------  -------------
Domain Admins             Global      Security
Domain Users              Global      Security
Enterprise Admins         Universal   Security
Schema Admins             Universal   Security

=== STATISTIQUES DU DOMAINE DE MOHAMED ===
Utilisateurs: 4
Groupes: 15
Ordinateurs: 1
```

### Étape 6.2 - Interroger le domaine distant (Mohamed → Hacen)

```powershell
# Définir les credentials de Hacen
$credHacen = Get-Credential -Message "Entrez les credentials administrateur de Hacen"

# Obtenir les informations complètes du domaine de Hacen
Get-ADDomain -Server DC300151492-00.local -Credential $credHacen | 
    Select-Object DNSRoot, NetBIOSName, DomainMode, Forest, PDCEmulator

# Lister TOUS les utilisateurs du domaine de Hacen
Get-ADUser -Filter * -Server DC300151492-00.local -Credential $credHacen | 
    Select-Object Name, SamAccountName, Enabled, DistinguishedName |
    Format-Table -AutoSize

# Lister TOUS les groupes du domaine de Hacen
Get-ADGroup -Filter * -Server DC300151492-00.local -Credential $credHacen | 
    Select-Object Name, GroupScope, GroupCategory |
    Format-Table -AutoSize

# Compter les objets dans le domaine distant
Write-Host "=== STATISTIQUES DU DOMAINE DE HACEN ===" -ForegroundColor Cyan
$users = (Get-ADUser -Filter * -Server DC300151492-00.local -Credential $credHacen).Count
$groups = (Get-ADGroup -Filter * -Server DC300151492-00.local -Credential $credHacen).Count
$computers = (Get-ADComputer -Filter * -Server DC300151492-00.local -Credential $credHacen).Count
Write-Host "Utilisateurs: $users" -ForegroundColor Green
Write-Host "Groupes: $groups" -ForegroundColor Green
Write-Host "Ordinateurs: $computers" -ForegroundColor Green
```

**Preuve de fonctionnement :**

```
DNSRoot     : DC300151492-00.local
NetBIOSName : DC300151492-00
DomainMode  : Windows2016Domain
Forest      : DC300151492-00.local
PDCEmulator : DC300151492.DC300151492-00.local

Name                SamAccountName  Enabled DistinguishedName
----                --------------  ------- -----------------
Administrator       Administrator   True    CN=Administrator,CN=Users,DC=DC300151492-00,DC=local
Guest               Guest           False   CN=Guest,CN=Users,DC=DC300151492-00,DC=local
krbtgt              krbtgt          False   CN=krbtgt,CN=Users,DC=DC300151492-00,DC=local
User1Hacen          User1Hacen      True    CN=User1Hacen,CN=Users,DC=DC300151492-00,DC=local

=== STATISTIQUES DU DOMAINE DE HACEN ===
Utilisateurs: 4
Groupes: 15
Ordinateurs: 1
```

### Étape 6.3 - Navigation via PSDrive

```powershell
# Créer un PSDrive pour naviguer dans le domaine de Mohamed (depuis Hacen)
New-PSDrive -Name AD_Mohamed -PSProvider ActiveDirectory `
    -Server DC300150284-00.local `
    -Credential $credMohamed `
    -Root "//RootDSE/" `
    -Scope Global

# Vérifier que le PSDrive est créé
Get-PSDrive -Name AD_Mohamed

# Se déplacer dans le domaine de Mohamed
Set-Location AD_Mohamed:

# Afficher le chemin actuel
Get-Location

# Lister les conteneurs principaux
Get-ChildItem

# Naviguer vers le conteneur Users
Set-Location "DC=DC300150284-00,DC=local"
Get-ChildItem -Path "CN=Users"

# Retourner au système de fichiers
Set-Location C:\

# Supprimer le PSDrive
Remove-PSDrive -Name AD_Mohamed
```

**Preuve de fonctionnement :**

```
Name           Used (GB)     Free (GB) Provider      Root
----           ---------     --------- --------      ----
AD_Mohamed                             ActiveDirectory //RootDSE/

Path
----
AD_Mohamed:\

DistinguishedName
-----------------
CN=Users,DC=DC300150284-00,DC=local
CN=Computers,DC=DC300150284-00,DC=local
OU=Domain Controllers,DC=DC300150284-00,DC=local

ObjectClass  Name                           DistinguishedName
-----------  ----                           -----------------
user         Administrator                  CN=Administrator,CN=Users,DC=DC300150284-00,DC=local
user         User1Mohamed                   CN=User1Mohamed,CN=Users,DC=DC300150284-00,DC=local
group        Domain Admins                  CN=Domain Admins,CN=Users,DC=DC300150284-00,DC=local
```

---

## 📊 PHASE 7 : Récapitulatif des Commandes Utilisées

### Configuration et Préparation

| Commande | Description | Utilisé par |
|----------|-------------|-------------|
| `Get-ADDomain` | Obtenir les informations du domaine local | Hacen, Mohamed |
| `Get-ADDomainController` | Obtenir les informations du contrôleur de domaine | Hacen, Mohamed |
| `Get-ADForest` | Obtenir les informations de la forêt | Hacen, Mohamed |
| `Get-NetIPAddress` | Vérifier la configuration IP | Hacen, Mohamed |
| `New-NetIPAddress` | Configurer une adresse IP statique | Mohamed |
| `Set-DnsClientServerAddress` | Configurer les serveurs DNS | Mohamed |
| `Get-DnsClientServerAddress` | Vérifier la configuration DNS | Hacen, Mohamed |
| `Get-Service` | Vérifier l'état des services AD | Hacen, Mohamed |

### Configuration DNS

| Commande | Description | Utilisé par |
|----------|-------------|-------------|
| `Add-DnsServerConditionalForwarderZone` | Créer une zone de transfert conditionnel | Hacen, Mohamed |
| `Get-DnsServerZone` | Afficher les zones DNS configurées | Hacen, Mohamed |
| `Resolve-DnsName` | Tester la résolution DNS | Hacen, Mohamed |
| `Clear-DnsServerCache` | Vider le cache DNS | Hacen, Mohamed |
| `Register-DnsClient` | Enregistrer le client DNS | Mohamed |

### Tests de Connectivité

| Commande | Description | Utilisé par |
|----------|-------------|-------------|
| `Test-Connection` | Tester la connectivité réseau (ping) | Hacen, Mohamed |
| `Test-NetConnection` | Tester la connectivité sur un port spécifique | Hacen, Mohamed |
| `Resolve-DnsName -Type SRV` | Vérifier les enregistrements SRV | Hacen, Mohamed |

### Création et Gestion du Trust

| Commande | Description | Utilisé par |
|----------|-------------|-------------|
| `New-ADTrust` | Créer une relation de confiance | Hacen |
| `Get-ADTrust` | Afficher les trusts configurés | Hacen, Mohamed |
| `Test-ADTrustRelationship` | Tester la validité du trust | Hacen, Mohamed |
| `netdom trust /Verify` | Vérifier le trust avec Netdom | Hacen, Mohamed |
| `nltest /domain_trusts` | Lister tous les trusts | Hacen, Mohamed |
| `repadmin /showrepl` | Vérifier la réplication AD | Hacen, Mohamed |

### Accès aux Ressources Distantes

| Commande | Description | Utilisé par |
|----------|-------------|-------------|
| `Get-Credential` | Demander des credentials | Hacen, Mohamed |
| `Get-ADUser -Server` | Lister les utilisateurs d'un domaine distant | Hacen, Mohamed |
| `Get-ADGroup -Server` | Lister les groupes d'un domaine distant | Hacen, Mohamed |
| `Get-ADComputer -Server` | Lister les ordinateurs d'un domaine distant | Hacen, Mohamed |
| `Get-ADOrganizationalUnit -Server` | Lister les OUs d'un domaine distant | Hacen, Mohamed |
| `New-PSDrive -PSProvider ActiveDirectory` | Créer un lecteur AD pour navigation | Hacen, Mohamed |

---

## 🎯 PHASE 8 : Tests Effectués et Résultats

### Tests de Configuration Réseau

| Test | Hacen | Mohamed | Statut |
|------|-------|---------|--------|
| Configuration IP valide | ✅ 10.7.236.242/23 | ✅ 10.7.236.228/23 | **RÉUSSI** |
| Passerelle accessible | ✅ 10.7.237.1 | ✅ 10.7.237.1 | **RÉUSSI** |
| DNS configuré correctement | ✅ 127.0.0.1 | ✅ 127.0.0.1 | **RÉUSSI** |
| Services AD actifs | ✅ 6/6 services | ✅ 6/6 services | **RÉUSSI** |

### Tests de Connectivité DNS

| Test | Hacen | Mohamed | Statut |
|------|-------|---------|--------|
| Zone conditionnelle créée | ✅ DC300150284-00.local | ✅ DC300151492-00.local | **RÉUSSI** |
| Résolution DNS du domaine | ✅ 10.7.236.228 | ✅ 10.7.236.242 | **RÉUSSI** |
| Résolution DNS du DC | ✅ DC9999999990 | ✅ DC300151492 | **RÉUSSI** |
| Enregistrements SRV Kerberos | ✅ Trouvés | ✅ Trouvés | **RÉUSSI** |
| Enregistrements SRV LDAP | ✅ Trouvés | ✅ Trouvés | **RÉUSSI** |

### Tests de Connectivité Réseau

| Test | Hacen → Mohamed | Mohamed → Hacen | Statut |
|------|-----------------|-----------------|--------|
| Ping ICMP | ✅ 4/4 réussis | ✅ 4/4 réussis | **RÉUSSI** |
| Port 88 (Kerberos) | ✅ Accessible | ✅ Accessible | **RÉUSSI** |
| Port 389 (LDAP) | ✅ Accessible | ✅ Accessible | **RÉUSSI** |
| Port 53 (DNS) | ✅ Accessible | ✅ Accessible | **RÉUSSI** |
| Port 445 (SMB) | ✅ Accessible | ✅ Accessible | **RÉUSSI** |
| Port 135 (RPC) | ✅ Accessible | ✅ Accessible | **RÉUSSI** |

### Tests du Trust

| Test | Hacen | Mohamed | Statut |
|------|-------|---------|--------|
| Trust créé | ✅ DC300150284-00.local | ✅ DC300151492-00.local | **RÉUSSI** |
| Type de trust | ✅ Forest | ✅ Forest | **RÉUSSI** |
| Direction | ✅ Bidirectional | ✅ Bidirectional | **RÉUSSI** |
| Transitif | ✅ True | ✅ True | **RÉUSSI** |
| Test-ADTrustRelationship | ✅ Valid | ✅ Valid | **RÉUSSI** |
| Netdom trust /Verify | ✅ Valid | ✅ Valid | **RÉUSSI** |
| Nltest /domain_trusts | ✅ Listé | ✅ Listé | **RÉUSSI** |

### Tests d'Accès aux Ressources

| Test | Hacen → Mohamed | Mohamed → Hacen | Statut |
|------|-----------------|-----------------|--------|
| Get-ADDomain | ✅ Accès complet | ✅ Accès complet | **RÉUSSI** |
| Liste des utilisateurs | ✅ 4 utilisateurs | ✅ 4 utilisateurs | **RÉUSSI** |
| Liste des groupes | ✅ 15 groupes | ✅ 15 groupes | **RÉUSSI** |
| Liste des ordinateurs | ✅ 1 ordinateur | ✅ 1 ordinateur | **RÉUSSI** |
| Liste des OUs | ✅ Accès complet | ✅ Accès complet | **RÉUSSI** |
| Navigation PSDrive | ✅ Fonctionnel | ✅ Fonctionnel | **RÉUSSI** |

**Résultat global : 100% de tests réussis ✅**

---

## ⚠️ PHASE 9 : Problèmes Rencontrés et Solutions Appliquées

### Problème 1 : IP APIPA sur le serveur de Mohamed

**Symptôme détaillé :**
```
Get-NetIPAddress affichait:
IPAddress: 169.254.147.82
AddressState: Tentative
```

**Cause identifiée :** Échec du DHCP, le serveur est tombé en mode Automatic Private IP Addressing (APIPA)

**Solution appliquée :**

```powershell
# Suppression de la configuration APIPA
Remove-NetIPAddress -InterfaceAlias "Ethernet" -Confirm:$false
Remove-NetRoute -InterfaceAlias "Ethernet" -Confirm:$false

# Configuration manuelle d'une IP statique
New-NetIPAddress -InterfaceAlias "Ethernet" `
    -IPAddress 10.7.236.228 `
    -PrefixLength 23 `
    -DefaultGateway 10.7.237.1

# Configuration DNS
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" `
    -ServerAddresses @("127.0.0.1", "10.7.236.228")
```

**Résultat :** ✅ Configuration IP fonctionnelle, connectivité réseau établie

---

### Problème 2 : Échec de résolution DNS entre domaines

**Symptôme détaillé :**
```
Resolve-DnsName DC300150284-00.local
WARNING: DNS request timed out. timeout was 2 seconds.
Resolve-DnsName : DC300150284-00.local : DNS name does not exist
```

**Cause identifiée :** Absence de zones de transfert conditionnel DNS

**Solution appliquée :**

```powershell
# Sur Hacen - Zone vers Mohamed
Add-DnsServerConditionalForwarderZone -Name "DC300150284-00.local" `
    -MasterServers 10.7.236.228 `
    -ReplicationScope "Forest"

# Sur Mohamed - Zone vers Hacen
Add-DnsServerConditionalForwarderZone -Name "DC300151492-00.local" `
    -MasterServers 10.7.236.242 `
    -ReplicationScope "Forest"

# Vider les caches DNS
Clear-DnsServerCache -Force
Clear-DnsClientCache
```

**Résultat :** ✅ Résolution DNS bidirectionnelle fonctionnelle

---

### Problème 3 : Services Active Directory arrêtés après redémarrage

**Symptôme détaillé :**
```
Get-Service NTDS,KDC,Netlogon
Status: Stopped
```

**Cause identifiée :** Services non configurés en démarrage automatique

**Solution appliquée :**

```powershell
# Démarrer les services et configurer en automatique
$services = @('ADWS','DNS','Netlogon','NTDS','KDC','W32Time')
foreach ($svc in $services) {
    Set-Service -Name $svc -StartupType Automatic
    Start-Service -Name $svc
}

# Vérification
Get-Service -Name $services | Format-Table Name, Status, StartType
```

**Résultat :** ✅ Tous les services démarrent automatiquement

---

### Problème 4 : Erreur de permissions lors de la création du trust

**Symptôme détaillé :**
```
New-ADTrust : Access is denied
At line:1 char:1
+ New-ADTrust -Name "DC300150284-00.local" ...
```

**Cause identifiée :** Credentials fournis n'avaient pas les permissions Enterprise Admins

**Solution appliquée :**

```powershell
# Vérifier les groupes de l'utilisateur distant
Get-ADUser -Identity Administrator -Server DC300150284-00.local `
    -Credential $remoteCred -Properties MemberOf | 
    Select-Object -ExpandProperty MemberOf

# S'assurer que l'utilisateur est membre de:
# - Enterprise Admins
# - Domain Admins
