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

<img width="1209" height="546" alt="Capture d’écran 2025-11-04 154824" src="https://github.com/user-attachments/assets/ea9ebe2c-23cc-4549-a47f-24f599554fff" />



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

<img width="1414" height="680" alt="Capture d’écran 2025-11-04 155934" src="https://github.com/user-attachments/assets/11f911f7-8a98-46eb-8a12-a16aa15118cc" />




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

<img width="411" height="142" alt="Capture d’écran 2025-11-04 162037" src="https://github.com/user-attachments/assets/a41b6bf3-8565-4213-a337-a3bf45b58b4e" />




```

</details>


