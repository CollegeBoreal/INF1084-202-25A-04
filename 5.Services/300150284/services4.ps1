# Auteur : 300150284
# TP Services 4
# Exporter les services dans un fichier CSV

$OutputFile = "services_300150284.csv"

Get-Service |
Select-Object Name, Status, DisplayName |
Export-Csv -Path $OutputFile -NoTypeInformation

Write-Host "Export terminé : $OutputFile"
