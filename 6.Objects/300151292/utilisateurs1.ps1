###############################################
# TP Active Directory – Partage + Users + Groupe
# Étudiant : 300151292
# Script : utilisateurs1.ps1
###############################################

# Chemin du dossier partagé
$SharedFolder = "C:\SharedResources"

# Créer le dossier s'il n'existe pas
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force
}

# Nom du groupe AD
$GroupName = "Students"

# Créer le groupe Students s’il n’existe pas
if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'")) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
}

# Création des utilisateurs
$Users = @("Etudiant1", "Etudiant2")

foreach ($user in $Users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'")) {
        New-ADUser -Name $user `
            -SamAccountName $user `
            -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
            -Enabled $true
        Add-ADGroupMember -Identity $GroupName -Members $user
    }
}

# Créer le partage SMB s'il n'existe pas
if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
}

Write-Host "✔ Fin de utilisateurs1.ps1 — dossier, users, groupe, SMB OK" -ForegroundColor Green


