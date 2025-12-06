Import-Module ActiveDirectory -ErrorAction Stop
Import-Module GroupPolicy -ErrorAction Stop

$netbiosName = "DC300147786-00"
$GPOName = "MapSharedFolder"
$OUName = "Students"
$OUDN = "OU=$OUName,DC=DC300147786-00,DC=local"

# Créer OU si non existante
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$OUName'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $OUName -Path "DC=DC300147786-00,DC=local"
    Write-Host "OU '$OUName' créée."
} else {
    Write-Host "OU '$OUName' existe déjà."
}

# Créer GPO si non existante
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName
    Write-Host "GPO '$GPOName' créée."
} else {
    Write-Host "GPO '$GPOName' existe déjà."
}

# Lier la GPO si pas déjà liée
$links = Get-GPInheritance -Target $OUDN | Select-Object -ExpandProperty GpoLinks
if (-not ($links.DisplayName -contains $GPOName)) {
    New-GPLink -Name $GPOName -Target $OUDN -Enforced ([Microsoft.GroupPolicy.EnforceLink]::Yes)
    Write-Host "GPO '$GPOName' liée à l'OU '$OUName'."
} else {
    Write-Host "GPO '$GPOName' est déjà liée à l'OU '$OUName'."
}

# Créer le script logon
$DriveLetter = "Z"
$ScriptFolder = "C:\Scripts"
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder | Out-Null }

$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"
$scriptContent = "net use $DriveLetter: \\$netbiosName\SharedResources /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent
Write-Host "Script logon créé : $ScriptPath"

# Copier le script dans SYSVOL de la GPO
$GPO = Get-GPO -Name $GPOName
$SysvolPath = "\\$netbiosName\SYSVOL\$netbiosName\Policies\{$($GPO.Id)}\User\Scripts\Logon"
if (-not (Test-Path $SysvolPath)) { New-Item -ItemType Directory -Path $SysvolPath -Force | Out-Null }
Copy-Item -Path $ScriptPath -Destination $SysvolPath -Force
Write-Host "Script logon copié dans SYSVOL de la GPO."

Write-Host "Script terminé avec succès ✅"

