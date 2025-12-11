## 🔐 Active Directory – Trust & PSDrive
## INF1084 – TP Approbations (Trusts)
## Étudiants :

**DC2 : DC300150527-00.local    -   Bouraoui-Akrem-3000150527**
**DC1 : DC300150417-00.local    -   Nemous-Abdelatif-300150417**

--------------------------------------

## 📌 Objectif du TP
L’objectif de ce TP est de :
- Créer une relation d’approbation (Trust) entre deux environnements Active Directory
- Vérifier le bon fonctionnement du trust avec nltest
- Accéder à l’Active Directory distant via PowerShell PSDrive
- Valider la communication entre les deux domaines à l’aide de DNS conditionnel

---------------------------------------

## 🧱 Environnement
Élément	Valeur

OS..........................Windows Server 2022
Domaine local (DC1).........DC300150417-00.local
Domaine distant (DC2).......DC300150527-00.local
IP DC1......................10.7.236.235
IP DC2......................10.7.236.237
Outils......................PowerShell, NetDom, DNS, ADWS

------------------------------

## 🧪 Étape 1 – Vérification des domaines

```powershell
Get-ADDomain | Select-Object DNSRoot, NetBIOSName
Get-ADForest | Select-Object Name
```

✅ Confirme que chaque serveur est Root de sa propre forêt.

--------------------------

<img width="730" height="312" alt="image" src="https://github.com/user-attachments/assets/97586179-ff76-45e9-8561-a0d8ca2dbe0f" />
--------------------------
<img width="894" height="459" alt="image" src="https://github.com/user-attachments/assets/f3f7c0fb-4c4e-4ad9-ae0b-ff437058f1e4" />


------------------------------------

## 🌐 Étape 2 – Configuration DNS (Conditional Forwarder)

Chaque DC doit pouvoir résoudre le domaine de l’autre.

**Sur DC300150417-00**

```powershell
Add-DnsServerConditionalForwarderZone `
-Name "DC300150527-00.local" `
-MasterServers 10.7.236.237 `
-ReplicationScope Forest
```

**Vérification :**

```powershell
nslookup DC300150527-00.local
```

<img width="642" height="307" alt="image" src="https://github.com/user-attachments/assets/83e6686e-c402-4b46-8e12-0f70b2b50e3b" />

--------------------------------

**Sur DC300150527-00**

```powershell
Add-DnsServerConditionalForwarderZone `
-Name "DC300150417-00.local" `
-MasterServers 10.7.236.235 `
-ReplicationScope Forest
```

<img width="878" height="472" alt="image" src="https://github.com/user-attachments/assets/5920e8e4-c1f3-4a83-80f8-aec6849c786a" />


✅ Les deux domaines sont maintenant résolubles par DNS.

-----------------------------------

## 🔐 Étape 3 – Création du Trust (trusts1.ps1)
Conformément aux instructions du professeur
Type : **REALM**
Direction : **Two-way**
Transitivité : **Non-transitive**

```powershell
netdom trust DC300150417-00.local `
/Domain:DC300150527-00.local `
/UserD:Administrator `
/PasswordD:* `
/Add /Realm /TwoWay
```

✅ Commande exécutée avec succès.

<img width="839" height="138" alt="image" src="https://github.com/user-attachments/assets/b293e32b-4973-4600-9cf0-806c60c4867b" />


------------------------------------

## ✅ Étape 4 – Vérification du Trust

```powershell
nltest /trusted_domains
```

**Résultat obtenu :
0: DC300150527-00.local (MIT) (Direct Outbound) (Direct Inbound) (Attr: non-trans)**

✅ Le trust est fonctionnel.

<img width="837" height="141" alt="image" src="https://github.com/user-attachments/assets/8b1817ef-ce94-4a1b-b9f1-05420ef04820" />

------------------------------------

## 🔁 Étape 5 – Trusts côté DC2 (trusts2.ps1)

La configuration symétrique est validée sur le DC distant.
Le trust est reconnu des deux côtés.

**Aucun doublon de configuration requis grâce au /TwoWay**

-----------------------------------------

## 🧩 Étape 6 – Accès à l’Active Directory distant via PSDrive

**Import du module**

```powershell
Import-Module ActiveDirectory
```

**Création du PSDrive vers le domaine distant**

```powershell
$RemoteDomain = "DC300150527-00.local"
$RemoteDC     = "10.7.236.237"
$cred = Get-Credential

New-PSDrive -Name AD2 `
-PSProvider ActiveDirectory `
-Server $RemoteDC `
-Root "DC=DC300150527-00,DC=local" `
-Credential $cred
```

<img width="840" height="333" alt="image" src="https://github.com/user-attachments/assets/5e5a60c5-3021-46a1-81b0-e52031ce8093" />

---------------

**Navigation dans AD2**

```powershell
Get-ChildItem AD2:\
```

✅ Accès réussi aux OU et conteneurs du domaine distant :
- Users
- Computers
- Domain Controllers
- Students
- System

<img width="742" height="304" alt="image" src="https://github.com/user-attachments/assets/68694438-9200-4b8d-b90f-b267c57191fd" />

-------------------------------------

## ✅ Résultat Final

✔ Trust opérationnel
✔ DNS fonctionnel entre les deux domaines
✔ PSDrive AD2 accessible
✔ Navigation complète dans l’AD distant
✔ Objectifs du TP atteints à 100 %

----------------------------------------

## 📂 Fichiers inclus

trusts1.ps1 → Création du trust

trusts2.ps1 → Validation côté domaine distant

README.md

Dossier images/ contenant les preuves

--------------------



