# :link: VMs

[:tada: Participation](.scripts/Participation.md) 

Installer et configurer un contrôleur de domaine Active Directory sur **Windows Server 2022**.

---

## 🚀 Étapes avec PowerShell

### 1. Renommer le serveur 

:bulb: remplacer `DC999999990` par votre :id: par example "DC300098957"

```powershell
Rename-Computer -NewName "DC999999999" -Restart
```

---

## 🚀 Installation AD : Étapes avec PowerShell

### 1. Renommer le serveur

```powershell
Rename-Computer -NewName "DC9999999990" -Restart
```

*(le serveur va redémarrer)*

---

### 2. Installer le rôle AD DS

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```
<details>
<summary>Output</summary>

```powershell

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...
```

</details>

---

### 3. Créer un nouveau domaine (nouvelle forêt)

Exemple avec domaine **DC999999999-00.local** :

```powershell
Install-ADDSForest `
    -DomainName "DC999999999-00.local" `
    -DomainNetbiosName "DC999999999-00" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
    -Force
```
<details>
<summary>Output</summary>

```powershell
Install-ADDSForest

  Validating environment and user input
      All tests completed successfully                                                                                       [oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo]
      Installing new forest Starting

For more information about this setting, see Knowledge Base article 942564
(http://go.microsoft.com/fwlink/?LinkId=104751).

WARNING: This computer has at least one physical network adapter that does not have static IP address(es) assigned to
its IP Properties. If both IPv4 and IPv6 are enabled for a network adapter, both IPv4 and IPv6 static IP addresses
should be assigned to both IPv4 and IPv6 Properties of the physical network adapter. Such static IP address(es)
assignment should be done to all the physical network adapters for reliable Domain Name System (DNS) operation.

WARNING: A delegation for this DNS server cannot be created because the authoritative parent zone cannot be found or it
 does not run Windows DNS server. If you are integrating with an existing DNS infrastructure, you should manually
create a delegation to this DNS server in the parent zone to ensure reliable name resolution from outside the domain
"DC999999999.local". Otherwise, no action is required.

WARNING: Windows Server 2022 domain controllers have a default for the security setting named "Allow cryptography
algorithms compatible with Windows NT 4.0" that prevents weaker cryptography algorithms when establishing security
channel sessions.

For more information about this setting, see Knowledge Base article 942564
(http://go.microsoft.com/fwlink/?LinkId=104751).

WARNING: This computer has at least one physical network adapter that does not have static IP address(es) assigned to
its IP Properties. If both IPv4 and IPv6 are enabled for a network adapter, both IPv4 and IPv6 static IP addresses
should be assigned to both IPv4 and IPv6 Properties of the physical network adapter. Such static IP address(es)
assignment should be done to all the physical network adapters for reliable Domain Name System (DNS) operation.
```

</details>

* `-DomainName` → nom DNS du domaine.
* `-DomainNetbiosName` → version courte (max 15 caractères, ex. DC9999999990).
* `-InstallDns:$true` → installe DNS en même temps.
* `-SafeModeAdministratorPassword` → mot de passe pour le mode restauration DSRM.
* `-Force` → évite les confirmations.

👉 Le serveur redémarrera automatiquement.

---

### 4. Vérifier l’installation

Une fois redémarré, connecte-toi avec :

```
DC999999999\Administrator
```

Puis vérifie :

```powershell
Get-ADDomain
Get-ADForest
```

---

## 🎯 Résultat

Avec seulement **3 commandes PowerShell**, tu crées un **contrôleur de domaine Active Directory** complet avec DNS intégré.
