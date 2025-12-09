# TP Objects AD - Étape 2 : Créer une GPO pour mapper le lecteur réseau
# Étudiant : 300150296

# Charger le bootstrap
. .\utilisateurs0.ps1

Import-Module GroupPolicy

Write-Host "`n=== Création de la GPO ===" -ForegroundColor Green

$GPOName = "MapSharedFolder_300150296"

try {
    New-GPO -Name $GPOName -Server $domainName
    Write-Host "GPO créée : $GPOName" -ForegroundColor Cyan
} catch {
    Write-Host "La GPO existe déjà" -ForegroundColor Yellow
}

Write-Host "`n=== Liaison de la GPO ===" -ForegroundColor Green

$OU = "OU=Students,DC=$netbiosName,DC=local"
try {
    New-GPLink -Name $GPOName -Target $OU -LinkEnabled Yes -Server $domainName
    Write-Host "GPO liée à : $OU" -ForegroundColor Cyan
} catch {
    Write-Host "La liaison existe déjà" -ForegroundColor Yellow
}

Write-Host "`n=== Création du script de mappage ===" -ForegroundColor Green

$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"

$ScriptFolder = "C:\Scripts"
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

$ScriptPath = "$ScriptFolder\MapDrive.bat"
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

Write-Host "`n✅ Configuration terminée" -ForegroundColor Green