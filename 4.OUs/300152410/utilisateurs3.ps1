# ===========================
# utilisateurs3.ps1
# Gestion des comptes
# ===========================

$studentNumber   = 300152410
$studentInstance = 0
$netbiosName     = "DC$studentNumber-$studentInstance"
$domainFqdn      = "$netbiosName.local"

Import-Module ActiveDirectory

# Exemple sur l’utilisateur Alice Dupont
$sam = "adupont"

# 1️⃣ Désactiver le compte
Disable-ADAccount -Identity $sam
Write-Host "Compte $sam désactivé."

# 2️⃣ Réactiver le compte
Enable-ADAccount -Identity $sam
Write-Host "Compte $sam réactivé."

# 3️⃣ Rechercher tous les utilisateurs qui commencent par 'a'
Get-ADUser -Filter "Name -like 'a*'" -Properties Name,SamAccountName |
Select-Object Name, SamAccountName

# 4️⃣ Exporter la liste complète des utilisateurs
Get-ADUser -Filter * -Server $domainFqdn -Properties Name,SamAccountName,EmailAddress,Enabled |
Select-Object Name,SamAccountName,EmailAddress,Enabled |
Export-Csv -Path ".\TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Export terminé -> TP_AD_Users.csv"
