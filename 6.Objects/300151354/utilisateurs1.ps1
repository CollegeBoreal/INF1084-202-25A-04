# ==============================
# utilisateurs1.ps1
# Création dossier partagé + groupe Students + utilisateurs
# ==============================

. "$PSScriptRoot\bootstrap.ps1"

Write-Host "`n=== Création du dossier partagé ===`n"

$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force

Write-Host "Dossier créé : $SharedFolder"

# ==============================
# Groupe Students
# ==============================

$GroupName = "Students"

Write-Host "`n=== Création du groupe $GroupName ===`n"

New-ADGroup -Name $GroupName `
            -GroupScope Global `
            -Description "Users allowed RDP and shared folder access" `
            -Credential $cred

# ==============================
# Création des utilisateurs
# ==============================

$Users = @("Etudiant1", "Etudiant2")

Write-Host "`n=== Création des utilisateurs AD ===`n"

foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true `
               -Credential $cred

    Add-ADGroupMember -Identity $GroupName -Members $user -Credential $cred

    Write-Host "Utilisateur créé et ajouté au groupe : $user"
}

# ==============================
# Partage SMB
# ==============================

Write-Host "`n=== Création du partage SMB ===`n"

New-SmbShare -Name "SharedResources" `
             -Path $SharedFolder `
             -FullAccess $GroupName

Write-Host "Partage SMB créé : \\$netbiosName\SharedResources"

