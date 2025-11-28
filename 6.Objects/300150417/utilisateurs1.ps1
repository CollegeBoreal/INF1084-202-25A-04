# TP Active Directory - Creation du partage SMB et des objets AD
# Etudiant : Abdelatif Nemous (300150417)

# Dossier partage
$SharedFolder = "C:\SharedResources"

New-Item -Path $SharedFolder -ItemType Directory -Force

# Groupe AD
$GroupName = "Students"
New-ADGroup -Name $GroupName -GroupScope Global -Description "Groupe des etudiants ayant acces au partage"

# Création des utilisateurs
$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true
                
    Add-ADGroupMember -Identity $GroupName -Members $user
}

# Partage SMB
New-SmbShare -Name "SharedResources" `
             -Path $SharedFolder `
             -FullAccess $GroupName, "Administrator"
