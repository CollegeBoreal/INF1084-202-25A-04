# ================================

# Définir le NetBIOS si bootstrap indisponible
$netbiosName = "DC300147786-00"

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer la GPO si elle n'existe pas
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName | Out-Null
}

# OU Students
$OU = "OU=Students,DC=$netbiosName,DC=local"

# Lier la GPO à l'OU uniquement si non déjà lié
$links = Get-GPInheritance -Target $OU | Select-Object -ExpandProperty GpoLinks
if (-not ($links.DisplayName -contains $GPOName)) {
    New-GPLink -Name $GPOName -Target $OU -Enforced ([Microsoft.GroupPolicy.EnforceLink]::Yes) | Out-Null
}

# Mappage lecteur Z
$DriveLetter = "Z"
$ServerIP = "10.7.236.225"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
}

Write-Output "Création du script logon pour le mappage lecteur Z"
$scriptContent = "net use ${DriveLetter}: \\$ServerIP\SharedResources /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

Write-Output "Lien du script logon à la GPO"

# Afficher les informations de la GPO
Get-GPO -Name $GPOName

Write-Output "`nScript utilisateurs2.ps1 terminé."

