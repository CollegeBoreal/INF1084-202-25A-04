# Récupérer le NetBIOS du domaine
$netbiosName = (Get-ADDomain).NetBIOSName

# Nom de la GPO
$GPOName = "MapSharedFolder"

Write-Host "Création/Vérification de la GPO $GPOName..." -ForegroundColor Cyan

# Vérifier si la GPO existe déjà
$ExistingGPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if ($ExistingGPO) {
    Write-Host "La GPO $GPOName existe déjà."
} else {
    New-GPO -Name $GPOName | Out-Null
    Write-Host "GPO $GPOName créée."
}

# Lier la GPO à l’OU Students
$OU = "OU=Students,DC=$netbiosName,DC=local"
Write-Host "Liaison de la GPO à l'OU $OU..." -ForegroundColor Cyan

New-GPLink -Name $GPOName -Target $OU -ErrorAction SilentlyContinue

# Mapping Drive Settings
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

# Créer le dossier Scripts si nécessaire
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
    Write-Host "Dossier C:\Scripts créé."
}

# Contenu du script
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

Write-Host "Script de mapping $DriveLetter créé : $ScriptPath"

# Ajouter le script comme logon script dans la GPO
Write-Host "Application du script dans la GPO..." -ForegroundColor Cyan

Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptPath

Write-Host "Le script de logon a été ajouté à la GPO." -ForegroundColor Green
