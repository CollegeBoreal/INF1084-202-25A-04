# =========================================
# TP INF1084 - Étape 3 : Désactivation, réactivation, suppression et export
# =========================================

# Variables de domaine
$studentNumber = 300141429
$studentInstance = 0
$domainName = "DC300141429.local"
$cred = Get-Credential  # Identifiants Admin

# Désactivation de l'utilisateur
Disable-ADAccount -Identity "alice.dupont" -Credential $cred
Write-Host "🚫 Utilisateur désactivé."

# Réactivation de l'utilisateur
Enable-ADAccount -Identity "alice.dupont" -Credential $cred
Write-Host "🔁 Utilisateur réactivé."

# Export CSV des utilisateurs du domaine
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
Write-Host "📁 Export réalisé dans TP_AD_Users.csv"

# Suppression de l'utilisateur
Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred
Write-Host "❌ Utilisateur supprimé."
