300141368





```powershell

Import-Module ActiveDirectory

\# Chemin du dossier

$SharedFolder = "C:\\SharedResources"



\# Créer le dossier

New-Item -Path $SharedFolder -ItemType Directory -Force



\# Créer un partage SMB pour le groupe Students

$GroupName = "Students"



\# Créer le groupe AD

New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"



\# Créer des utilisateurs AD et les ajouter au groupe

$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {

&nbsp;   New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true

&nbsp;   Add-ADGroupMember -Identity $GroupName -Members $user

}



\# Partager le dossier avec le groupe

New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

```







```powershell

Import-Module GroupPolicy

\# Chemin du dossier

$SharedFolder = "C:\\SharedResources"



\# Créer le dossier

New-Item -Path $SharedFolder -ItemType Directory -Force



\# Créer un partage SMB pour le groupe Students

$GroupName = "Students"



\# Créer le groupe AD

New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"



\# Créer des utilisateurs AD et les ajouter au groupe

$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {

&nbsp;   New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true

&nbsp;   Add-ADGroupMember -Identity $GroupName -Members $user

}



\# Partager le dossier avec le groupe

New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

```





<img src="images/1.jpg" alt="Girl in a jacket" width="500" height="600">

