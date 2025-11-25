# --- Script 1 : Recherche et export des utilisateurs AD ---
param(
    [string]$domain = "DC300151042-00.local"
)

$cred = Get-Credential -Message "Entrez vos identifiants AD"

Write-Host "Recherche des utilisateurs dont le prénom commence par 'A'..."

Get-ADUser -Filter "GivenName -like 'A*'" -Properties Name, SamAccountName -Server $domain -Credential $cred |
Select-Object Name, SamAccountName |
Format-Table -AutoSize

Write-Host "Exportation de tous les utilisateurs vers TP_AD_Users.csv..."

Get-ADUser -Filter * -Server $domain -Credential $cred -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @('Administrator','Guest','krbtgt') } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Export terminé : fichier 'TP_AD_Users.csv' créé."


