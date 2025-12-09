# Source le bootstrap


Write-Host "`n=== Configuration RDP complete sur Domain Controller ===" -ForegroundColor Cyan

try {
    # 1. Activer RDP
    Write-Host "`n1. Activation de RDP..." -ForegroundColor Yellow
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
    Write-Host "   RDP active" -ForegroundColor Green
    
    # 2. Autoriser RDP dans le firewall
    Write-Host "`n2. Configuration du firewall..." -ForegroundColor Yellow
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    Write-Host "   Firewall configure" -ForegroundColor Green
    
    # 3. Ajouter Students au groupe AD "Remote Desktop Users"
    Write-Host "`n3. Ajout du groupe Students a Remote Desktop Users..." -ForegroundColor Yellow
    Add-ADGroupMember -Identity "Remote Desktop Users" -Members "Students" -ErrorAction SilentlyContinue
    Write-Host "   Groupe ajoute" -ForegroundColor Green
    
    # 4. CRITIQUE : Donner le droit de connexion RDP via secedit
    Write-Host "`n4. Configuration des droits d'ouverture de session RDP..." -ForegroundColor Yellow
    
    # Obtenir le SID du groupe Students
    $StudentsSID = (Get-ADGroup -Identity "Students").SID.Value
    Write-Host "   SID du groupe Students: $StudentsSID" -ForegroundColor Cyan
    
    # Export de la configuration actuelle
    secedit /export /cfg C:\secpol.cfg /quiet
    
    # Lire et modifier
    $content = Get-Content C:\secpol.cfg
    $newContent = $content | ForEach-Object {
        if ($_ -match "^SeRemoteInteractiveLogonRight") {
            if ($_ -notmatch $StudentsSID) {
                $_ + ",*$StudentsSID"
            } else {
                $_
            }
        } else {
            $_
        }
    }
    
    # Sauvegarder et réimporter
    $newContent | Set-Content C:\secpol.cfg
    secedit /configure /db C:\secpol.sdb /cfg C:\secpol.cfg /areas USER_RIGHTS /quiet
    
    Write-Host "   Droits RDP configures" -ForegroundColor Green
    
    # Nettoyer
    Remove-Item C:\secpol.cfg -ErrorAction SilentlyContinue
    Remove-Item C:\secpol.sdb -ErrorAction SilentlyContinue
    
    # 5. Forcer la mise à jour
    Write-Host "`n5. Mise a jour des strategies..." -ForegroundColor Yellow
    gpupdate /force | Out-Null
    Write-Host "   Strategies mises a jour" -ForegroundColor Green
    
    # 6. Vérification
    Write-Host "`n=== VERIFICATION ===" -ForegroundColor Cyan
    
    Write-Host "`nMembres du groupe Remote Desktop Users:" -ForegroundColor Yellow
    Get-ADGroupMember -Identity "Remote Desktop Users" | Select Name, SamAccountName | Format-Table
    
    Write-Host "Membres du groupe Students:" -ForegroundColor Yellow
    Get-ADGroupMember -Identity "Students" | Select Name, SamAccountName | Format-Table
    
    Write-Host "Statut RDP:" -ForegroundColor Yellow
    $rdpStatus = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections"
    if ($rdpStatus.fDenyTSConnections -eq 0) {
        Write-Host "RDP est ACTIVE" -ForegroundColor Green
    } else {
        Write-Host "RDP est DESACTIVE" -ForegroundColor Red
    }
    
    Write-Host "`nDroits d'ouverture de session RDP:" -ForegroundColor Yellow
    secedit /export /cfg C:\temp_check.cfg /quiet
    $rdpRights = Get-Content C:\temp_check.cfg | Select-String "SeRemoteInteractiveLogonRight"
    Write-Host $rdpRights -ForegroundColor Cyan
    Remove-Item C:\temp_check.cfg -ErrorAction SilentlyContinue
    
    Write-Host "`n=== Configuration RDP TERMINEE ===" -ForegroundColor Green
    
} catch {
    Write-Host "`nERREUR: $_" -ForegroundColor Red
}