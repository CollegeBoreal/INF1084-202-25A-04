# ==========================================
# Script : utilisateurs2.ps1
# Objectif : Créer une GPO et un script
#            de logon pour mapper le lecteur Z:
# ==========================================

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer la GPO
$gpo = New-GPO -Name $GPOName -ErrorAction SilentlyContinue

# Lier la GPO à l’OU Students
$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU

# Variables du lecteur réseau
$DriveLetter = "Z:"
$SharePath   = "\\$netbiosName\SharedResources"

# Chemin du script local
$LocalScriptFolder = "C:\Scripts"
$LocalScriptPath = "$LocalScriptFolder\MapDrive-$DriveLetter.bat"

# Créer le dossier C:\Scripts si nécessaire
if (-not (Test-Path $LocalScriptFolder)) {
    New-Item -ItemType Directory -Path $LocalScriptFolder
}

# Contenu du script .BAT
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $LocalScriptPath -Value $scriptContent

# Copier le script dans SYSVOL
$GPOGuid = $gpo.Id
$SysvolPath = "\\$netbiosName\SYSVOL\$netbiosName\Policies\{$GPOGuid}\User\Scripts\Logon"

if (-not (Test-Path $SysvolPath)) {
    New-Item -ItemType Directory -Path $SysvolPath -Force
}

Copy-Item -Path $LocalScriptPath -Destination $SysvolPath -Force

# ==========================================
# Fin
# ==========================================

