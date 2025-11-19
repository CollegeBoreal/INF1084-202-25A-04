# Charger la configuration
. .\bootstrap.ps1

# Importer les modules
Import-Module ActiveDirectory
Import-Module GroupPolicy

Write-Host "`n=== Création de la GPO ===" -ForegroundColor Cyan

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Vérifier si la GPO existe
$existingGPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue

if ($existingGPO) {
    Write-Host "⚠ La GPO existe déjà" -ForegroundColor Yellow
} else {
    # Créer la GPO
    New-GPO -Name $GPOName
    Write-Host "✓ GPO créée: $GPOName" -ForegroundColor Green
}

# Lier la GPO à une OU spécifique
$OU = "OU=Students,$domainDN"

Write-Host "Liaison de la GPO à: $OU" -ForegroundColor Yellow

try {
    # Vérifier si l'OU existe
    Get-ADOrganizationalUnit -Identity $OU -ErrorAction Stop
    
    # Vérifier si le lien existe déjà
    $existingLink = Get-GPInheritance -Target $OU | 
                    Select-Object -ExpandProperty GpoLinks | 
                    Where-Object { $_.DisplayName -eq $GPOName }
    
    if (-not $existingLink) {
        New-GPLink -Name $GPOName -Target $OU
        Write-Host "✓ GPO liée à l'OU" -ForegroundColor Green
    } else {
        Write-Host "⚠ Le lien GPO existe déjà" -ForegroundColor Yellow
    }
} catch {
    Write-Host "⚠ L'OU n'existe pas, création..." -ForegroundColor Yellow
    New-ADOrganizationalUnit -Name "Students" -Path $domainDN
    Write-Host "✓ OU créée" -ForegroundColor Green
    
    New-GPLink -Name $GPOName -Target $OU
    Write-Host "✓ GPO liée" -ForegroundColor Green
}

Write-Host "`n=== Création du script de mapping ===" -ForegroundColor Cyan

# Variables pour le mapping
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-Z.bat"

# Créer le dossier Scripts
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
    Write-Host "✓ Dossier Scripts créé" -ForegroundColor Green
}

# Créer le script de mapping
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent
Write-Host "✓ Script créé: $ScriptPath" -ForegroundColor Green

Write-Host "`n=== Configuration du script de logon dans la GPO ===" -ForegroundColor Cyan

Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath

Write-Host "✓ Script de logon configuré" -ForegroundColor Green
Write-Host "`n=== Script utilisateurs2.ps1 terminé ===" -ForegroundColor Green