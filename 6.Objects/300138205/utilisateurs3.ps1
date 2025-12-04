# Autoriser les connexions RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0

# Autoriser RDP dans le firewall
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
# Définir le groupe à autoriser
$group = "Students"
$cfgPath = "$env:TEMP\secpol.cfg"
$dbPath  = "$env:TEMP\secpol.sdb"

# Exporter la configuration actuelle
secedit /export /cfg $cfgPath /areas USER_RIGHTS | Out-Null

# Lire le fichier
$content = Get-Content $cfgPath

# Chercher la ligne actuelle (si elle existe)
$matchLine = $content | Where-Object { $_ -match "^SeRemoteInteractiveLogonRight" }

if ($matchLine) {
    # Récupérer l’index correct
    $lineIndex = $content.IndexOf($matchLine)

    # Ajouter le groupe s’il n’est pas présent
    if ($matchLine -notmatch "\*$group") {
        $newLine = $matchLine + ",*$group"
        $content[$lineIndex] = $newLine
    }
}
else {
    # La ligne n’existe pas → on la crée
    Add-Content -Path $cfgPath -Value "SeRemoteInteractiveLogonRight = *$group"
}

# Réécrire le fichier mis à jour
$content | Set-Content $cfgPath

# Appliquer la nouvelle configuration
secedit /configure /db $dbPath /cfg $cfgPath /areas USER_RIGHTS | Out-Null

Write-Host "RDP activé et droits appliqués pour le groupe $group."