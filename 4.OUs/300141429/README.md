

Vérifier le domaine et les DC
powershell
Get-ADDomain
![](images/11.png)

Lister les utilisateurs actifs
powershell
Get-ADUser -Filter * 
![](images/12.png)

Vérifier la création d’un utilisateur
powershell
Get-ADUser -Identity "alice.dupont" -Properties Name, SamAccountName, UserPrincipalName

![](images/13.png)

Vérifier la désactivation
powershell
Get-ADUser -Identity "alice.dupont" -Properties Enabled | Select-Object Name, Enabled
👉 Preuve : Enabled = False.

Vérifier la réactivation
powershell
Get-ADUser -Identity "alice.dupont" -Properties Enabled | Select-Object Name, Enabled
Preuve : Enabled = True.
![](images/14.png)

Vérifier la recherche avec filtre
powershell
Get-ADUser -Filter "GivenName -like 'A*'" | Select-Object Name, SamAccountName
![](images/15.png)

.



