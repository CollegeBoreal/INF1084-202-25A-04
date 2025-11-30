# Lister tous les services liés à Active Directory
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l’état des services principaux AD DS
Get-Service -Name NTDS, ADWS, DFSR, KDC, Netlogon, IsmServ
