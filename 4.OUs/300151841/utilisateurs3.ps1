# utilisateurs3.ps1
# Désactivation puis réactivation du compte Alice

. "$PSScriptRoot\bootstrap.ps1"

Disable-ADAccount -Identity "alice.dupont"

Enable-ADAccount -Identity "alice.dupont"

Get-ADUser -Identity "alice.dupont" -Properties Enabled |
Select-Object Name, Enabled
