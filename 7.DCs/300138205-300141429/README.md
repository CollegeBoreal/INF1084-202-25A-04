

# Projet final Active Directory : Trusts entre deux domains
### Etudiants : TAYLOR (300138205) , BARRY (300141429)
### Cours : INF1084 – Administration Windows Server

---

## Objectif du laboratoire

Ce laboratoire a pour objectif de vérifier la communication et l’accès entre deux contrôleurs de domaine :

- Vérifier la connectivité réseau entre les domaines  
- Récupérer les informations du domaine distant  
- Naviguer dans l’Active Directory distant

---

## 🔐 Définition d’un Trust dans AD DS

Une relation d’approbation (trust) dans Active Directory est un lien d’authentification sécurisé entre deux domaines ou forêts permettant aux utilisateurs d’un domaine d’accéder aux ressources d’un autre domaine.

---

#  le script  trusts.ps1

🧑‍🚀Dans ce laboration, nous avons realisé un trust bidirectionnel et celui qui a fait cette action est le serveur 10.7.236.188 ( DC300138205-00) en permier.

```powershell
netdom trust DC300138205-00.local /Domain:DC300141429.local /UserD:administrator /PasswordD:* /Add /Realm /TwoWay
```

<details>

  

<img src="images/lab7.2.png" alt="Girl in a jacket" width="900" height="700">


</details>

🌀le serveur donc l'ip 10.7.236.190 a aussi fait pour lui donc le trusts est bidirectionnel
```powershell
netdom trust DC300141429.local /Domain:DC300138205-00.local /UserD:administrator /PasswordD:* /Add /Realm /TwoWay
```



  

<img src="images/b1.jpeg" alt="Girl in a jacket" width="900" height="700">
<img src="images/b2.jpeg" alt="Girl in a jacket" width="900" height="700">





### **b. Vérifieons la connectivité au contrôleur de domaine DC300141429**

```powershell
Test-Connection -ComputerName DC300141429.local -Count 2
```
<img src="images/lab7.1.png" alt="Girl in a jacket" width="900" height="700">
<img src="images/lab7.4.png" alt="Girl in a jacket" width="900" height="700">

#  Installation des modules AS DC
<img src="images/lab7.3.png" alt="Girl in a jacket" width="900" height="700">

# Verification du trusts dans le serveur 10.7.236.188

<img src="images/lab7.5.png" alt="Girl in a jacket" width="900" height="700">
<img src="images/lab7.6.png" alt="Girl in a jacket" width="900" height="700">
<img width="1588" height="867" alt="image" src="https://github.com/user-attachments/assets/a7d749e2-e95e-41e4-802d-81b7ea16c9fa" />

# verification via les lignes de commandes

<img src="images/lab7.10.png" alt="Girl in a jacket" width="900" height="700">
<img src="images/lab7.12.png" alt="Girl in a jacket" width="900" height="700">


#  le script  trusts2.ps1

Dans ce laboration, nous avons realisé la navigation d'un domaine à un autre dont le script trusts2.ps1 qui a ete fait sur le serveur (300141429.local)

---
```powershell
Chargement des identifiants du domaine distant

Utilise Get-Credential pour demander un compte du domaine DC300138205.local.
Sécurise l’authentification sans stocker de mot de passe en clair.
```
![](images/T1.png)

```powershell
Test de connectivité et résolution DNS

Test-Connection vérifie que le contrôleur de domaine distant est joignable.
Confirme que la résolution DNS fonctionne et que le réseau est accessible.
```
![](images/T2.png)

```powershell
Informations du domaine local

Get-ADDomain affiche les détails du domaine actuel (DC300141429.local).
Permet de comparer avec les informations du domaine distant.
```
![](images/T3.png)

```powershell
Informations du domaine distant via le trust
Get-ADDomain -Server DC300138205.local -Credential $cred interroge le domaine distant.
Montre que le trust permet d’accéder aux données de l’autre domaine.
```
![](images/T4.png)

```powershell
Liste des utilisateurs du domaine distant
Get-ADUser -Filter * récupère les comptes utilisateurs du domaine DC300138205.local.
Affiche leurs SamAccountName et DistinguishedName.
```
![](images/T5.png)

```powershell
Vérification de l’état du trust
Get-ADTrust -Filter * liste les relations de confiance existantes.
Confirme que le trust entre les deux domaines est actif.
```
![](images/T6.png)

```powershell
Test de navigabilité (accès croisé)
On vérifie la navigabilité en tentant d’accéder au dossier partagé SharedResources sur le domaine distant DC300138205.local. Après saisie du mot de passe de l’administrateur, la commande net use renvoie le message “The command completed successfully”, ce qui confirme que l’accès au partage est autorisé et que les ressources du domaine distant sont effectivement accessibles depuis le domaine local.
```
![](images/T7.png)









