$netbiosName = "DC999999999-00"
$GPOName = "MapSharedFolder"

if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName | Out-Null
}

$OU = "OU=Students,DC=DC999999999-00,DC=local"
New-GPLink -Name $GPOName -Target $OU -Enforced $true | Out-Null

$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"

$ScriptFolder = "C:\Scripts"
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder | Out-Null }

$ScriptPath = "$ScriptFolder\MapDrive-Z.bat"
$scriptContent = "net use Z: $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

$GPO = Get-GPO -Name $GPOName
$GPOID = $GPO.Id
$SysVolPath = "\\$netbiosName\SYSVOL\DC999999999-00.local\Policies\{$GPOID}\User\Scripts\Logon"

if (-not (Test-Path $SysVolPath)) { New-Item -ItemType Directory -Path $SysVolPath -Force | Out-Null }

Copy-Item $ScriptPath -Destination $SysVolPath -Force

$ScriptName = Split-Path $ScriptPath -Leaf
Set-GPRegistryValue -Name $GPOName -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" -ValueName "MapDriveZ" -Type String -Value $ScriptPath
