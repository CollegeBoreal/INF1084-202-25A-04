# Charger le script utilisateurs0
. .\utilisateurs0.ps1

# Chemin du dossier
$SharedFolder = "C:\SharedResources"

# 1. Créer le dossier si absent
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory | Out-Null
    Write-Host "Dossier $SharedFolder créé."
} else {
    Write-Host "Dossier $SharedFolder existe déjà."
}

# 2. Groupe AD 'Students'
$GroupName = "Students"

if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue)) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
    Write-Host "Groupe $GroupName créé."
} else {
    Write-Host "Groupe $GroupName existe déjà."
}

# 3. Créer des utilisateurs et les ajouter au groupe
$Users = @("Etudiant1", "Etudiant2")

foreach ($user in $Users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'" -ErrorAction SilentlyContinue)) {
        New-ADUser -Name $user -SamAccountName $user `
            -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
            -Enabled $true
        Write-Host "Utilisateur $user créé."
    } else {
        Write-Host "Utilisateur $user existe déjà."
    }

    # Ajouter au groupe (même si déjà créé, ne crash pas)
    try {
        Add-ADGroupMember -Identity $GroupName -Members $user -ErrorAction Stop
        Write-Host "$user ajouté au groupe $GroupName."
    } catch {
        Write-Host "$user est déjà membre du groupe $GroupName."
    }
}

# 4. Partage SMB
if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
    Write-Host "Partage SMB 'SharedResources' créé."
} else {
    Write-Host "Le partage SMB 'SharedResources' existe déjà."
}
