🌐 Gestion AD, Partage de ressources et RDP via PowerShell

Ce laboratoire avait pour objectif de :

Créer un dossier partagé accessible aux étudiants

Créer un groupe Active Directory (Students)

Créer des utilisateurs AD (Etudiant1, Etudiant2)

Configurer une GPO permettant l’accès RDP

Donner le droit “Allow log on through Remote Desktop Services”

Donner l’accès au groupe Students dans “Remote Desktop Users”

Tester la connexion RDP avec un utilisateur non-admin

🔹 1. Création du dossier partagé

Commande PowerShell utilisée :

$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force

New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess Students


![wait](https://github.com/user-attachments/assets/2687718e-196f-4e2c-a3ae-54df5014654f)


🔹 2. Création du groupe Students
New-ADGroup -Name "Students" -GroupScope Global -Description "Users allowed RDP and shared folder access"


![wait](https://github.com/user-attachments/assets/dc307eb7-b34a-4ec8-8310-5b4a23cc55a0)


🔹 3. Création des utilisateurs AD
$Users = @("Etudiant1","Etudiant2")
foreach ($user in $Users) {
    New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
}


![wait](https://github.com/user-attachments/assets/6cfaf1fc-665e-46c1-9149-a929b2fda813)


🔹 4. Ajout des utilisateurs au groupe Students
Add-ADGroupMember -Identity "Students" -Members "Etudiant1","Etudiant2"
Get-ADGroupMember Students

![wait](https://github.com/user-attachments/assets/870888a8-0129-44b4-b0a1-e5731fac866f)


🔹 5. Création et validation de la GPO RDP

GPO créée : RDP access students
Paramètre configuré :

Allow log on through Remote Desktop Services → Students

![wait](https://github.com/user-attachments/assets/01cf7e18-baa7-4368-8831-48a8c217a563)


🔹 6. Vérification du droit RDP (secedit)
secedit /export /cfg C:\verify.cfg


Dans verify.cfg :

SeRemoteInteractiveLogonRight = Students


![wait](https://github.com/user-attachments/assets/7148f218-51a4-4647-90df-0d6e886ebf76)


🔹 7. Ajout du groupe Students au groupe local RDP
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "Students"
Get-LocalGroupMember "Remote Desktop Users"


![wait](https://github.com/user-attachments/assets/169508dc-780c-4180-ad33-750fd1687675)


🔹 8. Test RDP

Connexion réussie avec :

Utilisateur : Etudiant1

Mot de passe : Pass123!

![wait](https://github.com/user-attachments/assets/d5dd5433-1572-4ebf-a8f7-13e5a2679dce)




 
