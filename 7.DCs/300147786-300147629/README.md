# TP : Trust entre deux forêts AD

## 🖥️ 1. Préparation des environnements

* Chaque étudiant utilise sa **VM avec une forêt AD distincte**.
* Vérification de la **résolution DNS entre les deux forêts** :

```powershell
# Vérifier le DNS du domaine local
nslookup DC300147786-00.local

# Vérifier le DNS du domaine distant
nslookup DC300147629-00.local
```
<img width="465" height="192" alt="image1" src="https://github.com/user-attachments/assets/1170a725-03e4-427a-a1ab-affd40261b41" />
<img width="507" height="220" alt="baldewindow" src="https://github.com/user-attachments/assets/3e56c500-5627-4d01-980c-75bd86306ad0" />



---

## 🔐 2. Création du trust via CLI

Création d’un **trust bidirectionnel transitif** entre les deux forêts :

```powershell
netdom trust DC300147629-00.local /Domain:DC300147786-00.local /UserO:Administrator /PasswordO:* /UserD:Administrator /PasswordD:* /Forest /Twoway
```

### ✅ Vérification que le trust a été créé

```powershell
nltest /domain_trusts
```
<img width="1062" height="377" alt="capt2025" src="https://github.com/user-attachments/assets/a42fb84f-d1f0-4898-81dc-8b7d067fd503" />

---

## 🧪 3. Vérification du trust et tests d’accès

### 📡 b. Vérification de la connectivité au contrôleur de domaine AD2

```powershell
Resolve-DnsName DC300147629-00.local
```
![capt1_abdull](https://github.com/user-attachments/assets/6c49cf9a-b903-485b-87e2-bf600f8fbdbb)

```powershell
Test-Connection -ComputerName dc01.ad2.local -Count 2
```
![Capture_alll](https://github.com/user-attachments/assets/2211f081-d75a-4eba-a582-dc964a96f721)


### 📁 c. Accès aux ressources partagées du domaine distant

```powershell
# Monter le partage distant avec un utilisateur du domaine local
net use \\10.7.236.225\SharedResources /user:DC300147786-00.local\Administrator *
```
<img width="948" height="312" alt="capt2027" src="https://github.com/user-attachments/assets/fc94ac30-35ec-4573-ae56-12b543389b4a" />

### 📂 d. Vérification du contenu du partage distant

```powershell
# Lister le contenu du partage distant
Get-ChildItem \\10.7.236.225\SharedResources
```
<img width="775" height="641" alt="Capt2028" src="https://github.com/user-attachments/assets/a4410ed4-a644-4663-be7a-c07e537af21d" />


### 👥 e. Vérification des utilisateurs du serveur local depuis le domaine distant

```powershell
# Liste des utilisateurs du domaine local
Get-ADUser -Filter * -Server DC300147786-00.local
```
<img width="1186" height="387" alt="capt2029" src="https://github.com/user-attachments/assets/0c28698a-71c2-4b65-95d2-f794143439c9" />

---

## 🔄 4. Informations sur la relation de confiance

* Le domaine **DC300147786-00.local** possède une **relation de confiance de type Realm non transitive** avec le domaine **DC300147629-00.local**, en entrée comme en sortie.
* L’utilisateur **Administrator** est actuellement connecté en session RDP sur le serveur local, visualisable avec :

```powershell
quser
```
![captabdoul](https://github.com/user-attachments/assets/6dd8c01c-fa71-4345-8d34-b65548a57dd5)

---



```powershell

```
#Voici le resultat car il dis que j'ai oublier le mot de pass alors que j'ai pas oublier
![captabdoul]<img width="1545" height="818" alt="iboune png" src="https://github.com/user-attachments/assets/629c70f7-58da-49c4-8232-1ed664b78fc2" />



---












