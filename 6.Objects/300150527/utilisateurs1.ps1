# ============================
# utilisateurs1.ps1
# Création du dossier partagé + groupe + utilisateurs
# ============================

# 0) Variables
$SharedFolder = "C:\SharedResources"
$GroupName = "Students"
$Users = @("Etudiant1", "Etudiant2")

Write-Host "`n===== Étape 1 : Création du dossier partagé ====="

# 1) Création du dossier partagé
if (-Not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force
    Write-Host "Dossier créé : $SharedFolder"
} else {
    Write-Host "Dossier déjà existant : $SharedFolder"
}

Write-Host "`n===== Étape 2 : Création du groupe Students ====="

# 2) Création du groupe AD
if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue)) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
    Write-Host "Groupe créé : $GroupName"
} else {
    Write-Host "Groupe déjà existant : $GroupName"
}

Write-Host "`n===== Étape 3 : Création des utilisateurs ====="

# 3) Création des utilisateurs + ajout au groupe
foreach ($user in $Users) {

    if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'" -ErrorAction SilentlyContinue)) {
        New-ADUser -Name $user `
                    -SamAccountName $user `
                    -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
                    -Enabled $true `
                    -Path "OU=Students,DC=$netbiosName,DC=local"

        Write-Host "Utilisateur créé : $user"
    }
    else {
        Write-Host "Utilisateur déjà existant : $user"
    }

    # Ajouter dans le groupe
    Add-ADGroupMember -Identity $GroupName -Members $user -ErrorAction SilentlyContinue
}

Write-Host "`n===== Étape 4 : Création du partage SMB ====="

# 4) Partager le dossier avec le groupe
if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
    Write-Host "Partage créé : SharedResources"
} else {
    Write-Host "Partage SMB déjà existant : SharedResources"
}

Write-Host "`n===== Étape 5 : Vérification ====="

Write-Host "`n--- Groupe Students ---"
Get-ADGroup -Identity $GroupName

Write-Host "`n--- Membres du groupe Students ---"
Get-ADGroupMember -Identity $GroupName

Write-Host "`n--- Utilisateur Etudiant1 ---"
Get-ADUser -Identity "Etudiant1" | Select Name,SamAccountName,DistinguishedName,Enabled

Write-Host "`n--- Utilisateur Etudiant2 ---"
Get-ADUser -Identity "Etudiant2" | Select Name,SamAccountName,DistinguishedName,Enabled

Write-Host "`n--- Partage SMB ---"
Get-SmbShare -Name "SharedResources"

Write-Host "`n--- Permissions SMB ---"
Get-SmbShareAccess -Name "SharedResources"

Write-Host "`n===== FIN DU SCRIPT =====`n"
