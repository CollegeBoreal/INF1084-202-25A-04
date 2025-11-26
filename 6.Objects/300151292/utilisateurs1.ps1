# utilisateurs1.ps1
# TP 6.Objects - Création du dossier partagé + groupe + utilisateurs

# Chemin du dossier partagé
$SharedFolder = "C:\SharedResources"

# Créer le dossier partagé
New-Item -Path $SharedFolder -ItemType Directory -Force

# Nom du groupe
$GroupName = "Students"

# Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# Liste des utilisateurs à créer
$Users = @("Etudiant1", "Etudiant2")

foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    # Ajouter au groupe Students
    Add-ADGroupMember -Identity $GroupName -Members $user
}

# Partager le dossier avec le groupe Students
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
