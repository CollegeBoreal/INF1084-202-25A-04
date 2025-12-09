# Chemin du dossier partagé (corrigé - doit être un dossier, pas un fichier)
$SharedFolder = "C:\Users\Administrator\Developer\INF1084-202-25A-03\4.OUs\300143951\SharedResources"

# Créer le dossier s'il n'existe pas
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force
    Write-Host "Dossier créé : $SharedFolder" -ForegroundColor Green
}

# Nom du groupe
$GroupName = "Students"

# Créer le groupe AD s'il n'existe pas déjà
try {
    if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
        Write-Host "Groupe AD créé : $GroupName" -ForegroundColor Green
    } else {
        Write-Host "Le groupe $GroupName existe déjà" -ForegroundColor Yellow
    }
} catch {
    Write-Host "Erreur lors de la création du groupe : $_" -ForegroundColor Red
    exit
}

# Créer des utilisateurs AD et les ajouter au groupe
$Users = @("Etudiant1", "Etudiant2")
foreach ($user in $Users) {
    try {
        if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'" -ErrorAction SilentlyContinue)) {
            New-ADUser -Name $user -SamAccountName $user `
                -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
                -Enabled $true `
                -PasswordNeverExpires $false `
                -ChangePasswordAtLogon $true
            Write-Host "Utilisateur créé : $user" -ForegroundColor Green
        } else {
            Write-Host "L'utilisateur $user existe déjà" -ForegroundColor Yellow
        }
        
        # Ajouter au groupe
        Add-ADGroupMember -Identity $GroupName -Members $user -ErrorAction SilentlyContinue
        Write-Host "Utilisateur $user ajouté au groupe $GroupName" -ForegroundColor Green
    } catch {
        Write-Host "Erreur avec l'utilisateur $user : $_" -ForegroundColor Red
    }
}

# Configurer les permissions NTFS
$acl = Get-Acl $SharedFolder
$permission = "$env:USERDOMAIN\$GroupName", "Modify", "ContainerInherit,ObjectInherit", "None", "Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
Set-Acl $SharedFolder $acl
Write-Host "Permissions NTFS configurées" -ForegroundColor Green

# Créer ou mettre à jour le partage SMB
if (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue) {
    Remove-SmbShare -Name "SharedResources" -Force
}
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess "$env:USERDOMAIN\$GroupName"
Write-Host "Partage SMB créé : \\$env:COMPUTERNAME\SharedResources" -ForegroundColor Green