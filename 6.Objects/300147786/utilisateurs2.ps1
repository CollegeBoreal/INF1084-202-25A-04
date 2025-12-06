# ================================
# SCRIPT UTILISATEURS2.PS1 CORRIGÉ
# Crée une GPO et associe un script de logon pour mapper un lecteur réseau
# ================================

# Charger les modules nécessaires
Import-Module ActiveDirectory -ErrorAction Stop
Import-Module GroupPolicy -ErrorAction Stop

# Nom du domaine / NetBIOS
$netbiosName = "DC300147786-00"

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Nom de l'OU
$OUName = "Students"
$OUDN = "OU=$OUName,DC=DC300147786-00,DC=local"

# 1️⃣ Créer l'OU si elle n'existe pas
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$OUName'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $OUName -Path "DC=DC300147786-00,DC=local"
    Write-Host "OU '$OUName' créée avec succès."
} else {
    Write-Host "OU '$OUName' existe déjà."
}

# 2️⃣ Créer la GPO si elle n'existe pas
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName
    Write-Host "GPO '$GPOName' créée avec succès."
} else {
    Write-Host "GPO '$GPOName' existe déjà."
}

# 3️⃣ Lier la GPO à l'OU (avec enforcement)
New-GPLink -Name $GPOName -Target $OUDN -Enforced ([Microsoft.GroupPolicy.EnforceLink]::Yes)
Write-Host "GPO '$GPOName' liée à l'OU '$OUName' avec enforcement."

# 4️⃣ Créer le script logon pour mapper le lecteur Z:
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"
$ScriptFolder = "C:\Scripts"

if (-not (Test-Path $ScriptFolder)) { 
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
    Write-Host "Dossier de scripts créé : $ScriptFolder"
}

$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent
Write-Host "Script logon créé : $ScriptPath"

# 5️⃣ Associer le script logon à la GPO (méthode valide)
$GPO = Get-GPO -Name $GPOName

# Copier le script dans le dossier GPO
$GPOScriptPath = "$env:SYSVOL\DC300147786-00.local\Policies\{$($GPO.Id)}\User\Scripts\Logon"
if (-not (Test-Path $GPOScriptPath)) { New-Item -ItemType Directory -Path $GPOScriptPath -Force | Out-Null }
Copy-Item -Path $ScriptPath -Destination $GPOScriptPath -Force

# Ajouter le script logon à la GPO
$GPO | Set-GPLogonScript -ScriptName (Split-Path $ScriptPath -Leaf) -ScriptType User
Write-Host "Script logon associé à la GPO '$GPOName'."

Write-Host "Script terminé avec succès ✅"

