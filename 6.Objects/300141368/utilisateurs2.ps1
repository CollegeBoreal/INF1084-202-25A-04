# Importer module GroupPolicy
Import-Module GroupPolicy

# Variables
$GPOName = "MapSharedFolder"
$DomainDN = (Get-ADDomain).DistinguishedName
$OU = "OU=Students,$DomainDN"
$DriveLetter = "Z:"
$DriveLetterSafe = $DriveLetter.TrimEnd(':')
$SharePath = "\\$env:COMPUTERNAME\SharedResources"

# Script logon
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetterSafe.bat"
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder | Out-Null }

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent -Encoding ASCII
Write-Host "Script logon créé : $ScriptPath"

# Créer GPO si non existante
$GPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $GPO) {
    $GPO = New-GPO -Name $GPOName
    Write-Host "GPO '$GPOName' créée."
} else {
    Write-Host "GPO '$GPOName' existe déjà."
}

# Lier la GPO à l'OU si non existante
$GpoLink = Get-GPLink -Guid $GPO.Id -ErrorAction SilentlyContinue | Where-Object { $_.Target -eq $OU }
if (-not $GpoLink) {
    New-GPLink -Name $GPOName -Target $OU -Enforced No
    Write-Host "GPO liée à l'OU $OU."
} else {
    Write-Host "Le lien GPO existe déjà."
}

# Copier script vers SYSVOL
$LocalSysvolPath = "C:\Windows\SYSVOL\sysvol\$env:USERDNSDOMAIN\Policies\{$($GPO.Id.Guid)}\User\Scripts\Logon"
if (-not (Test-Path $LocalSysvolPath)) { New-Item -ItemType Directory -Path $LocalSysvolPath -Force | Out-Null }
Copy-Item -Path $ScriptPath -Destination $LocalSysvolPath -Force
Write-Host "Script copié dans SYSVOL : $LocalSysvolPath"

# Modifier scripts.ini
$ScriptsIniPath = Join-Path $LocalSysvolPath "scripts.ini"
if (-not (Test-Path $ScriptsIniPath)) { "[Logon]" | Out-File -FilePath $ScriptsIniPath -Encoding ASCII }
$iniContent = Get-Content $ScriptsIniPath
if ($iniContent -notmatch [regex]::Escape("MapDrive-$DriveLetterSafe.bat")) {
    Add-Content -Path $ScriptsIniPath -Value "SCRIPTS1=MapDrive-$DriveLetterSafe.bat"
}
Write-Host "Script ajouté à scripts.ini de la GPO."

# Activer RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Write-Host "RDP activé et firewall configuré."

# Export secpol pour droit RDP
Write-Host "Droit Logon via RDP pour 'Students' à gérer via secpol.cfg"
secedit /export /cfg C:\secpol.cfg
Write-Host "Après modification de 'SeRemoteInteractiveLogonRight', réimporter avec : secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite"

Write-Host "Configuration terminée avec succès."