# Obtenir le nom NetBIOS du domaine
$domain = Get-ADDomain
$netbiosName = $domain.NetBIOSName
$domainDN = $domain.DistinguishedName

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer la GPO si elle n'existe pas
try {
    if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
        New-GPO -Name $GPOName -Comment "Mappe le lecteur Z: vers le dossier partagé"
        Write-Host "GPO créée : $GPOName" -ForegroundColor Green
    } else {
        Write-Host "La GPO $GPOName existe déjà" -ForegroundColor Yellow
    }
} catch {
    Write-Host "Erreur lors de la création de la GPO : $_" -ForegroundColor Red
    exit
}

# Définir l'OU cible
$OU = "OU=Students,$domainDN"

# Vérifier si l'OU existe
if (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$OU'" -ErrorAction SilentlyContinue) {
    # Lier la GPO à l'OU si pas déjà lié
    if (-not (Get-GPInheritance -Target $OU | Select-Object -ExpandProperty GpoLinks | Where-Object {$_.DisplayName -eq $GPOName})) {
        New-GPLink -Name $GPOName -Target $OU -LinkEnabled Yes
        Write-Host "GPO liée à l'OU : $OU" -ForegroundColor Green
    } else {
        Write-Host "La GPO est déjà liée à l'OU" -ForegroundColor Yellow
    }
} else {
    Write-Host "L'OU $OU n'existe pas. Créez-la d'abord." -ForegroundColor Red
    exit
}

# Configuration du lecteur mappé
$DriveLetter = "Z:"
$SharePath = "\\$env:COMPUTERNAME\SharedResources"

# Obtenir le GUID de la GPO
$GPO = Get-GPO -Name $GPOName
$GPOGUID = $GPO.Id.ToString()

# Chemin vers le dossier de la GPO dans SYSVOL
$GPOPath = "\\$netbiosName\SYSVOL\$($domain.DNSRoot)\Policies\{$GPOGUID}"
$DrivesXMLPath = "$GPOPath\User\Preferences\Drives"

# Créer le dossier Drives s'il n'existe pas
if (-not (Test-Path $DrivesXMLPath)) {
    New-Item -Path $DrivesXMLPath -ItemType Directory -Force | Out-Null
    Write-Host "Dossier Drives créé dans SYSVOL" -ForegroundColor Green
}

# Créer le fichier Drives.xml pour GPP
$DrivesXML = @"
<?xml version="1.0" encoding="utf-8"?>
<Drives clsid="{8FDDCC1A-0C3C-43cd-A6B4-71A6DF20DA8C}">
    <Drive clsid="{935D1B74-9CB8-4e3c-9914-7DD559B7A417}" name="$DriveLetter" status="$DriveLetter" image="2" changed="$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" uid="{$(New-Guid)}">
        <Properties action="U" thisDrive="NOCHANGE" allDrives="NOCHANGE" userName="" path="$SharePath" label="" persistent="0" useLetter="1" letter="$DriveLetter"/>
    </Drive>
</Drives>
"@

# Sauvegarder le fichier XML
Set-Content -Path "$DrivesXMLPath\Drives.xml" -Value $DrivesXML -Encoding UTF8
Write-Host "Configuration GPP créée pour mapper le lecteur $DriveLetter" -ForegroundColor Green

# Activer l'extension GPP dans la GPO
Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Policies\Microsoft\Windows\Group Policy\{5794DAFD-BE60-433f-88A2-1A31939AC01F}" `
    -ValueName "Disabled" `
    -Type DWord `
    -Value 0

Write-Host "`nConfiguration terminée !" -ForegroundColor Green
Write-Host "Le lecteur $DriveLetter sera mappé vers $SharePath pour les utilisateurs de l'OU Students" -ForegroundColor Cyan
Write-Host "Exécutez 'gpupdate /force' sur les clients pour appliquer immédiatement" -ForegroundColor Yellow