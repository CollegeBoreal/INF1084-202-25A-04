Stop-Service -Name DFSR
(Get-Service -Name DFSR).status
Start-Service -Name DFSR
