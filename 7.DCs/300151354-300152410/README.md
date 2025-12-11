# TP : Trust entre deux forêts AD

## 🔵 1. Préparation des environnements

- Chaque étudiant utilise sa VM avec une forêt AD distincte.  
- Vérification de la résolution DNS entre les deux forêts :

### ✔️ Vérifier le DNS du domaine local
nslookup DC300152410-00.local
<img width="884" height="124" alt="image" src="https://github.com/user-attachments/assets/ff4af454-5c45-4531-bc71-2832cbe2d1a9" />


2. Création du trust via CLI

Création d’un trust bidirectionnel transitif entre les deux forêts AD.

✔️ Commande NETDOM de création du trust
netdom trust DC300152410-00.local /Domain:DC300151354-00.local /UserO:Administrator /PasswordO:* /UserD:Administrator /PasswordD:* /Forest /Twoway
<img width="903" height="153" alt="image" src="https://github.com/user-attachments/assets/c6f94478-fc47-4f6a-b5d9-9ddb3f59b449" />
🔵 3. Vérification du trust
✔️ Afficher les trusts via NLTEST
nltest /domain_trusts
<img width="903" height="129" alt="image" src="https://github.com/user-attachments/assets/64dfe7cd-7108-484c-af17-fda6321c904d" />


3.1 Vérification du trust via PowerShell
Get-ADTrust -Filter *
<img width="881" height="345" alt="image" src="https://github.com/user-attachments/assets/47d733a6-c185-4f21-ae9c-072a733713cb" />

3.2 Informations du domaine distant
Get-ADDomain -Server DC300151354-00.local

<img width="893" height="371" alt="image" src="https://github.com/user-attachments/assets/e650dd27-f957-446f-a4d6-adc9c905b10f" />


🔵 4. Validation finale via Active Directory Domains & Trusts

Vérification visuelle du trust bidirectionnel et transitif.
🔵 5. Tests additionnels
✔️ Connexion à un partage de l’autre forêt
net use \\10.7.236.246\SharedResources /user:DC300152410-00.local\Administrator *

<img width="900" height="225" alt="image" src="https://github.com/user-attachments/assets/56ecc558-ac09-42dd-8a73-9a5cee8bd2ef" />

5.1 Connexion au domaine distant (Credential)
$cred = Get-Credential
<img width="930" height="106" alt="image" src="https://github.com/user-attachments/assets/07bf6f55-10fc-4799-a4e8-1692b46a600c" />
5.2 Lister les utilisateurs du domaine de ton ami
Get-ADUser -Server DC300151354-00.local -Credential $cred -Filter * | Select Name,SamAccountName



5.3 Vérification via NLTEST du côté inverse
nltest /trusted_domains
nltest /domain_trusts
<img width="919" height="102" alt="image" src="https://github.com/user-attachments/assets/ea1e3fef-520b-4c32-83b6-892b1be344af" />






✔️ Vérification des utilisateurs via PowerShell
Get-ADUser -Filter * -Properties * | Select-Object Name, SamAccountName
<img width="881" height="255" alt="image" src="https://github.com/user-attachments/assets/3f9c90c6-e185-4326-be77-f10893f0284b" />
🔵 6. Vérification de l’arborescence du système
dir C:
<img width="850" height="349" alt="image" src="https://github.com/user-attachments/assets/ad5b2f71-9344-496e-8836-8f6cdf5911ce" />
## 🔵 4. Informations sur la relation de confiance

- Le domaine **DC300152410-00.local** possède une relation de confiance de type **Realm transitive** avec le domaine **DC300151354-00.local**, en entrée comme en sortie.  
- La relation est correctement configurée et visible dans la console **Active Directory Domains and Trusts**.  
- L’utilisateur Administrator est connecté sur le serveur local et la vérification du trust a été validée.

### 📸 Capture de la relation de confiance

<img width="529" height="369" alt="image" src="https://github.com/user-attachments/assets/8df04018-06e6-4320-9563-43e55ae27cc7" />

<img width="1365" height="767" alt="image" src="https://github.com/user-attachments/assets/d1a12f1e-0091-4503-aa8f-3072e0583e22" />


