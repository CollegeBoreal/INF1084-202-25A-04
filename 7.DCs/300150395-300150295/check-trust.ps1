param(
    [string]$RemoteDomainFqdn = "DC300150295-00.local",
    [string]$RemoteDC        = "DC300150295-00.local"
)

Write-Host "=== 1) Verifier la connectivite ==="
Test-Connection -ComputerName $RemoteDC -Count 2

Write-Host "`n=== 2) Infos domaine distant ==="
$credAD2 = Get-Credential -Message "Admin du domaine distant"
Get-ADDomain -Server $RemoteDomainFqdn -Credential $credAD2

Write-Host "`n=== 3) Navigation dans l'AD distant (PSDrive AD2:\) ==="
New-PSDrive `
  -Name AD2 `
  -PSProvider ActiveDirectory `
  -Root "DC=DC300150295-00,DC=local" `
  -Server $RemoteDC `
  -Credential $credAD2 -ErrorAction Stop

Set-Location AD2:\
Get-ChildItem
Set-Location C:\   # revenir sur un chemin classique

Write-Host "`n=== Fin du script de verification ==="

