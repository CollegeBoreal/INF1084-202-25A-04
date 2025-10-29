# Documentation Active Directory
**Projet :** #300151492  
**Environnement :** Windows Server 2016+

---

## 🔧 Étape 1 : Installation des Rôles AD DS

Cette section décrit l'installation initiale des services de domaine Active Directory.

### Commande PowerShell
```powershell
PS C:\Users\Administrator> Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

### Résultat de l'Installation

<details>
<summary>💡 Cliquez pour voir les détails de l'installation</summary>
```powershell
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...
```

✅ **Statut :** Installation réussie  
🔄 **Redémarrage requis :** Non  
📦 **Composants installés :** Active Directory Domain Services + Outils de gestion
</details>

---

## 🏢 Étape 2 : Vérification de la Configuration du Domaine

Analyse complète des paramètres du domaine Active Directory.

### Commande d'Inspection
```powershell
PS C:\Users\Administrator> Get-ADDomain
```

<details>
<summary>🔍 Voir la configuration complète du domaine</summary>

### Informations Générales
```
Nom DNS du domaine : DC300151492-00.local
Nom NetBIOS       : DC300151492-00
Distinguished Name : DC=DC300151492-00,DC=local
Mode de domaine   : Windows2016Domain
Forêt parent      : DC300151492-00.local
GUID d'objet      : 81f13b99-c8d8-4066-bc23-767132c65141
SID du domaine    : S-1-5-21-447135690-91861430-3213525697
```

### Rôles de Maître d'Opérations (FSMO)
```
PDC Emulator         : DC300151492.DC300151492-00.local
RID Master           : DC300151492.DC300151492-00.local
Infrastructure Master : DC300151492.DC300151492-00.local
```

### Serveurs de Réplication
```
Contrôleurs de domaine en lecture/écriture :
  - DC300151492.DC300151492-00.local

Contrôleurs de domaine en lecture seule :
  - Aucun
```

### Structure Organisationnelle
```
Conteneur Ordinateurs    : CN=Computers,DC=DC300151492-00,DC=local
Conteneur Utilisateurs   : CN=Users,DC=DC300151492-00,DC=local
Conteneur Système        : CN=System,DC=DC300151492-00,DC=local
Conteneur Objets Supprimés : CN=Deleted Objects,DC=DC300151492-00,DC=local
Conteneur Quotas         : CN=NTDS Quotas,DC=DC300151492-00,DC=local
Objets Perdus et Trouvés : CN=LostAndFound,DC=DC300151492-00,DC=local
```

### Stratégies de Groupe
```
GPO liés : CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300151492-00,DC=local
```

### Capture d'Écran
![Configuration du domaine AD](screenshots/vn3.2.png)

</details>

---

## 🌐 Étape 3 : Vérification de la Configuration de la Forêt

Analyse des paramètres de la forêt Active Directory et des services d'infrastructure.

### Commande d'Inspection
```powershell
PS C:\Users\Administrator> Get-ADForest
```

<details>
<summary>🌲 Voir la configuration complète de la forêt</summary>

### Propriétés de la Forêt
```
Nom de la forêt  : DC300151492-00.local
Domaine racine   : DC300151492-00.local
Mode de la forêt : Windows2016Forest
```

### Domaines Membres
```
Domaines dans la forêt :
  - DC300151492-00.local

Domaines enfants :
  - Aucun
```

### Rôles FSMO au Niveau Forêt
```
Schema Master         : DC300151492.DC300151492-00.local
Domain Naming Master  : DC300151492.DC300151492-00.local
```

### Infrastructure DNS
```
Partitions d'application :
  - DC=DomainDnsZones,DC=DC300151492-00,DC=local
  - DC=ForestDnsZones,DC=DC300151492-00,DC=local

Conteneur de partitions :
  - CN=Partitions,CN=Configuration,DC=DC300151492-00,DC=local
```

### Catalogues Globaux
```
Serveurs de catalogue global :
  - DC300151492.DC300151492-00.local
```

### Topologie de Sites
```
Sites configurés :
  - Default-First-Site-Name
```

### Suffixes Personnalisés
```
Suffixes UPN : Aucun
Suffixes SPN : Aucun
```

### Références Externes
```
Références inter-forêts : Aucune
```

### Capture d'Écran
![Configuration de la forêt AD](screenshots/vm3.2.png)

</details>

---
