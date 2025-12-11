📘 Gestion des Utilisateurs Active Directory

Étudiant : 300151833 – Raouf Bouras
Serveur : DC300151833
Domaine : DC300151833.local

🎯 Objectif de l’exercice

Cet exercice a pour but de mettre en pratique les commandes PowerShell d’administration Active Directory pour :

Vérifier le domaine et le contrôleur AD

Lister les utilisateurs

Créer une OU

Créer un utilisateur

Vérifier ses attributs

Activer / désactiver un compte

Filtrer les utilisateurs

Vérifier l’emplacement de l’utilisateur dans l’OU

🟦 1️⃣ Vérification du domaine Active Directory
🔹 Commande utilisée
Get-ADDomain


Cette commande permet d’afficher les informations essentielles du domaine :

DNSRoot

DistinguishedName

SID

Conteneurs AD

Rôles FSMO

<img width="1671" height="864" alt="01" src="https://github.com/user-attachments/assets/5a5c0034-53fd-4fc0-97a6-a5268f57ac97" />

🟦 2️⃣ Lister tous les utilisateurs du domaine
🔹 Commande utilisée
Get-ADUser -Filter *


Cette commande affiche tous les comptes utilisateurs existants dans l’AD.

<img width="1677" height="877" alt="02" src="https://github.com/user-attachments/assets/f82b71c2-c14e-4e1f-9dd1-4826903375dd" />


🟦 3️⃣ Création de l’OU "Students" (si non existante)
🔹 Commande utilisée
New-ADOrganizationalUnit -Name "Students" -Path "DC=DC300151833,DC=local"


Cette OU servira à organiser les étudiants.

<img width="1679" height="882" alt="03" src="https://github.com/user-attachments/assets/1c5a3482-8462-4567-be1d-700121d91787" />


🟦 4️⃣ Création de l’utilisateur Alice Dupont
🔹 Commande utilisée
New-ADUser `
-Name "Alice Dupont" `
-GivenName "Alice-Marie" `
-Surname "Dupont" `
-SamAccountName "alice.dupont" `
-UserPrincipalName "alice.dupont@DC300151833.local" `
-Path "OU=Students,DC=DC300151833,DC=local" `
-AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
-Enabled $true


L’utilisateur est créé directement dans l’OU Students.

<img width="1681" height="879" alt="04" src="https://github.com/user-attachments/assets/551403f5-5494-40e4-80fb-66a0fa493f30" />


🟦 5️⃣ Vérification de la création du compte
🔹 Commande utilisée
Get-ADUser -Identity "alice.dupont" -Properties Name,SamAccountName,UserPrincipalName


Cette commande confirme :

Le nom du compte

Le SamAccountName

Le UserPrincipalName

Le bon emplacement LDAP

<img width="1214" height="411" alt="06" src="https://github.com/user-attachments/assets/2c8e05bd-2714-4d3a-ab48-da2912d7e5d5" />


🟦 6️⃣ Vérifier l’état du compte (Enabled)
🔹 Commande utilisée
Get-ADUser -Identity "alice.dupont" -Properties Enabled | Select-Object Name, Enabled


<img width="1214" height="411" alt="06" src="https://github.com/user-attachments/assets/8c0e64e7-eab7-4907-87c4-19c5dbb360de" />


🟦 7️⃣ Désactivation du compte d’Alice Dupont
🔹 Commande utilisée
Disable-ADAccount -Identity "alice.dupont"

🟦 8️⃣ Vérification de la désactivation
🔹 Commande
Get-ADUser -Identity "alice.dupont" -Properties Enabled | Select-Object Name, Enabled


Le résultat doit afficher :
Enabled = False

<img width="1249" height="275" alt="07" src="https://github.com/user-attachments/assets/e3f10d65-cdb7-4d2d-aab0-6ab64c322985" />


🟦 9️⃣ Réactivation du compte
🔹 Commande utilisée
Enable-ADAccount -Identity "alice.dupont"

🟦 🔟 Vérification de la réactivation
🔹 Commande utilisée
Get-ADUser -Identity "alice.dupont" -Properties Enabled | Select-Object Name, Enabled


Le résultat doit afficher :
Enabled = True

<img width="1255" height="166" alt="08" src="https://github.com/user-attachments/assets/77df03d5-cf1d-461b-bcfa-ad281020051a" />


🟦 1️⃣1️⃣ Recherche d’utilisateurs dont le prénom commence par A
🔹 Commande utilisée
Get-ADUser -Filter "GivenName -like 'A*'" | Select-Object Name, SamAccountName


Cette commande montre comment filtrer les objets AD selon un attribut.

<img width="1157" height="179" alt="09" src="https://github.com/user-attachments/assets/794abe3c-37ea-4c65-bfcf-e215cc3a9b24" />


🟦 1️⃣2️⃣ Vérifier qu’Alice se trouve bien dans l’OU Students
🔹 Commande utilisée
Get-ADUser "alice.dupont" | Select-Object Name, DistinguishedName


Le résultat attendu :

OU=Students,DC=DC300151833,DC=local


<img width="1067" height="173" alt="10" src="https://github.com/user-attachments/assets/376b5541-c8d9-45d5-b844-a251c03d483e" />


🏁 Conclusion

Dans cet exercice, j’ai réalisé toutes les opérations essentielles de gestion des utilisateurs Active Directory via PowerShell :

Vérification du domaine et des DC

Lister et filtrer les comptes utilisateurs

Créer une OU et un utilisateur complet

Manipuler l’état du compte (activer/désactiver)

Vérifier les attributs de l’utilisateur

Confirmer son emplacement LDAP dans l’OU

Ces manipulations démontrent la compréhension du fonctionnement d’Active Directory et des commandes PowerShell associées.
