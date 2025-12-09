Import-Module ActiveDirectory

# 1. Créer le dossier partagé
$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force

# 2. Créer le groupe AD
$GroupName = "Students"
if (-not (Get-ADGroup -Filter {Name -eq $GroupName})) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
}

# 3. Créer des utilisateurs AD et les ajouter au groupe
$Users = @("Etudiant1","Etudiant2")
foreach ($user in $Users) {
    if (-not (Get-ADUser -Filter {SamAccountName -eq $user})) {
        New-ADUser -Name $user `
                   -SamAccountName $user `
                   -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
                   -Enabled $true `
                   -Path "OU=Students,DC=DC300141429,DC=local"
    }
    Add-ADGroupMember -Identity $GroupName -Members $user
}

# 4. Créer un partage SMB pour le groupe
if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
}
Write-Host "✅ Utilisateurs, groupe et partage SMB créés avec succès."

