# utilisateurs0.ps1
$bootstrapPath = Join-Path $PSScriptRoot '..\..\4.OUs\300141570\bootstrap.ps1'

if (-not (Test-Path $bootstrapPath)) {
    Write-Error "Bootstrap introuvable à l'emplacement : $bootstrapPath"
    exit 1
}

. $bootstrapPath
Import-Module ActiveDirectory -ErrorAction Stop
Import-Module GroupPolicy -ErrorAction Stop

Write-Host "Domain FQDN : $domainName"
Write-Host "NetBIOS     : $netbiosName"

Get-ADDomain -Server $domainName
