# utilisateurs2.ps1 - Créer GPO pour mapper le lecteur réseau
# Auteur: 300151233

# Charger les informations du domaine
. ..\..\..\4.OUs\300151233\bootstrap.ps1

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  CRÉATION GPO POUR MAPPER LECTEUR RÉSEAU" -ForegroundColor Cyan
Write-Host "================================================
" -ForegroundColor Cyan

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer la GPO
Write-Host "=== Création de la GPO ===" -ForegroundColor Yellow
try {
    New-GPO -Name $GPOName -ErrorAction Stop | Out-Null
    Write-Host "✓ GPO '$GPOName' créée" -ForegroundColor Green
} catch {
    if ($_.Exception.Message -like "*already exists*") {
        Write-Host "⚠ GPO '$GPOName' existe déjà" -ForegroundColor Yellow
    } else {
        Write-Host "✗ Erreur: $_" -ForegroundColor Red
    }
}

# Lier la GPO à l'OU Students
$OU = "OU=Students,$((Get-ADDomain -Server $domainName).DistinguishedName)"

Write-Host "
=== Liaison de la GPO à l'OU Students ===" -ForegroundColor Yellow
try {
    New-GPLink -Name $GPOName -Target $OU -ErrorAction Stop | Out-Null
    Write-Host "✓ GPO liée à: $OU" -ForegroundColor Green
} catch {
    if ($_.Exception.Message -like "*already linked*") {
        Write-Host "⚠ GPO déjà liée à l'OU" -ForegroundColor Yellow
    } else {
        Write-Host "✗ Erreur: $_" -ForegroundColor Red
    }
}

# Créer un script de mappage de lecteur
$DriveLetter = "Z:"
$SharePath = "\\\\$netbiosName\\SharedResources"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-Z.bat"

Write-Host "
=== Création du script de mappage ===" -ForegroundColor Yellow
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
    Write-Host "✓ Dossier créé: $ScriptFolder" -ForegroundColor Green
}

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent
Write-Host "✓ Script créé: $ScriptPath" -ForegroundColor Green
Write-Host "  Commande: $scriptContent" -ForegroundColor Cyan

Write-Host "
=== Résumé ===" -ForegroundColor Cyan
Write-Host "GPO créée: $GPOName" -ForegroundColor White
Write-Host "OU cible: $OU" -ForegroundColor White
Write-Host "Lecteur: $DriveLetter → $SharePath" -ForegroundColor White

Write-Host "
✓ Configuration GPO terminée!" -ForegroundColor Green
