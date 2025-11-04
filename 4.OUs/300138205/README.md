#300138205

0️⃣ Nom du domaine basé sur le numéro étudiant
```powershell
$studentNumber = 300138205
$studentInstance = "00"
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"
```

<details>

  ```powershell

<img width="1208" height="546" alt="image" src="https://github.com/user-attachments/assets/0b34dba4-f76b-4c6d-891b-470050c630ce" />


```

</details>



1️⃣ Préparer l'environnement

```powershell
# Importer le module AD
Import-Module ActiveDirectory
# Définir le nom de domaine
$domainName = "DC300138205-00.local"
# Vérifier le domaine et les DC
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
```

<details>

  ```powershell

<img width="1413" height="680" alt="image" src="https://github.com/user-attachments/assets/c4d307d7-a414-48ae-9e45-b0af503dca22" />



```

</details>

2️⃣ Liste des utilisateurs du domaine
```powershell
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
```

<details>

  ```powershell

<img width="411" height="142" alt="image" src="https://github.com/user-attachments/assets/13f03925-ca81-4481-9d5a-054ab661169f" />



```

</details>


