# ================================
# Script : utilisateurs2.ps1
# Objectif : Créer une GPO pour mapper le lecteur Z:
#            via un script de logon.
# ================================

# Nom de la GPO
$GPOName = "MapSharedFolder"

# 1️⃣ Créer la GPO
$gpo = New-GPO -Name $GPOName -ErrorAction SilentlyContinue

# 2️⃣ Lier la GPO à l'OU Students
$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU

# 3️⃣ Variables pour le lecteur réseau
$DriveLetter = "Z:"
$SharePath   = "\\$netbiosName\SharedResources"

# 4️⃣ Chemin du script local avant copie dans SYSVOL
$LocalScriptFolder = "C:\Scripts"
$LocalScriptPath   = "$LocalScriptFolder\MapDrive-$DriveLetter.bat"

# Créer le dossier Scripts si absent
if (-not (Test-Path $LocalScriptFolder)) {
    New-Item -ItemType Directory -Path $LocalScriptFolder
}

# Contenu du script
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $LocalScriptPath -Value $scriptContent

# 5️⃣ Copier le script dans SYSVOL (dossier GPO)
$GPOGuid = $gpo.Id
$SysvolPath = "\\$netbiosName\SYSVOL\$netbiosName\Policies\{$GPOGuid}\User\Scripts\Logon"

if (-not (Test-Path $SysvolPath)) {
    New-Item -ItemType Directory -Path $SysvolPath -Force
}

Copy-Item -Path $LocalScriptPath -Destination $SysvolPath -Force

# 6️⃣ Déclarer le script de logon dans la GPO
$ScriptFileName = Split-Path $LocalScriptPath -Leaf

Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Environment" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptFileName

# ================================
# Fin du script
# ================================

