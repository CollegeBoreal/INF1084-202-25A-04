 # Charger la configuration (dot-sourcing)
. .\bootstrap.ps1

# Importer les modules nécessaires
Import-Module ActiveDirectory

Write-Host "`n=== Création du dossier partagé ===" -ForegroundColor Cyan

# Chemin du dossier
$SharedFolder = "C:\SharedResources"

# Créer le dossier
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force
    Write-Host "✓ Dossier créé: $SharedFolder" -ForegroundColor Green
} else {
    Write-Host "⚠ Le dossier existe déjà" -ForegroundColor Yellow
}

Write-Host "`n=== Création du groupe AD ===" -ForegroundColor Cyan

# Nom du groupe
$GroupName = "Students"

# Vérifier si le groupe existe déjà
try {
    $existingGroup = Get-ADGroup -Identity $GroupName -ErrorAction Stop
    Write-Host "⚠ Le groupe $GroupName existe déjà" -ForegroundColor Yellow
} catch {
    # Créer le groupe AD
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
    Write-Host "✓ Groupe créé: $GroupName" -ForegroundColor Green
}

Write-Host "`n=== Création des utilisateurs ===" -ForegroundColor Cyan

# Créer des utilisateurs AD et les ajouter au groupe
$Users = @("Etudiant1", "Etudiant2")
$Password = ConvertTo-SecureString "Pass123!" -AsPlainText -Force

foreach ($user in $Users) {
    try {
        $existingUser = Get-ADUser -Identity $user -ErrorAction Stop
        Write-Host "⚠ L'utilisateur $user existe déjà" -ForegroundColor Yellow
    } catch {
        New-ADUser -Name $user `
                   -SamAccountName $user `
                   -AccountPassword $Password `
                   -Enabled $true `
                   -PasswordNeverExpires $true
        Write-Host "✓ Utilisateur créé: $user" -ForegroundColor Green
    }
    
    # Ajouter au groupe
    Add-ADGroupMember -Identity $GroupName -Members $user -ErrorAction SilentlyContinue
    Write-Host "✓ $user ajouté au groupe $GroupName" -ForegroundColor Green
}

Write-Host "`n=== Création du partage SMB ===" -ForegroundColor Cyan

# Vérifier si le partage existe
$existingShare = Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue

if ($existingShare) {
    Write-Host "⚠ Le partage existe déjà" -ForegroundColor Yellow
    Remove-SmbShare -Name "SharedResources" -Force
}

# Partager le dossier avec le groupe
New-SmbShare -Name "SharedResources" `
             -Path $SharedFolder `
             -FullAccess "$netbiosName\$GroupName"

Write-Host "✓ Partage créé: \\$netbiosName\SharedResources" -ForegroundColor Green
Write-Host "`n=== Script utilisateurs1.ps1 terminé ===" -ForegroundColor Green