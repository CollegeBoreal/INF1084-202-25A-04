# Définir le groupe
$GroupName = "Students"

# Créer le dossier partagé
$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force | Out-Null

# Vérifier si le groupe existe déjà
if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue)) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
    Write-Host "Groupe $GroupName créé."
} else {
    Write-Host "Groupe $GroupName existe déjà."
}

# Liste des utilisateurs
$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {

    # Vérifier si l'utilisateur existe
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'" -ErrorAction SilentlyContinue)) {

        New-ADUser -Name $user -SamAccountName $user `
            -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
            -Enabled $true

        Write-Host "Utilisateur $user créé."
    }
    else {
        Write-Host "Utilisateur $user existe déjà."
    }

    # Ajouter au groupe (Safe)
    Add-ADGroupMember -Identity $GroupName -Members $user -ErrorAction SilentlyContinue
    Write-Host "Utilisateur $user ajouté au groupe $GroupName."
}

# Créer le partage SMB si pas déjà créé
if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
    Write-Host "Partage SMB SharedResources créé."
}
else {
    Write-Host "Partage SharedResources existe déjà."
}
