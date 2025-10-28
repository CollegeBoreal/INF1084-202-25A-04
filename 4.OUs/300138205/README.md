# 300138205

# 0️⃣ Nom du domaine basé sur le numéro étudiant

```powershell
$studentNumber = 300138205
$studentInstance = 00

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"
```

<details>

  <img width="1677" height="778" alt="Capture d’écran 2025-10-28 145612" src="https://github.com/user-attachments/assets/447a555c-46d3-4cde-b4b7-f07dac50677c" />


</details>

# 1️⃣ Préparer l'environnement

```powershell
# Importer le module AD
Import-Module ActiveDirectory

# Vérifier le domaine et les DC
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
```

<details>

  <img width="1692" height="872" alt="image" src="https://github.com/user-attachments/assets/eb3bbd0b-5714-4610-8862-ff3ac486e0fd" />

<img width="1501" height="603" alt="image" src="https://github.com/user-attachments/assets/73da0c7c-a7b0-49b9-8a34-6728198ceae3" />

</details>

# 2️⃣ Liste des utilisateurs du domaine

```powershell
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
```

<details>

  
</details>



