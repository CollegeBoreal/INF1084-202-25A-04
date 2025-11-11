# Auteur : Boudeuf imad 
# ID : 300152410
# Objectif : Lister les services AD

Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

Get-Service -Name NTDS, ADWS, DFSR, KDC, Netlogon, IsmServ
