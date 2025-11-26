# Nom de la GPO
$GPOName = "MapSharedFolder"

# Récupérer nom NetBIOS du serveur
$netbiosName = $env:COMPUTERNAME

# 1️⃣ Créer la GPO
New-GPO -Name $GPOName

# 2️⃣ Lier la GPO à l’OU Students
$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU

# 3️⃣ Créer un script de logon pour mapper le lecteur Z:
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"

# Dossier contenant les scripts
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

# Si le dossier n'existe pas, on le crée
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

# Contenu du script
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# 4️⃣ Ajouter le script à la GPO
Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptPath
