#300147786
- [ ] j'ai ajouté toutes les photos dans images
##
1️⃣ Préparer l’environnement

Importer le module Active Directory

Import-Module ActiveDirectory


Vérifier le domaine et les contrôleurs de domaine

Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName


<img width="845" height="486" alt="1" src="https://github.com/user-attachments/assets/598dcec7-61c6-4a37-832c-8f03bdb12e14" />


2️⃣ Liste des utilisateurs du domaine
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName


Capture : [CAPTURE_USERS_LIST]

3️⃣ Créer un nouvel utilisateur
New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=DC300147786-00,DC=local" `
           -Credential $cred


Capture : [CAPTURE_CREATE_USER]

4️⃣ Modifier l’utilisateur
Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Credential $cred


Vérification :

Get-ADUser -Identity "alice.dupont" -Properties GivenName, EmailAddress, Name |
Select-Object Name, GivenName, EmailAddress


Capture : [CAPTURE_MODIFY_USER]

5️⃣ Désactiver l’utilisateur
Disable-ADAccount -Identity "alice.dupont" -Credential $cred


Vérification :

Get-ADUser -Identity "alice.dupont" -Properties Enabled |
Select-Object SamAccountName, Enabled


Capture : [CAPTURE_DISABLE_USER]

6️⃣ Réactiver l’utilisateur
Enable-ADAccount -Identity "alice.dupont" -Credential $cred


Vérification :

Get-ADUser -Identity "alice.dupont" -Properties Enabled |
Select-Object SamAccountName, Enabled


Capture : [CAPTURE_ENABLE_USER]

7️⃣ Supprimer l’utilisateur
Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred


Vérification :

Get-ADUser -Identity "alice.dupont"


Capture : [CAPTURE_DELETE_USER]

8️⃣ Rechercher des utilisateurs avec un filtre
Get-ADUser -Filter "GivenName -like 'A*'" -Properties Name, SamAccountName |
Select-Object Name, SamAccountName


Capture : [CAPTURE_FILTER_USERS]

9️⃣ Exporter les utilisateurs dans un CSV
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8


Vérification :

Import-Csv "TP_AD_Users.csv" | Format-Table -AutoSize


Capture : [CAPTURE_EXPORT_CSV]

🔟 Déplacer un utilisateur vers l’OU Students
1. Créer l’OU si elle n’existe pas
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=DC300147786-00,DC=local"
}

2. Déplacer l’utilisateur depuis CN=Users
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=DC300147786-00,DC=local" `
              -TargetPath "OU=Students,DC=DC300147786-00,DC=local" `
              -Credential $cred

3. Vérifier le déplacement
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName


Capture : [CAPTURE_MOVE_USER]


