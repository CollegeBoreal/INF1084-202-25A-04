param(
    [string]$RemoteDomainFqdn = "DC300150395-00.local",
    [string]$RemoteDC = "DC300150395-00"
)

Write-Host "=== 1) Vérifier la connectivité ==="
Test-Connection -ComputerName $RemoteDomainFqdn -Count 2


Write-Host "=== 2) Infos domaine distant ==="
$credAD1 = Get-Credential -Message "Admin du domaine distant"
Get-ADDomain -Server $RemoteDomainFqdn -Credential $credAD1

Write-Host "=== 3) Navigation AD1 ==="
New-PSDrive `
    -Name AD1 `
    -PSProvider ActiveDirectory `
    -Root "DC=DC300150395-00,DC=local" `
    -Server $RemoteDC `
    -Credential $credAD1 -ErrorAction Stop

Set-Location AD1:\
Get-ChildItem

Set-Location C:\

Write-Host "=== Fin du script ==="