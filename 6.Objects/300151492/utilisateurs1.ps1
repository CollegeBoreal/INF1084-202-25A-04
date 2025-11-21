# Charger la configuration (dot-sourcing)
. .\bootstrap.ps1

# Importer les modules necessaires
Import-Module ActiveDirectory

Write-Host "`n=== Creation du dossier partage ===" -ForegroundColor Cyan

# Chemin du dossier
$SharedFolder = "C:\SharedResources"

# Creer le dossier
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force
    Write-Host "Dossier cree: $SharedFolder" -ForegroundColor Green
} else {
    Write-Host "Le dossier existe deja" -ForegroundColor Yellow
}

Write-Host "`n=== Creation du groupe AD ===" -ForegroundColor Cyan

# Nom du groupe
$GroupName = "Students"

# Verifier si le groupe existe deja
try {
    $existingGroup = Get-ADGroup -Identity $GroupName -ErrorAction Stop
    Write-Host "Le groupe $GroupName existe deja" -ForegroundColor Yellow
} catch {
    # Creer le groupe AD
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
    Write-Host "Groupe cree: $GroupName" -ForegroundColor Green
}

Write-Host "`n=== Creation des utilisateurs ===" -ForegroundColor Cyan

# Creer des utilisateurs AD et les ajouter au groupe
$Users = @("Etudiant1", "Etudiant2")
$Password = ConvertTo-SecureString "Pass123!" -AsPlainText -Force

foreach ($user in $Users) {
    try {
        $existingUser = Get-ADUser -Identity $user -ErrorAction Stop
        Write-Host "L'utilisateur $user existe deja" -ForegroundColor Yellow
    } catch {
        New-ADUser -Name $user `
                   -SamAccountName $user `
                   -AccountPassword $Password `
                   -Enabled $true `
                   -PasswordNeverExpires $true
        Write-Host "Utilisateur cree: $user" -ForegroundColor Green
    }
    
    # Ajouter au groupe
    Add-ADGroupMember -Identity $GroupName -Members $user -ErrorAction SilentlyContinue
    Write-Host "$user ajoute au groupe $GroupName" -ForegroundColor Green
}

Write-Host "`n=== Creation du partage SMB ===" -ForegroundColor Cyan

# Verifier si le partage existe
$existingShare = Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue

if ($existingShare) {
    Write-Host "Le partage existe deja" -ForegroundColor Yellow
    Remove-SmbShare -Name "SharedResources" -Force
}

# Partager le dossier avec le groupe
New-SmbShare -Name "SharedResources" `
             -Path $SharedFolder `
             -FullAccess "$netbiosName\$GroupName"

Write-Host "Partage cree: \\$netbiosName\SharedResources" -ForegroundColor Green
Write-Host "`n=== Script utilisateurs1.ps1 termine ===" -ForegroundColor Green
