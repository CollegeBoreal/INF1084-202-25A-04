# Obtenir le domaine
$domain = Get-ADDomain
$netbiosName = $domain.NetBIOSName
$GroupName = "Students"

# Activer RDP
Write-Host "Activation de RDP..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

# Autoriser le pare-feu
Write-Host "Configuration du pare-feu..." -ForegroundColor Yellow
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Ajouter le groupe Students au groupe local "Remote Desktop Users"
Write-Host "Ajout du groupe au groupe Remote Desktop Users..." -ForegroundColor Yellow
try {
    Add-LocalGroupMember -Group "Remote Desktop Users" -Member "$netbiosName\$GroupName" -ErrorAction Stop
    Write-Host "Groupe $GroupName ajouté aux utilisateurs RDP" -ForegroundColor Green
} catch {
    if ($_.Exception.Message -match "already a member") {
        Write-Host "Le groupe est déjà membre" -ForegroundColor Yellow
    } else {
        Write-Host "Erreur : $_" -ForegroundColor Red
    }
}

Write-Host "`nConfiguration RDP terminée !" -ForegroundColor Green
Write-Host "Les membres du groupe $GroupName peuvent se connecter via RDP" -ForegroundColor Cyan