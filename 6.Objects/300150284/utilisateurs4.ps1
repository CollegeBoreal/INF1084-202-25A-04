# Auteur : 300150284
# TP Objets AD – Script 4
# Vérification et exportation

# 1. Vérifier partage
Get-SmbShare | Where-Object Name -eq "SharedResources"

# 2. Vérifier GPO
Get-GPO -Name "MapSharedFolder"

# 3. Export logs AD
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
    Export-Csv "C:\Logs\ADLogs.csv" -NoTypeInformation
