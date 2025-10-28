Parfait ! On peut créer un **laboratoire AD complet** en partant de ta commande de base. Je vais te proposer un **script PowerShell étape par étape** pour un labo comprenant :

* La **création d’une forêt / domaine**
* Un **DC principal**
* Un **RODC**
* Un **DC secondaire cloné**
* Un **site et sous-réseaux**
* Vérification de la réplication et FSMO

Voici un exemple concret :

```powershell
# 1️⃣ Importer le module AD
Import-Module ActiveDirectory

# 2️⃣ Créer la forêt principale
Install-ADDSForest `
    -DomainName "DC999999999-00.local" `
    -DomainNetbiosName "DC999999999-00" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
    -Force

# 3️⃣ Ajouter un deuxième DC (contrôleur en lecture/écriture)
Install-ADDSDomainController `
    -DomainName "DC999999999-00.local" `
    -InstallDns:$true `
    -Credential (Get-Credential) `
    -SiteName "Default-First-Site-Name" `
    -Force

# 4️⃣ Ajouter un RODC (Read-Only Domain Controller)
Install-ADDSDomainController `
    -DomainName "DC999999999-00.local" `
    -ReadOnlyReplica `
    -Credential (Get-Credential) `
    -SiteName "Site-RODC" `
    -InstallDns:$true `
    -Force

# 5️⃣ Cloner un DC virtuel
# 🔹 Préparer le fichier DCCloneConfig.xml sur le DC à cloner
# 🔹 Exemple minimal pour un DC virtuel cloné
$CloneConfig = @"
<CloneConfig>
  <VMName>DC999999999-CLONE</VMName>
  <VMPath>C:\VMs\DCClone</VMPath>
  <VirtualNetwork>vSwitchLab</VirtualNetwork>
  <DomainAdmin>Administrator</DomainAdmin>
</CloneConfig>
"@
$CloneConfig | Out-File "C:\Windows\NTDS\DCCloneConfig.xml" -Encoding UTF8
Restart-Computer

# 6️⃣ Créer un site et sous-réseau pour tester la réplication
New-ADReplicationSite -Name "Site-MTL"
New-ADReplicationSubnet -Name "192.168.1.0/24" -Site "Site-MTL"

# 7️⃣ Vérifier les rôles FSMO
Get-ADDomain | Select-Object RIDMaster,PDCEmulator,InfrastructureMaster
Get-ADForest | Select-Object SchemaMaster,DomainNamingMaster

# 8️⃣ Vérifier la réplication entre DC
Get-ADReplicationPartnerMetadata -Target "DC999999999-00"

# 9️⃣ Créer un utilisateur test
New-ADUser -Name "UserTest" -SamAccountName "UserTest" -AccountPassword (ConvertTo-SecureString "Test123!" -AsPlainText -Force) -Enabled $true
```

---

✅ **Explications rapides :**

1. `Install-ADDSForest` : crée la **forêt et le domaine principal**.
2. `Install-ADDSDomainController` : ajoute un **DC supplémentaire**, avec ou sans RODC.
3. **Clonage** : nécessite `DCCloneConfig.xml` et Hyper-V ou VMware.
4. `New-ADReplicationSite` et `New-ADReplicationSubnet` : simulent des **topologies réseau différentes** pour la réplication.
5. `Get-ADReplicationPartnerMetadata` et `Get-ADDomain`/`Get-ADForest` : vérifient FSMO et réplication.
6. `New-ADUser` : crée un utilisateur pour tester le domaine.

