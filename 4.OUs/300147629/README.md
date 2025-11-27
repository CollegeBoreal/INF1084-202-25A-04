#Vérification du domaine et les DC powershell Get-ADDomain

<img width="1305" height="702" alt="Verification du DC png" src="https://github.com/user-attachments/assets/d65b1d99-0937-47c0-9356-354ac40bf46d" />

#Listons  les utilisateurs actifs powershell Get-ADUser -Filter *
<img width="770" height="605" alt="verication get_user png" src="https://github.com/user-attachments/assets/e26996f1-c2e8-4503-93e5-0a03186c1b7c" />

#Vérification de la création un utilisateur powershell Get-ADUser -Identity "alice.dupont" -Properties Name, SamAccountName, UserPrincipalName
<img width="861" height="272" alt="V-user png" src="https://github.com/user-attachments/assets/c2bc5ea0-252b-462b-8ad2-56b547cdde19" />

#Vérification de  la désactivation powershell Get-ADUser -Identity "alice.dupont" -Properties Enabled | Select-Object Name, Enabled 👉 Preuve : Enabled = False.
<img width="942" height="172" alt="V_users png" src="https://github.com/user-attachments/assets/e7efc714-e9a7-40ce-b437-66e447d4460a" />

#Vérifications de la recherche avec filtre powershell Get-ADUser -Filter "GivenName -like 'A*'" | Select-Object Name, SamAccountName
