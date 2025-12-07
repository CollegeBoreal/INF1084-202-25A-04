
- [ ] Mamadou Abdoulaye Diallo -300147786


1️⃣ Préparer l’environnement

Importer le module Active Directory
Import-Module ActiveDirectory
Vérifier le domaine et les contrôleurs de domaine
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

<img width="845" height="486" alt="1" src="https://github.com/user-attachments/assets/4e746c17-17a5-429d-896b-f4c9243392bc" />

2️⃣ Liste des utilisateurs du domaine
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object ( $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt")  |
Select-Object Name, SamAccountName

<img width="821" height="175" alt="2" src="https://github.com/user-attachments/assets/ffe6bd69-f00d-44cd-81a8-8e94bb279df1" />

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

<img width="770" height="483" alt="3" src="https://github.com/user-attachments/assets/791fe0ba-4b25-4958-bda3-ca5698f9f774" />

4️⃣ Modifier l’utilisateur
Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Credential $cred
Vérification :

Get-ADUser -Identity "alice.dupont" -Properties GivenName, EmailAddress, Name |
Select-Object Name, GivenName, EmailAddress

<img width="864" height="141" alt="4" src="https://github.com/user-attachments/assets/497585e5-eef1-4805-9857-17e84904c699" />

5️⃣ Désactiver l’utilisateur
Disable-ADAccount -Identity "alice.dupont" -Credential $cred
Vérification :
Get-ADUser -Identity "alice.dupont" -Properties Enabled |
Select-Object SamAccountName, Enabled

<img width="705" height="132" alt="5" src="https://github.com/user-attachments/assets/c6e3fd8b-a2d9-4fe3-a8b6-07ca7f2f5b62" />

6️⃣ Réactiver l’utilisateur
Enable-ADAccount -Identity "alice.dupont" -Credential $cred
Vérification :
Get-ADUser -Identity "alice.dupont" -Properties Enabled |
Select-Object SamAccountName, Enabled

<img width="723" height="127" alt="6" src="https://github.com/user-attachments/assets/a14e57a8-19f1-4f2d-9ce1-b53b60c327a3" />

7️⃣ Supprimer l’utilisateur
Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred
Vérification : Alice Dupont ne fais pas partie de la liste d'utilisateurs.
Get-ADUser -Identity "alice.dupont"

<img width="858" height="490" alt="7  alice dupont fais pas partie de la liste" src="https://github.com/user-attachments/assets/40ad3507-aefd-4324-94bb-60b500f76372" />

8️⃣ Rechercher des utilisateurs avec un filtre
Get-ADUser -Filter "GivenName -like 'A*'" -Properties Name, SamAccountName |
Select-Object Name, SamAccountName

<img width="873" height="150" alt="8" src="https://github.com/user-attachments/assets/c472ecb5-1dcf-4626-a9ba-9446b71d32e1" />

9️⃣ Exporter les utilisateurs dans un CSV
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
Vérification :
Import-Csv "TP_AD_Users.csv" | Format-Table -AutoSize

<img width="845" height="158" alt="9" src="https://github.com/user-attachments/assets/a905382c-1030-4f65-9818-219e1566f49d" />

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

<img width="842" height="129" alt="10 1" src="https://github.com/user-attachments/assets/af0a3e34-6b32-47f0-ae77-51109f2a9b96" />

<img width="722" height="302" alt="10" src="https://github.com/user-attachments/assets/e387f1b6-b914-4f27-9a7b-43b84137a338" />










