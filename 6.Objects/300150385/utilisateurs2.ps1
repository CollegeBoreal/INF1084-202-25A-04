# ============================================
# Script : utilisateurs2.ps1
# Objectif : Créer et lier une GPO pour mapper
#            un lecteur réseau Z: pour les étudiants
# Étudiant : Belkacem Medjkoune - 300150385
# ============================================

# Récupération du NetBIOS du domaine
$domainNetbios = (Get-ADDomain).NetBIOSName

# Nom de la GPO à utiliser
$GPOName = "MapSharedFolder"

Write-Host "Vérification de l'existence de la GPO $GPOName ..." -ForegroundColor Cyan

# Vérifier si la GPO existe ou non
$CheckGPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue

if ($CheckGPO) {
    Write-Host "[INFO] La GPO existe déjà, utilisation de l'existante."
} 
else {
    New-GPO -Name $GPOName | Out-Null
    Write-Host "[OK] Nouvelle GPO créée : $GPOName"
}

# OU ciblée (Students)
$TargetOU = "OU=Students,DC=$domainNetbios,DC=local"

Write-Host "Association de la GPO à l'OU : $TargetOU ..." -ForegroundColor Cyan

# Lier la GPO
New-GPLink -Name $GPOName -Target $TargetOU -ErrorAction SilentlyContinue

# Création du script Logon pour le mapping du lecteur Z:
$Drive = "Z:"
$Shared = "\\$domainNetbios\SharedResources"
$ScriptDir = "C:\Scripts"
$ScriptFile = "$ScriptDir\MapDrive-$Drive.bat"

# Si le dossier n'existe pas, création
if (!(Test-Path $ScriptDir)) {
    New-Item -Path $ScriptDir -ItemType Directory | Out-Null
    Write-Host "[OK] Dossier créé : C:\Scripts"
}

# Contenu du script de mapping
$Content = "net use $Drive $Shared /persistent:no"
Set-Content -Path $ScriptFile -Value $Content

Write-Host "[OK] Script Logon créé : $ScriptFile"

# Application dans la GPO
Write-Host "Configuration de la GPO pour exécuter le script..." -ForegroundColor Cyan

Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptFile

Write-Host "[OK] Script de logon appliqué dans la GPO." -ForegroundColor Green

Write-Host "`n--- Script terminé ---"
