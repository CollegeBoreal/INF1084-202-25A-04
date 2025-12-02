# Nom du domaine / NetBIOS
$netbiosName = "DC999999999-00"

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer la GPO si elle n'existe pas
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName
}

# Lier la GPO à l'OU Students (à créer si non existante)
$OU = "OU=Students,DC=DC999999999-00,DC=local"
New-GPLink -Name $GPOName -Target $OU -Enforced $true

# Créer un script logon pour mapper le lecteur Z:
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"
$ScriptFolder = "C:\Scripts"
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder }

$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Associer le script logon à la GPO
Set-GPLogonScript -ScriptPath $ScriptPath -GPOName $GPOName

