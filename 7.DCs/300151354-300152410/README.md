# 🔐 Projet : Relations de confiance (Trusts) entre deux domaines Active Directory  
### Étudiants : 300151354 – 300152410  
### Cours : INF1084 – Administration Windows Server  
---

## 🧾 1. Objectif du laboratoire

Ce laboratoire a pour objectif de configurer une **relation de confiance bidirectionnelle** entre deux forêts Active Directory afin de permettre :

- L’authentification entre domaines  
- L’accès aux ressources partagées  
- La navigation dans l’annuaire distant (ADUC)  
- La communication DNS entre les deux environnements  

---

## 🌐 2. Informations des deux domaines

| Élément | Domaine 1 | Domaine 2 |
|--------|-----------|-----------|
| Nom du domaine | DC300151354-00.local | DC300152410-00.local |
| Type de trust | Bidirectionnel | Bidirectionnel |
| Mode | Forest trust | Forest trust |

---

## 🔧 3. Vérification de la connectivité réseau

### 🔹 Test ICMP (ping)

```powershell
nslookup DC300151354-00.local
nslookup DC300152410-00.local
Install-WindowsFeature RSAT-ADDS
Import-Module ActiveDirectory
Import-Module ActiveDirectory

$LocalDomain  = "DC300152410-00.local"
$RemoteDomain = "DC300151354-00.local"

Write-Host "== Création du trust bidirectionnel ==" -ForegroundColor Cyan

netdom trust $LocalDomain /domain:$RemoteDomain /Add /UserD:administrator /PasswordD:* /TwoWay /Force

Write-Host "== Vérification du trust ==" -ForegroundColor Green
Get-ADTrust -Filter *
Get-ADTrust -Filter *
Test-ADTrustRelationship -Source "DC300152410-00.local" -Target "DC300151354-00.local"
nltest /domain_trusts
nltest /dsgetdc:DC300151354-00.local
nltest /dsgetdc:DC300152410-00.local
Get-ADUser -Filter * -Server DC300151354-00.local | Select Name, SamAccountName
net use \\DC300151354-00\SharedResources /user:administrator
net use \\DC300151354-00\SharedResources /user:administrator

Test-Connection -ComputerName DC300151354-00.local -Count 4
Test-Connection -ComputerName DC300152410-00.local -Count 4

![image](https://github.com/user-attachments/assets/3697a81c-1bff-4604-8a68-7db29374a695)
![image](https://github.com/user-attachments/assets/4e7bfe43-a1a0-4850-ac82-12d7b16aebc0)
![image](https://github.com/user-attachments/assets/5f4b07c8-6294-44f7-9205-ae473d0217ea)
![image](https://github.com/user-attachments/assets/8255d81c-9def-43d7-aa2c-3ab44d47a725)
![image](https://github.com/user-attachments/assets/35541fa1-c158-460f-83b5-02ff4fb44763)
![image](https://github.com/user-attachments/assets/d76fe128-2b23-451f-a6fc-89548579bb5c)
![image](https://github.com/user-attachments/assets/f465d39c-cc9d-4844-a88f-bacd0ea2d8f9)
![image](https://github.com/user-attachments/assets/7a04645b-2338-4960-bf74-8bacd076ea4b)
