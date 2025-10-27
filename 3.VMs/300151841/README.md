# INF1084 – Administration Windows  
## Participation Active Directory  
**Nom :** Massinissa Mameri  
**Matricule :** 300151841  
**Date :** 26 octobre 2025  

---

### 🧩 Installation et configuration du domaine Active Directory

#### Domaine créé
- Nom du domaine : `DC300151841-00.local`
- Contrôleur de domaine : `DC3001518410`
- DNS intégré et fonctionnel ✅

#### Étapes réalisées
1. Installation du rôle AD DS  
2. Création du domaine `DC300151841-00.local`  
3. Création des OU :  
   - `Informatique`  
   - `Comptabilité`  
4. Création des utilisateurs :  
   - Alice Dupont (adupont)  
   - Bob Martin (bmartin)  
5. Création du groupe `Techniciens` et ajout de `adupont`  
6. Vérification via PowerShell (`Get-ADUser`, `Get-ADOrganizationalUnit`) ✅  

---

 

---

### 💬 Commentaire
Tout fonctionne : le rôle AD DS est actif, le domaine est opérationnel, les utilisateurs et OU sont bien créés.


<img width="1920" height="1020" alt="domaine" src="https://github.com/user-attachments/assets/1ed53505-e251-453e-b30f-09126591b403" />


