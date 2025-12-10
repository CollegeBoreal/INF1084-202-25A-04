# TP Active Directory - Configuration de Trust entre Forêts
#300150205 - #300150296

---

Ce TP démontre la configuration d'une **relation d'approbation bidirectionnelle** entre deux forêts Active Directory distinctes.

### 📄 **bootstrap.ps1** - Variables communes
- Configuration des informations de domaine AD1 et AD2
- Définition des credentials pour les deux domaines
- Détection automatique des contrôleurs de domaine

### 📄 **trust1.ps1** - Configuration du trust depuis AD1
- Test de connectivité vers AD2
- Création du trust bidirectionnel
- Vérification du trust
- Tests d'accès AD cross-domain

### 📄 **trust2.ps1** - Configuration du trust depuis AD2
- Test de connectivité vers AD1
- Création du trust bidirectionnel (côté AD2)
- Vérification du trust
- Tests d'accès AD cross-domain



---

# 🚀 Étapes du laboratoire

## Étape 0 : Configuration des variables

Le fichier `bootstrap.ps1` contient les informations des deux domaines :

```powershell
# AD1 (Étudiant 300150205)
$studentNumber1 = "300150205"
$domainName1 = "DC300150205-00.local"
$netbiosName1 = "DC300150205-00"

# AD2 (Étudiant 300150296)
$studentNumber2 = "300150296"
$domainName2 = "DC300150296-00.local"
$netbiosName2 = "DC300150296-00"
```

---

## Étape 1 : Configuration DNS (Conditional Forwarders)

Avant d'établir le trust, configurez les conditional forwarders DNS :

**Sur AD1:**
```powershell
Add-DnsServerConditionalForwarderZone -Name "DC300150296-00.local" -MasterServers "10.7.236.230"
```

**Sur AD2:**
```powershell
Add-DnsServerConditionalForwarderZone -Name "DC300150205-00.local" -MasterServers "10.7.236.226"
```

Vérification :
```powershell
Get-DnsServerZone | Where-Object {$_.IsAutoCreated -eq $false}
Resolve-DnsName DC300150296.DC300150296-00.local
```


---

## Étape 2 : Test de connectivité réseau

Vérifiez la connectivité bidirectionnelle entre les deux contrôleurs de domaine :

**Depuis AD1:**
```powershell
Test-Connection -ComputerName DC300150296.DC300150296-00.local -Count 4
```

**Depuis AD2:**
```powershell
Test-Connection -ComputerName DC300150205.DC300150205-00.local -Count 4
```

---

## Étape 3 : Création du trust depuis AD1

Exécutez le script de création du trust sur le contrôleur de domaine AD1 :

```powershell
.\trust1.ps1
```

**Ce script effectue:**
1. Test de connectivité vers AD2
2. Création du trust bidirectionnel avec `netdom`
3. Vérification du trust créé
4. Tests d'accès aux ressources AD2

---

## Étape 4 : Création du trust depuis AD2

Votre partenaire (étudiant 300150296) doit exécuter le script sur AD2 :

```powershell
.\trust2.ps1
```

**Note importante:** Les deux scripts doivent être exécutés pour établir le trust bidirectionnel complet.


---

## Étape 5 : Vérification du trust via PowerShell

Sur les deux domaines, vérifiez que le trust est correctement établi :

```powershell
# Lister tous les trusts
Get-ADTrust -Filter *

# Détails du trust spécifique
Get-ADTrust -Identity "DC300150296-00.local" | Format-List *
```

**Propriétés attendues:**
- **Direction:** Bidirectional
- **TrustType:** Uplevel (ou Forest)
- **SelectiveAuthentication:** False (authentification complète)

---

## Étape 6 : Vérification via nltest

Utilisez `nltest` pour valider la santé du trust :

**Sur AD1:**
```powershell
nltest /trusted_domains
nltest /dsgetdc:DC300150296-00.local
nltest /sc_query:DC300150296-00.local
```

**Sur AD2:**
```powershell
nltest /trusted_domains
nltest /dsgetdc:DC300150205-00.local
nltest /sc_query:DC300150205-00.local
```

---

## Étape 7 : Vérification via GUI (domain.msc)

Ouvrez la console "Active Directory Domains and Trusts" :

```powershell
domain.msc
```

**Vérifications:**
1. Clic droit sur votre domaine → Properties
2. Onglet "Trusts"
3. Vérifiez que le domaine partenaire apparaît dans les deux sections :
   - "Domains trusted by this domain (outgoing trusts)"
   - "Domains that trust this domain (incoming trusts)"


---

## Étape 8 : Test d'authentification cross-domain

Testez l'accès aux ressources du domaine distant depuis AD1 :

```powershell
# Interroger le domaine AD2
Get-ADDomain -Server DC300150296.DC300150296-00.local -Credential $cred2

# Lister les utilisateurs de AD2
Get-ADUser -Filter * -Server DC300150296.DC300150296-00.local -Credential $cred2 | 
    Select-Object SamAccountName, Name, DistinguishedName

# Lister les groupes de AD2
Get-ADGroup -Filter * -Server DC300150296.DC300150296-00.local -Credential $cred2 |
    Select-Object Name, GroupScope
```


---

## Étape 9 : Test d'authentification utilisateur cross-domain

Créez un utilisateur de test dans AD1 et validez l'authentification vers AD2 :

**Sur AD1:**
```powershell
# Créer un utilisateur de test
New-ADUser -Name "TestUser1" -SamAccountName "testuser1" `
    -UserPrincipalName "testuser1@DC300150205-00.local" `
    -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
    -Enabled $true

# Tester l'accès cross-domain
$testCred = Get-Credential DC300150205-00\testuser1
Get-ADDomain -Server DC300150296.DC300150296-00.local -Credential $testCred
```


---

## Étape 10 : Configuration d'un partage cross-domain

Configurez un partage réseau accessible depuis l'autre domaine :

**Sur AD1:**
```powershell
# Créer un dossier partagé
New-Item -Path "C:\SharedCrossDomain" -ItemType Directory
New-SmbShare -Name "CrossDomainShare" -Path "C:\SharedCrossDomain" -FullAccess "Everyone"

# Ajouter des permissions NTFS pour le domaine AD2
$acl = Get-Acl "C:\SharedCrossDomain"
$ar = New-Object System.Security.AccessControl.FileSystemAccessRule(
    "DC300150296-00\Domain Users", "Modify", "ContainerInherit,ObjectInherit", "None", "Allow"
)
$acl.SetAccessRule($ar)
Set-Acl "C:\SharedCrossDomain" $acl
```

**Test depuis AD2:**
```powershell
# Mapper le lecteur distant
net use X: \\DC300150205.DC300150205-00.local\CrossDomainShare /user:DC300150205-00\testuser1 Pass123!

# Créer un fichier test
New-Item -Path "X:\test_from_ad2.txt" -ItemType File -Value "Test depuis AD2"
```


---

## Étape 11 : Vérification des tickets Kerberos

Vérifiez que l'authentification Kerberos fonctionne correctement entre les domaines :

```powershell
# Purger les tickets existants
klist purge

# Accéder à une ressource du domaine distant (ceci génère un ticket)
Get-ADDomain -Server DC300150296.DC300150296-00.local -Credential $cred2

# Afficher les tickets Kerberos
klist
```

**Tickets attendus:**
- Ticket TGT pour le domaine local
- Ticket de service pour le domaine distant


---

## Étape 12 : Test de résolution de noms via le trust

Vérifiez que la résolution de noms fonctionne à travers le trust :

```powershell
# Depuis AD1, résoudre un utilisateur de AD2
Get-ADUser -Identity "student1" -Server DC300150296-00.local

# Résoudre un groupe du domaine distant
Get-ADGroup -Identity "Domain Users" -Server DC300150296-00.local

# Test de résolution inverse
Resolve-DnsName DC300150296.DC300150296-00.local
```


---

## Étape 13 : Vérification finale - État complet du trust

Exécutez une vérification complète de la configuration :

```powershell
# Status du trust
Get-ADTrust -Filter * | Format-Table Name, Direction, TrustType, IntraForest

# Validation netdom
netdom trust DC300150205-00.local /Domain:DC300150296-00.local /Verify

# Test de communication sécurisée
nltest /sc_verify:DC300150296-00.local

# État des contrôleurs de domaine
Get-ADDomainController -Server DC300150296.DC300150296-00.local -Credential $cred2 |
    Select-Object Name, IPv4Address, OperatingSystem
```


