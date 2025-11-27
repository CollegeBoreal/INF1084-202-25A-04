Import-Module GroupPolicy

$GPOName = "MapSharedFolder"

New-GPO -Name $GPOName -ErrorAction SilentlyContinue

$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU

$DriveLetter = "Z:"
$SharePath   = "\\$netbiosName\SharedResources"

$ScriptFolder = "C:\Scripts"
$ScriptPath   = "$ScriptFolder\MapDrive-$DriveLetter.bat"

if (-not (Test-Path $ScriptFolder)) { 
    New-Item -ItemType Directory -Path $ScriptFolder 
}

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath
