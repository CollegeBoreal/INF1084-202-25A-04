# ============================
# utilisateurs2.ps1
# Modifier, désactiver et réactiver l’utilisateur (Sara Benali)
# ============================

. "$PSScriptRoot\bootstrap.ps1"

Write-Host "`n=== 3) Modification de l'utilisateur Sara Benali ===`n"

Set-ADUser -Identity "sara.benali" `
           -EmailAddress "sara.benali@exemple.com" `
           -GivenName "Sara-Marie" `
           -Credential $cred

Write-Host "Utilisateur modifié (email + prénom)."

Write-Host "`n=== 4) Désactivation de l'utilisateur ===`n"
Disable-ADAccount -Identity "sara.benali" -Credential $cred
Write-Host "Compte désactivé."

Write-Host "`n=== 5) Réactivation de l'utilisateur ===`n"
Enable-ADAccount -Identity "sara.benali" -Credential $cred
Write-Host "Compte réactivé."

