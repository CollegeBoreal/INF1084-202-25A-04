# Afficher les 20 derniers événements liés à NTDS (méthode moderne)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | 
    Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize -Wrap

# Afficher les logs Netlogon du système
Get-WinEvent -LogName "System" -MaxEvents 20 | 
    Where-Object {$_.ProviderName -eq "Netlogon"} |
    Format-Table TimeCreated, Id, Message -AutoSize

# Alternative : filtrer par EventID spécifiques
Get-WinEvent -FilterHashtable @{
    LogName = 'Directory Service'
    Level = 2,3  # Erreurs et avertissements seulement
} -MaxEvents 20
