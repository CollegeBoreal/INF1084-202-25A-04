# Vérifie si le dossier C:\Logs existe, sinon le crée:
PS C:\Users\Administrator\Developer\INF1084-202-25A-04\5.Services\300146545> $logPath = "C:\Logs"
PS C:\Users\Administrator\Developer\INF1084-202-25A-04\5.Services\300146545> if (-not (Test-Path $logPath)) {
>>     New-Item -ItemType Directory -Path $logPath -Force
>> }


    Directory: C:\


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        11/21/2025   4:11 PM                Logs

Exporte les 50 derniers événements dans un fichier CSV:
PS C:\Users\Administrator\Developer\INF1084-202-25A-04\5.Services\300146545> Get-EventLog -LogName Application -Newest 50 | Export-Csv -Path "$logPath\ADLogs.csv" -NoTypeInformation
