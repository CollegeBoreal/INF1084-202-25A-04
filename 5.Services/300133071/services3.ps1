Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Users\Administrator\Developer\INF1084-202-25A-03\5.Services\300133071\ADLogs.csv" -NoTypeInformation
