# Étudiant : 300150395
# Domaine : DC300150395-0.local
# TP Active Directory - OU


---

Ce TP est divisé en **4 fichiers PowerShell** :

### 📄 **utilisateurs1.ps1** - Configuration et Listage
- Configuration initiale des variables de domaine
- Vérification de l'environnement Active Directory
- Listage des utilisateurs actifs du domaine

### 📄 **utilisateurs2.ps1** - Création et Modification
- Obtention des credentials administrateur (optionnel)
- Création d'un nouvel utilisateur (Alice Dupont)
- Modification des attributs utilisateur

### 📄 **utilisateurs3.ps1** - Gestion des comptes
- Désactivation et réactivation de comptes
- Recherche d'utilisateurs avec filtres
- Export des données vers CSV

### 📄 **utilisateurs4.ps1** - Gestion des OU et Nettoyage
- Création d'Unités Organisationnelles (OU)
- Déplacement d'utilisateurs entre containers

---


# 🚀 Étapes du laboratoire

## Étape 0 : Configuration des variables


```powershell
$studentNumber = 300150395
$studentInstance = "00"

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"
```



---

## Étape 1 : Vérification de l'environnement

```powershell
# Importer le module AD
Import-Module ActiveDirectory

# Vérifier le domaine et les DC
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
```
<details>
<summary>📋 Output</summary>

```powershell
>>


AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300150395-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300150395-00,DC=local
DistinguishedName                  : DC=DC300150395-00,DC=local
DNSRoot                            : DC300150395-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300150395-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300150395-00,DC=local
Forest                             : DC300150395-00.local
InfrastructureMaster               : DC300150395.DC300150395-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300150395-00,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300150395-00,DC=local
ManagedBy                          :
Name                               : DC300150395-00
NetBIOSName                        : DC300150395-00
ObjectClass                        : domainDNS
ObjectGUID                         : da0b7949-9036-4132-963a-6a7646a9c2df
ParentDomain                       :
PDCEmulator                        : DC300150395.DC300150395-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300150395-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300150395.DC300150395-00.local}
RIDMaster                          : DC300150395.DC300150395-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300150395-00,DC=local, DC=DomainDnsZones,DC=DC300150395-00,DC=local,
                                     CN=Configuration,DC=DC300150395-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300150395-00,DC=local
UsersContainer                     : CN=Users,DC=DC300150395-00,DC=local

ComputerObjectDN           : CN=DC300150395,OU=Domain Controllers,DC=DC300150395-00,DC=local
DefaultPartition           : DC=DC300150395-00,DC=local
Domain                     : DC300150395-00.local
Enabled                    : True
Forest                     : DC300150395-00.local
HostName                   : DC300150395.DC300150395-00.local
InvocationId               : bf3d9cf6-e6d4-4b66-b0a1-491777d4151e
IPv4Address                : 169.254.73.139
IPv6Address                :
IsGlobalCatalog            : True
IsReadOnly                 : False
LdapPort                   : 389
Name                       : DC300150395
NTDSSettingsObjectDN       : CN=NTDS Settings,CN=DC300150395,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=DC300150395-00,DC=local
OperatingSystem            : Windows Server 2022 Datacenter
OperatingSystemHotfix      :
OperatingSystemServicePack :
OperatingSystemVersion     : 10.0 (20348)
OperationMasterRoles       : {SchemaMaster, DomainNamingMaster, PDCEmulator, RIDMaster...}
Partitions                 : {DC=ForestDnsZones,DC=DC300150395-00,DC=local, DC=DomainDnsZones,DC=DC300150395-00,DC=local,
                             CN=Schema,CN=Configuration,DC=DC300150395-00,DC=local, CN=Configuration,DC=DC300150395-00,DC=local...}
ServerObjectDN             : CN=DC300150395,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=DC300150395-00,DC=local
ServerObjectGuid           : 13ceed9e-54ea-4e58-8438-7b7983c93dc4
Site                       : Default-First-Site-Name
SslPort                    : 636



PS C:\Users\Administrator\Desktop\INF1084-202-25A-04\4.OUs\300150395>
```
</details>

---

## Étape 2 : Liste des utilisateurs du domaine

```powershell
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
```

<details>
<summary>🖼️ Capture d'écran</summary>
  
<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" src="images/Screenshot2025-11-04200152.png" />

</details>

---



## Étape 3 : Créer un nouvel utilisateur

```powershell
New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Credential $cred
```


<details>
<summary>🖼️ Capture d'écran</summary>
  
<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" src="images/Screenshot2025-11-04201040.png" />


</details>

---

## Étape 4 : Modifier un utilisateur

```powershell
Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Credential $cred
```

<details>
<summary>🖼️ Capture d'écran</summary>
  
<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" src="images/Screenshot2025-11-04201325.png" />


</details>

---

## Étape 5 : Désactiver un utilisateur

```powershell
Disable-ADAccount -Identity "alice.dupont" -Credential $cred
```

<details>
<summary>🖼️ Capture d'écran</summary>

<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" src="images/Screenshot2025-11-04201541.png" />


</details>

---

## Étape 6 : Réactiver un utilisateur

```powershell
Enable-ADAccount -Identity "alice.dupont" -Credential $cred
```

<details>
<summary>🖼️ Capture d'écran</summary>
  
<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" src="images/Screenshot2025-11-04201641.png" />


</details>

---

## Étape 7 : Supprimer un utilisateur

```powershell
Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred
```

<details>
<summary>🖼️ Capture d'écran</summary>

<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" src="images/Screenshot2025-11-04201744.png" />


</details>

---

## Étape 8 : Rechercher des utilisateurs avec un filtre

```powershell
Get-ADUser -Filter "Name -like 's*'" -Properties Name, SamAccountName |
Select-Object Name, SamAccountName
```

<details>
<summary>🖼️ Capture d'écran</summary>

<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" src="images/Screenshot2025-11-04201848.png" />



</details>

---

## Étape 9 : Exporter les utilisateurs dans un CSV

```powershell
Get-ADUser -Filter * -Server $domain -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
```




---

## Étape 10 : Créer une OU "Students"

```powershell
# Vérifier si l'OU existe
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
}

#Déplacer l’utilisateur depuis CN=Users
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Credential $cred

#Vérifier le déplacement
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName
```

<details>



