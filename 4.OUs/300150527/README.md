# 🧭 TP Active Directory – Gestion des Utilisateurs et des OU

## 👤 Informations Étudiant
- **Nom :** Bouraoui Akrem  
- **Numéro étudiant :** 300150527  
- **Instance :** 00  
- **Nom de domaine :** DC300150527-00.local  
- **Nom NetBIOS :** DC300150527-00  

---------------------

## ⚙️ Étape 0 – Configuration des variables

```powershell
$studentNumber = 300150527
$studentInstance = "00"
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)
```

📁 Fichier : bootstrap.ps1
Ce script initialise les variables globales du domaine et les identifiants administrateur.

<img width="867" height="438" alt="jjjjjj" src="https://github.com/user-attachments/assets/319a4c84-9c0b-4e32-902a-862ee14037f3" />


---------------------------------

## 🧩 Étape 1 – Préparation de l’environnement

```powershell
Import-Module ActiveDirectory
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
```

📄 Vérifie la configuration du domaine et le contrôleur de domaine.

<img width="1111" height="506" alt="2 1" src="https://github.com/user-attachments/assets/4b23458e-be6b-4889-beee-a50efe650bee" />

<img width="1114" height="504" alt="2 2" src="https://github.com/user-attachments/assets/6f3c6fa2-f70f-4b1d-b78f-832d752de281" />



----------------------------------------

## 👥 Étape 2 – Liste des utilisateurs du domaine.

```powershell
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
```

📋 Liste les utilisateurs actifs créés dans le domaine

<img width="856" height="392" alt="3" src="https://github.com/user-attachments/assets/3fe92306-9602-46f3-90bf-e70d572c4224" />


-----------------------------------------------

## 🧍 Étape 3 – Créer un utilisateur

```powershell
New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Credential $cred
```
           
✅ Utilisateur Alice Dupont ajouté avec succès.

<img width="857" height="502" alt="4" src="https://github.com/user-attachments/assets/7c56d6aa-26ff-447c-ab11-b8ad6fba7645" />


-------------------------------------

## 📝 Étape 4 – Modifier un utilisateur

```powershell
Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Credential $cred
```

🖊️ Mise à jour du prénom et de l’adresse courriel.


<img width="858" height="500" alt="5" src="https://github.com/user-attachments/assets/6c44ccba-f2d1-49e9-9259-cd189a14d397" />



----------------------------------------------

## 🚫 Étape 5 – Désactiver un utilisateur

```powershell
Disable-ADAccount -Identity "alice.dupont" -Credential $cred
```

👤 L’utilisateur Alice Dupont est désactivé.

<img width="854" height="497" alt="6" src="https://github.com/user-attachments/assets/e57bf64f-1482-4465-9838-8738d5ce6599" />


------------------------------------------

## 🔁 Étape 6 – Réactiver un utilisateur

```powershell
Enable-ADAccount -Identity "alice.dupont" -Credential $cred
```

🔓 L’utilisateur est maintenant réactivé.


<img width="856" height="495" alt="7" src="https://github.com/user-attachments/assets/cd905bb9-d9aa-49aa-9c34-cfedbb55254c" />



----------------------------------------------------

## ❌ Étape 7 – Supprimer un utilisateur

```powershell
Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred
```

🗑️ L’utilisateur a été supprimé définitivement.

<img width="858" height="499" alt="8" src="https://github.com/user-attachments/assets/0d8ae62a-2f4f-486f-ad7f-f3255f65961e" />


---------------------------------------------------

## 🧾 Étape 8 – Exporter la liste des utilisateurs

📤 Génère un fichier CSV contenant la liste des utilisateurs.

<img width="857" height="466" alt="10" src="https://github.com/user-attachments/assets/fd6691f5-1d28-4bb6-9633-356d00d679c8" />


--------------------------------------------

## 🗂️ Étape 9 – Rechercher des utilisateurs avec un filtre

```powershell
Get-ADUser -Filter "GivenName -like 'A*'" -Server "DC300150527-00.local" -Properties Name, SamAccountName |
Select-Object Name, SamAccountName
```

--------------------

## 🚀 Étape 10 – Déplacer un utilisateur vers une OU

<img width="1114" height="487" alt="11" src="https://github.com/user-attachments/assets/f7679599-b016-4e3d-9a14-142507e2884f" />

