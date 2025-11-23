# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer GPO
New-GPO -Name $GPOName

# Lier à l'OU Students (variable bootstrap)
$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU

# Créer un script de logon pour mappage Z:
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"

$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Lier script logon à la GPO
Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptPath

