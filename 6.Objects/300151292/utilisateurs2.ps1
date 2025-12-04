###############################################
# TP Active Directory – GPO Map Lecteur Réseau
# Étudiant : 300151292
# Script : utilisateurs2.ps1
###############################################

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Vérifier si la GPO existe
$gpo = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $gpo) {
    $gpo = New-GPO -Name $GPOName
}

# OU cible
$OU = "OU=Students,DC=DC300151292-00,DC=local"

# Lier la GPO à l’OU Students
try {
    New-GPLink -Name $GPOName -Target $OU -ErrorAction Stop
}
catch {
    Write-Host "⚠ La GPO était déjà liée à l’OU. Continuité..." -ForegroundColor Yellow
}

# Création du script logon
$DriveLetter = "Z:"
$SharePath = "\\DC300151292-00\SharedResources"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Associer le script logon à la GPO
Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptPath

Write-Host "✔ Fin de utilisateurs2.ps1 — GPO + lecteur Z configurés" -ForegroundColor Green

