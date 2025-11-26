# utilisateurs1.ps1
# TP : Partage de ressources + RDP

# Chemin du dossier partagé
$SharedFolder = "C:\SharedResources"

# Créer le dossier partagé
New-Item -Path $SharedFolder -ItemType Directory -Force

# Groupe Students
$GroupName = "Students"

# Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Groupe pour partage et RDP"

# Liste des utilisateurs
$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    Add-ADGroupMember -Identity $GroupName -Members $user
}

# Créer le partage SMB
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
