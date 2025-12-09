# utilisateurs1.ps1 - Créer dossier partagé, groupe AD et utilisateurs
# Auteur: 300151233

# Charger les informations du domaine
. ..\..\..\4.OUs\300151233\bootstrap.ps1

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  CRÉATION DOSSIER PARTAGÉ ET GROUPE AD" -ForegroundColor Cyan
Write-Host "================================================
" -ForegroundColor Cyan

# Chemin du dossier partagé
$SharedFolder = "C:\SharedResources"

# Créer le dossier
Write-Host "=== Création du dossier partagé ===" -ForegroundColor Yellow
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force | Out-Null
    Write-Host "✓ Dossier créé: $SharedFolder" -ForegroundColor Green
} else {
    Write-Host "⚠ Dossier existe déjà: $SharedFolder" -ForegroundColor Yellow
}

# Nom du groupe
$GroupName = "Students"

# Créer le groupe AD
Write-Host "
=== Création du groupe AD ===" -ForegroundColor Yellow
try {
    New-ADGroup -Name $GroupName `
                -GroupScope Global `
                -Description "Groupe pour accès RDP et dossier partagé" `
                -Server $domainName `
                -Credential $cred `
                -ErrorAction Stop
    Write-Host "✓ Groupe '$GroupName' créé" -ForegroundColor Green
} catch {
    if ($_.Exception.Message -like "*already exists*") {
        Write-Host "⚠ Groupe '$GroupName' existe déjà" -ForegroundColor Yellow
    } else {
        Write-Host "✗ Erreur: $_" -ForegroundColor Red
    }
}

# Créer des utilisateurs et les ajouter au groupe
Write-Host "
=== Création des utilisateurs ===" -ForegroundColor Yellow
$Users = @("Etudiant1", "Etudiant2")

foreach ($user in $Users) {
    try {
        New-ADUser -Name $user `
                   -SamAccountName $user `
                   -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
                   -Enabled $true `
                   -Server $domainName `
                   -Credential $cred `
                   -ErrorAction Stop
        Write-Host "✓ Utilisateur '$user' créé" -ForegroundColor Green
        
        # Ajouter au groupe
        Add-ADGroupMember -Identity $GroupName `
                          -Members $user `
                          -Server $domainName `
                          -Credential $cred
        Write-Host "  → Ajouté au groupe '$GroupName'" -ForegroundColor Cyan
    } catch {
        if ($_.Exception.Message -like "*already exists*") {
            Write-Host "⚠ Utilisateur '$user' existe déjà" -ForegroundColor Yellow
        } else {
            Write-Host "✗ Erreur pour '$user': $_" -ForegroundColor Red
        }
    }
}

# Partager le dossier avec le groupe
Write-Host "
=== Création du partage SMB ===" -ForegroundColor Yellow
try {
    New-SmbShare -Name "SharedResources" `
                 -Path $SharedFolder `
                 -FullAccess $GroupName `
                 -ErrorAction Stop
    Write-Host "✓ Partage SMB créé: \\\\$netbiosName\\SharedResources" -ForegroundColor Green
} catch {
    if ($_.Exception.Message -like "*already exists*") {
        Write-Host "⚠ Partage existe déjà" -ForegroundColor Yellow
    } else {
        Write-Host "✗ Erreur: $_" -ForegroundColor Red
    }
}

# Vérification
Write-Host "
=== Vérification ===" -ForegroundColor Cyan
Write-Host "Groupe Students:" -ForegroundColor White
Get-ADGroupMember -Identity $GroupName -Server $domainName | Select-Object Name, SamAccountName

Write-Host "
Partages SMB:" -ForegroundColor White
Get-SmbShare | Where-Object {$_.Name -eq "SharedResources"} | Format-Table Name, Path, Description -AutoSize

Write-Host "
✓ Configuration terminée!" -ForegroundColor Green
