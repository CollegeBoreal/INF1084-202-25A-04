# Auteur : 300151833
# Nombre d’événements à afficher
$eventCount = 20

########################################
# Bloc 1 : Journal "Directory Service"
########################################

$dsLogName = "Directory Service"

Get-EventLog -LogName $dsLogName -Newest $eventCount |
    Select-Object -Property TimeGenerated, EventID, EntryType, Source, Message |
    Format-Table -AutoSize


########################################
# Bloc 2 : Événements liés à Netlogon
########################################

$systemLog = "System"
$netlogonSource = "Netlogon"

Get-WinEvent -FilterHashtable @{
    LogName      = $systemLog
    ProviderName = $netlogonSource
} -MaxEvents $eventCount |
    Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, Message |
    Format-Table -AutoSize


########################################
# Bloc 3 : Journal moderne "Directory Service"
########################################

Get-WinEvent -FilterHashtable @{ LogName = $dsLogName } -MaxEvents $eventCount |
    Select-Object TimeCreated, Id, LevelDisplayName, Message |
    Format-Table -AutoSize
