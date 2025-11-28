# 1️⃣ Chemin du dossier partagé
$SharedFolder = "C:\SharedResources"

# Création du dossier si n'existe pas
New-Item -Path $SharedFolder -ItemType Directory -Force

# 2️⃣ Créer un groupe AD "Students"
$GroupName = "Students"
New-ADGroup -Name $GroupName -GroupScope Global -Description "Groupe pour accès partagé et RDP"

# 3️⃣ Créer des utilisateurs et les ajouter au groupe
$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {
    New-ADUser -Name $user `
    -SamAccountName $user `
    -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
    -Enabled $true

    Add-ADGroupMember -Identity $GroupName -Members $user
}

# 4️⃣ Partager le dossier via SMB
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
