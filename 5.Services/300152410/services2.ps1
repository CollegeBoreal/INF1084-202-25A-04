# TP Services AD - Boudeuf Imad 300152410
# Exportation des 50 derniers journaux Directory Service vers un fichier CSV

$path = "C:\Logs"
if (!(Test-Path $path)) {
    New-Item -Path $path -ItemType Directory
}
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "$path\ADLogs.csv" -NoTypeInformation
Write-Host "Fichier ADLogs.csv créé dans $path"
