# ============================
# Script utilisateurs1.ps1
# ============================

. .\bootstrap.ps1
Write-Output "Bootstrap chargé avec succès."

# Chemin du dossier
$SharedFolder = "C:\SharedResources"

Write-Output "Création du dossier partagé : $SharedFolder"
New-Item -Path $SharedFolder -ItemType Directory -Force | Out-Null

# Groupe AD
$GroupName = "Students"
Write-Output "Création du groupe AD : $GroupName"
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# Création des utilisateurs
$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {
    Write-Output "Création du compte AD : $user"
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    Write-Output "Ajout de $user au groupe $GroupName"
    Add-ADGroupMember -Identity $GroupName -Members $user
}

# PARTAGE SMB
Write-Output "Création du partage SMB SharedResources"
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

# Configuration des permissions NTFS pour le groupe Students
Write-Output "Configuration des permissions NTFS"
$acl = Get-Acl $SharedFolder
$permission = "$netbiosName\$GroupName", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
Set-Acl $SharedFolder $acl

# Ajouter "Everyone" pour faciliter l'accès (optionnel pour lab)
Grant-SmbShareAccess -Name "SharedResources" -AccountName "Everyone" -AccessRight Full -Force | Out-Null

Write-Output "Script utilisateurs1.ps1 terminé avec succès."