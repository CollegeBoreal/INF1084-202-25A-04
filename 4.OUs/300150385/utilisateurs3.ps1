# utilisateurs3.ps1
# Désactivation puis réactivation du compte Alice

. "$PSScriptRoot\bootstrap.ps1"

Disable-ADAccount -Identity "Alice Dupont"
Enable-ADAccount -Identity "Alice Dupont"

Get-ADUser -Identity "Alice Dupont" -Properties Enabled | Select-Object Name, Enabled
