

# Projet final Active Directory : Trusts entre deux domains
### Etudiants : Madjou (300153747) , Danialla (300141368)
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

Dans ce laboration, nous avons realisé un trust unidirectionnel et celui qui a fait cette action est le serveur 10.7.236.188 ( DC300138205-00)

```powershell
trusts.ps1
```

<details>

  

<img src="images/Screenshot 2025-12-04 150356.png" alt="Girl in a jacket" width="500" height="600">

<img src="images/Screenshot 2025-12-04 152019.png" alt="Girl in a jacket" width="500" height="600">
</details>

### **b. Vérifieons la connectivité au contrôleur de domaine DC300141429**

```powershell
Test-Connection -ComputerName DC300141369.local -Count 2
```

<img src="images/Screenshot 2025-12-04 151910.png" alt="Girl in a jacket" width="500" height="600">
<img src="images/le ping.png" alt="Girl in a jacket" width="500" height="600">



---
``` powershell
trusts2.ps1
```
<details>
 
=== VÃ©rification du Trust entre les deux forÃªts ===

<img src="images/image.png" alt="Girl in a jacket" width="500" height="900">
<img src="images/Screenshot 2025-12-09 163126.png" alt="Girl in a jacket" width="500" height="900">
<img src="images/Screenshot 2025-12-09 163603.png" alt="Girl in a jacket" width="500" height="900">
<img src="images/Screenshot 2025-12-09 163932.png" alt="Girl in a jacket" width="500" height="900">



=== VÃ©rification terminÃ©e ===
</details>
---
netbios de Madjou

<img src="images/Screenshot 2025-12-09 164417.png" alt="Girl in a jacket" width="500" height="900">
j'ai pas peu lier mon adresse ip a mon domain name parce qu'on me dit que c'est payant
<img src="images/Screenshot 2025-12-09 164353.png" alt="Girl in a jacket" width="500" height="900">





