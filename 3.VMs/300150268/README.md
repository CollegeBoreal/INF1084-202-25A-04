# Rapport VM Mohand Saïd Kemiche (300150268)
# INF1084 – Administration Windows

## Participation à Active Directory
**Nom :** Mohand Saïd Kemiche  
**Matricule :** 300150268  
**Date :** 11 novembre 2025  

---

### 🧩 Installation et configuration du domaine Active Directory

#### Domaine créé
- **Nom du domaine :** DC300150268-00.local  
- **Contrôleur de domaine :** DC300150268  
- **DNS intégré et fonctionnel :** ✅  

#### Étapes réalisées
1. Installation du rôle **AD DS**  
2. Création du domaine **DC300150268-00.local**  
3. Création des **OU** :  
   - Informatique  
   - Comptabilité  
4. Création des **utilisateurs** :  
   - Alice Dupont (`adupont`)  
   - Bob Martin (`bmartin`)  
5. Création du **groupe Techniciens** et ajout de `adupont`  
6. Vérification via PowerShell :  
   - `Get-ADUser`  
   - `Get-ADOrganizationalUnit`  
   - `Get-ADDomain`  
   - `Get-ADDomainController` ✅  

---

![wait](https://github.com/user-attachments/assets/1b245c85-9104-47e1-9e91-8b9f06b71015)

![wait](https://github.com/user-attachments/assets/140c3d5d-6b04-449b-bd5d-ecf6c2d85b65)



**Résultat de la commande Get-ADDomain**
![Résultat Get-ADDomain](get-addomain.PNG)

**Résultat de la commande Get-ADDomainController -Filter***
![Résultat Get-ADDomainController](get-addomaincontroller filter..PNG)

---

### 💬 Commentaire
Tout fonctionne correctement :  
le rôle AD DS est actif, le domaine est opérationnel, les utilisateurs et OU sont bien configurés.


