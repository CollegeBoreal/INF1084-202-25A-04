# Chemin du dossier partagé
$SharedFolder = "C:\SharedResources"

# Créer le dossier partagé
New-Item -Path $SharedFolder -ItemType Directory -Force

# Nom du groupe
$GroupName = "Students"

# Créer le groupe
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and Shared Folder access"

# Créer des utilisateurs
$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {
    New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity $GroupName -Members $user
}

# Partager le dossier aux Students
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
