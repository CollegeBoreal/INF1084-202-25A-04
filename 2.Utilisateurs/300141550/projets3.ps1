# Exporter le groupe en CSV
$Groups["Etudiants2025"] | Export-Csv -Path "C:\Temp\Etudiants2025.csv" -NoTypeInformation -Encoding UTF8

# Afficher un message de confirmation
Write-Output "Exportation finie : C:\Temp\Etudiants2025.csv"
