
🔑 Commandes de preuves pour ton TP Active Directory
1️⃣ Vérifier le domaine et les DC
powershell
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
👉 Preuve : tu dois voir ton domaine DC300098957-40.local et le contrôleur de domaine.

2️⃣ Lister les utilisateurs actifs
powershell
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
👉 Preuve : liste des utilisateurs créés (hors comptes par défaut).

3️⃣ Vérifier la création d’un utilisateur
powershell
Get-ADUser -Identity "alice.dupont" -Properties Name, SamAccountName, UserPrincipalName
👉 Preuve : l’utilisateur existe avec son UPN alice.dupont@DC300098957-40.local.

4️⃣ Vérifier la modification d’un utilisateur
powershell
Get-ADUser -Identity "alice.dupont" -Properties GivenName, EmailAddress
👉 Preuve : tu dois voir GivenName = Alice-Marie et l’email mis à jour.

5️⃣ Vérifier la désactivation
powershell
Get-ADUser -Identity "alice.dupont" -Properties Enabled | Select-Object Name, Enabled
👉 Preuve : Enabled = False.

6️⃣ Vérifier la réactivation
powershell
Get-ADUser -Identity "alice.dupont" -Properties Enabled | Select-Object Name, Enabled
👉 Preuve : Enabled = True.

7️⃣ Vérifier la suppression
powershell
Get-ADUser -Identity "alice.dupont"
👉 Preuve : doit retourner une erreur car l’utilisateur n’existe plus.

8️⃣ Vérifier la recherche avec filtre
powershell
Get-ADUser -Filter "GivenName -like 'A*'" | Select-Object Name, SamAccountName
👉 Preuve : liste des utilisateurs dont le prénom commence par "A".

9️⃣ Vérifier l’export CSV
powershell
Get-Content TP_AD_Users.csv | more
👉 Preuve : le fichier CSV contient les utilisateurs avec leurs propriétés.

🔟 Vérifier le déplacement vers l’OU Students
powershell
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName
👉 Preuve : le champ DistinguishedName doit montrer OU=Students,....

