# 300151492 - Hacen

## 0️⃣ bootstrap.ps1
```powershell
# vos informations
$studentNumber = 300151492
$studentInstance = "00"

# les noms respectifs
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# les informations de sécurité
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)
```

<details>
<summary>Informations du domaine</summary>

```powershell
# Domaine: DC300151492-00.local
# NetBIOS: DC300151492-00
# Contrôleur: DC300151492.DC300151492-00.local
# IP: 10.7.236.242
```

</details>

---

## 1️⃣ utilisateurs1.ps1
```powershell
# Importer le module Active Directory
Import-Module ActiveDirectory

# Définir le nom de domaine
. .\bootstrap.ps1

# Vérifier le domaine
Get-ADDomain -Server $domainName

# Lister les contrôleurs de domaine
Get-ADDomainController -Filter * -Server $domainName     

# Lister les utilisateurs activés sauf comptes système
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
```

<details>
<summary>Résultat attendu</summary>

```powershell
AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300151492-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300151492-00,DC=local
DistinguishedName                  : DC=DC300151492-00,DC=local
DNSRoot                            : DC300151492-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300151492-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-XXXXXXXXXX-XXXXXXXXXX-XXXXXXXXXX
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300151492-00,DC=local
Forest                             : DC300151492-00.local
InfrastructureMaster               : DC300151492.DC300151492-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300151492-00,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300151492-00,DC=local
ManagedBy                          :
Name                               : DC300151492-00
NetBIOSName                        : DC300151492-00
ObjectClass                        : domainDNS
ObjectGUID                         : [GUID unique]
ParentDomain                       :
PDCEmulator                        : DC300151492.DC300151492-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300151492-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300151492.DC300151492-00.local}
RIDMaster                          : DC300151492.DC300151492-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300151492-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300151492-00,DC=local,
                                     CN=Configuration,DC=DC300151492-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300151492-00,DC=local
UsersContainer                     : CN=Users,DC=DC300151492-00,DC=local

ComputerObjectDN           : CN=DC300151492,OU=Domain Controllers,DC=DC300151492-00,DC=local
DefaultPartition           : DC=DC300151492-00,DC=local
Domain                     : DC300151492-00.local
Enabled                    : True
Forest                     : DC300151492-00.local
HostName                   : DC300151492.DC300151492-00.local
InvocationId               : [Unique ID]
IPv4Address                : 10.7.236.242
IPv6Address                :
IsGlobalCatalog            : True
IsReadOnly                 : False
LdapPort                   : 389
Name                       : DC300151492
NTDSSettingsObjectDN       : CN=NTDS Settings,CN=DC300151492,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=DC300151492-00,DC=local
OperatingSystem            : Windows Server 2022 Datacenter
OperatingSystemHotfix      :
OperatingSystemServicePack :
OperatingSystemVersion     : 10.0 (20348)
OperationMasterRoles       : {SchemaMaster, DomainNamingMaster, PDCEmulator, RIDMaster...}
Partitions                 : {DC=ForestDnsZones,DC=DC300151492-00,DC=local,
                             DC=DomainDnsZones,DC=DC300151492-00,DC=local,
                             CN=Schema,CN=Configuration,DC=DC300151492-00,DC=local,
                             CN=Configuration,DC=DC300151492-00,DC=local...}
ServerObjectDN             : CN=DC300151492,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=DC300151492-00,DC=local
ServerObjectGuid           : [Unique GUID]
Site                       : Default-First-Site-Name
SslPort                    : 636
```

</details>

---

## 2️⃣ utilisateurs2.ps1
```powershell
# Définir le domaine
. .\bootstrap.ps1

# Créer un nouvel utilisateur
New-ADUser `
    -Name "Alice Dupont" `
    -GivenName "Alice" `
    -Surname "Dupont" `
    -SamAccountName "alice.dupont" `
    -UserPrincipalName "alice.dupont@$domainName" `
    -Path "CN=Users,DC=DC300151492-00,DC=local" `
    -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
    -Enabled $true

# Modifier une propriété
Set-ADUser -Identity "alice.dupont" -Description "Utilisateur de test - Hacen"

# Désactiver le compte
Disable-ADAccount -Identity "alice.dupont"

# Réactiver le compte
Enable-ADAccount -Identity "alice.dupont"

# Vérifier l'utilisateur créé
Get-ADUser -Identity "alice.dupont" -Properties Name, SamAccountName, Enabled, Description | 
Select-Object Name, SamAccountName, Enabled, Description

# Supprimer le compte (décommenter si nécessaire)
# Remove-ADUser -Identity "alice.dupont" -Confirm:$false
```

<details>
<summary>Résultat de création</summary>

```powershell
Name          : Alice Dupont
SamAccountName: alice.dupont
Enabled       : True
Description   : Utilisateur de test - Hacen
```

**Captures d'écran:**
- Création de l'utilisateur dans Active Directory Users and Computers
- Propriétés de l'utilisateur Alice Dupont
- Liste des utilisateurs après création

</details>

---

## 3️⃣ utilisateurs3.ps1
```powershell
# --- Script : Recherche et export des utilisateurs AD ---
param(
    [string]$domain = "DC300151492-00.local"
)

$cred = Get-Credential -Message "Entrez vos identifiants AD (Administrator@DC300151492-00.local)"

Write-Host "Recherche des utilisateurs dont le prénom commence par 'A'..." -ForegroundColor Cyan

Get-ADUser -Filter "GivenName -like 'A*'" -Properties Name, SamAccountName -Server $domain -Credential $cred |
Select-Object Name, SamAccountName |
Format-Table -AutoSize

Write-Host "`nRecherche des utilisateurs dont le prénom contient la lettre 'a' (sans casse)..." -ForegroundColor Cyan

Get-ADUser -Filter * -Properties GivenName, Name, SamAccountName -Server $domain -Credential $cred |
Where-Object { $_.GivenName -match 'a' } |
Select-Object Name, GivenName, SamAccountName |
Format-Table -AutoSize

Write-Host "`nExportation de tous les utilisateurs vers TP_AD_Users_300151492.csv..." -ForegroundColor Cyan

Get-ADUser -Filter * -Server $domain -Credential $cred -Properties Name, SamAccountName, EmailAddress, Enabled, GivenName, Surname |
Where-Object { $_.SamAccountName -notin @('Administrator','Guest','krbtgt') } |
Select-Object Name, SamAccountName, GivenName, Surname, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users_300151492.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Export terminé : fichier 'TP_AD_Users_300151492.csv' créé." -ForegroundColor Green
```

<details>
<summary>Exemple de sortie</summary>

```powershell
PS C:\Users\Administrator\Documents\INF1084-202-25A-04\2.Utilisateurs\300151492> .\utilisateurs3.ps1

Recherche des utilisateurs dont le prénom commence par 'A'...

Name         SamAccountName
----         --------------
Alice Dupont alice.dupont

Recherche des utilisateurs dont le prénom contient la lettre 'a' (sans casse)...

Name         GivenName SamAccountName
----         --------- --------------
Alice Dupont Alice     alice.dupont

Exportation de tous les utilisateurs vers TP_AD_Users_300151492.csv...
Export terminé : fichier 'TP_AD_Users_300151492.csv' créé.
```

</details>

---

## 4️⃣ utilisateurs4.ps1
```powershell
# Définir le nom de domaine
. .\bootstrap.ps1

param(
    [string]$domainDN = "DC=DC300151492-00,DC=local"  # Domaine complet sous forme DN
)

# Demande des identifiants administratifs
$cred = Get-Credential -Message "Entrez vos identifiants AD (Administrator@DC300151492-00.local)"

Write-Host "Vérification de l'existence de l'OU 'Students'..." -ForegroundColor Cyan

# Vérifie si l'OU existe déjà
$ouExist = Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -Server $domainName -Credential $cred -ErrorAction SilentlyContinue

if (-not $ouExist) {
    New-ADOrganizationalUnit -Name "Students" -Path $domainDN -Server $domainName -Credential $cred
    Write-Host "OU 'Students' créée avec succès." -ForegroundColor Green
} else {
    Write-Host "L'OU 'Students' existe déjà." -ForegroundColor Yellow
}

# Création de l'utilisateur si nécessaire
Write-Host "`nVérification de l'existence de l'utilisateur 'alice.dupont'..." -ForegroundColor Cyan
$user = Get-ADUser -Filter "SamAccountName -eq 'alice.dupont'" -Server $domainName -Credential $cred -ErrorAction SilentlyContinue

if (-not $user) {
    Write-Host "Création de l'utilisateur 'Alice Dupont'..." -ForegroundColor Cyan
    New-ADUser `
        -Name "Alice Dupont" `
        -GivenName "Alice" `
        -Surname "Dupont" `
        -SamAccountName "alice.dupont" `
        -UserPrincipalName "alice.dupont@$domainName" `
        -Path "CN=Users,$domainDN" `
        -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
        -Enabled $true `
        -Server $domainName `
        -Credential $cred
    Write-Host "Utilisateur 'Alice Dupont' créé avec succès." -ForegroundColor Green
} else {
    Write-Host "L'utilisateur 'alice.dupont' existe déjà." -ForegroundColor Yellow
}

# Déplacement de l'utilisateur
Write-Host "`nDéplacement de l'utilisateur 'Alice Dupont' vers l'OU 'Students'..." -ForegroundColor Cyan

$sourcePath = "CN=Alice Dupont,CN=Users,$domainDN"
$targetPath = "OU=Students,$domainDN"

# Vérifie si l'utilisateur existe avant le déplacement
$user = Get-ADUser -Filter "SamAccountName -eq 'alice.dupont'" -Server $domainName -Credential $cred -ErrorAction SilentlyContinue
if ($user) {
    try {
        Move-ADObject -Identity $sourcePath -TargetPath $targetPath -Server $domainName -Credential $cred
        Write-Host "L'utilisateur 'Alice Dupont' a été déplacé vers 'Students'." -ForegroundColor Green
    } catch {
        Write-Host "Erreur lors du déplacement: $_" -ForegroundColor Red
    }
} else {
    Write-Host "L'utilisateur 'alice.dupont' n'existe pas dans le domaine." -ForegroundColor Red
}

# Vérification du déplacement
Write-Host "`nVérification du déplacement..." -ForegroundColor Cyan
Get-ADUser -Identity "alice.dupont" -Properties DistinguishedName -Server $domainName -Credential $cred |
Select-Object Name, DistinguishedName |
Format-List
```

<details>
<summary>Exemple de sortie</summary>

```powershell
PS C:\Users\Administrator\Documents\INF1084-202-25A-04\4.OUs\300151492> .\utilisateurs4.ps1

Vérification de l'existence de l'OU 'Students'...
OU 'Students' créée avec succès.

Vérification de l'existence de l'utilisateur 'alice.dupont'...
Création de l'utilisateur 'Alice Dupont'...
Utilisateur 'Alice Dupont' créé avec succès.

Déplacement de l'utilisateur 'Alice Dupont' vers l'OU 'Students'...
L'utilisateur 'Alice Dupont' a été déplacé vers 'Students'.

Vérification du déplacement...

Name              : Alice Dupont
DistinguishedName : CN=Alice Dupont,OU=Students,DC=DC300151492-00,DC=local
```

</details>

---

## 📋 Exercices complémentaires

### Exercice 1 : Ajouter 2 nouveaux utilisateurs
```powershell
# Ajouter Bob Martin
New-ADUser `
    -Name "Bob Martin" `
    -GivenName "Bob" `
    -Surname "Martin" `
    -SamAccountName "bob.martin" `
    -UserPrincipalName "bob.martin@DC300151492-00.local" `
    -Path "CN=Users,DC=DC300151492-00,DC=local" `
    -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
    -Enabled $true

# Ajouter Clara Benoit
New-ADUser `
    -Name "Clara Benoit" `
    -GivenName "Clara" `
    -Surname "Benoit" `
    -SamAccountName "clara.benoit" `
    -UserPrincipalName "clara.benoit@DC300151492-00.local" `
    -Path "CN=Users,DC=DC300151492-00,DC=local" `
    -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
    -Enabled $true
```

### Exercice 2 : Créer un groupe et ajouter des utilisateurs
```powershell
# Créer le groupe GroupeFormation
New-ADGroup `
    -Name "GroupeFormation" `
    -GroupScope Global `
    -GroupCategory Security `
    -Path "CN=Users,DC=DC300151492-00,DC=local"

# Ajouter tous les utilisateurs de l'OU Stagiaires
Get-ADUser -Filter * -SearchBase "OU=Stagiaires,DC=DC300151492-00,DC=local" | 
ForEach-Object {
    Add-ADGroupMember -Identity "GroupeFormation" -Members $_.SamAccountName
}
```

### Exercice 3 : Import CSV et nouveau groupe
```powershell
# Créer le groupe ImportGroupe
New-ADGroup `
    -Name "ImportGroupe" `
    -GroupScope Global `
    -GroupCategory Security `
    -Path "CN=Users,DC=DC300151492-00,DC=local"

# Importer depuis CSV et ajouter au groupe
Import-Csv "utilisateurs_import.csv" | ForEach-Object {
    # Créer l'utilisateur
    New-ADUser `
        -Name "$($_.GivenName) $($_.Surname)" `
        -GivenName $_.GivenName `
        -Surname $_.Surname `
        -SamAccountName $_.SamAccountName `
        -UserPrincipalName "$($_.SamAccountName)@DC300151492-00.local" `
        -Path "CN=Users,DC=DC300151492-00,DC=local" `
        -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
        -Enabled $true
    
    # Ajouter au groupe
    Add-ADGroupMember -Identity "ImportGroupe" -Members $_.SamAccountName
}
```

---

**Auteur:** Hacen (300151492)  
**Cours:** INF1084-202-25A-04  
**Domaine:** DC300151492-00.local
