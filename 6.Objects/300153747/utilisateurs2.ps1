###############################################
# SCRIPT GPO + RDP (Complet, compatibilite totale)
###############################################

# Variables
$GPOName = "MapSharedFolder"
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"
$OU = "OU=Students,DC=DC300153747-00,DC=local"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

###############################################
# 1. CREATION OU REUTILISATION DE LA GPO
###############################################

# Verifier si la GPO existe deja
$existingGPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue

if (-not $existingGPO) {
    New-GPO -Name $GPOName
    Write-Host "GPO created: $GPOName"
} else {
    Write-Host "GPO already exists. Using existing one."
}

###############################################
# 2. LIER LA GPO A L OU STUDENTS
###############################################

try {
    New-GPLink -Name $GPOName -Target $OU -ErrorAction Stop
    Write-Host "GPO linked to OU Students."
}
catch {
    Write-Host "GPO already linked to this OU."
}

###############################################
# 3. CREER LE SCRIPT LOGON
###############################################

# Creer le dossier de script si besoin
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

# Contenu du script BAT
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Ajouter le script logon dans la GPO
Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath

Write-Host "Logon script configured."

###############################################
# 4. ACTIVER RDP
###############################################

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "RDP enabled."

###############################################
# 5. AJOUT DES DROITS RDP AU GROUPE STUDENTS
###############################################

secedit /export /cfg C:\secpol.cfg

Write-Host ""
Write-Host "IMPORTANT:"
Write-Host "Edit C:\secpol.cfg and add Students in the line:"
Write-Host "    SeRemoteInteractiveLogonRight = ..."
Write-Host "Then press Y when asked."
Write-Host ""

secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite

###############################################
# FIN DU SCRIPT
###############################################

Write-Host ""
Write-Host "Script completed successfully."
