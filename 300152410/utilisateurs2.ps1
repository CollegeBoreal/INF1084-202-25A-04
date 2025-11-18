# ===================================================================
# Script : utilisateurs2.ps1
# Objectif : Créer une GPO pour mapper un lecteur réseau et activer RDP
# Auteur : Imad Boudeuf (300152410)
# ===================================================================

Import-Module GroupPolicy -ErrorAction SilentlyContinue
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

$GPOName     = "MapSharedFolder"
$OU_DN       = "OU=Students,DC=DC300152410-00,DC=local"
$DriveLetter = "Z:"
$Computer    = $env:COMPUTERNAME
$SharePath   = "\\$Computer\SharedResources"

# 1️⃣ Créer la GPO si elle n'existe pas
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName | Out-Null
    Write-Host "✅ GPO '$GPOName' créée."
} else {
    Write-Host "ℹ️ La GPO '$GPOName' existe déjà."
}

# 2️⃣ Lier la GPO à l'OU Students
try {
    New-GPLink -Name $GPOName -Target $OU_DN -Enforced No | Out-Null
    Write-Host "✅ GPO liée à l'OU 'Students'."
} catch {
    Write-Host "⚠️ Erreur lors du lien de la GPO à l'OU : $($_.Exception.Message)"
}

# 3️⃣ Créer le script de logon pour mapper le lecteur réseau
$ScriptFolder = "C:\Scripts"
$ScriptPath   = "$ScriptFolder\MapDrive-$DriveLetter.bat"
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder | Out-Null }

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent
Write-Host "✅ Script logon créé : $ScriptPath"

# 4️⃣ Enregistrer le script dans la GPO (logon script)
Set-GPRegistryValue -Name $GPOName `
  -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" `
  -ValueName "MapDriveZ" `
  -Type String `
  -Value $ScriptPath
Write-Host "✅ Script ajouté dans la GPO."

# 5️⃣ Activer RDP et pare-feu
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Write-Host "✅ RDP activé et pare-feu configuré."

# 6️⃣ (à faire sur les machines membres)
Write-Host "⚙️ Exécute sur les machines clientes :"
Write-Host 'Add-LocalGroupMember -Group "Remote Desktop Users" -Member "DC300152410-00\Students"'
