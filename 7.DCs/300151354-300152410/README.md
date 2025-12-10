# TP : Trust entre deux forêts AD

## 🔵 1. Préparation des environnements

- Chaque étudiant utilise sa VM avec une forêt AD distincte.  
- Vérification de la résolution DNS entre les deux forêts :

### ✔️ Vérifier le DNS du domaine local
nslookup DC300152410-00.local

2. Création du trust via CLI

Création d’un trust bidirectionnel transitif entre les deux forêts AD.

✔️ Commande NETDOM de création du trust
netdom trust DC300152410-00.local /Domain:DC300151354-00.local /UserO:Administrator /PasswordO:* /UserD:Administrator /PasswordD:* /Forest /Twoway
<img width="903" height="153" alt="image" src="https://github.com/user-attachments/assets/c6f94478-fc47-4f6a-b5d9-9ddb3f59b449" />
🔵 3. Vérification du trust
✔️ Afficher les trusts via NLTEST
nltest /domain_trusts
<img width="903" height="129" alt="image" src="https://github.com/user-attachments/assets/64dfe7cd-7108-484c-af17-fda6321c904d" />

🔵 4. Validation finale via Active Directory Domains & Trusts

Vérification visuelle du trust bidirectionnel et transitif.
🔵 5. Tests additionnels
✔️ Connexion à un partage de l’autre forêt
net use \\10.7.236.246\SharedResources /user:DC300152410-00.local\Administrator *

<img width="900" height="225" alt="image" src="https://github.com/user-attachments/assets/56ecc558-ac09-42dd-8a73-9a5cee8bd2ef" />

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

