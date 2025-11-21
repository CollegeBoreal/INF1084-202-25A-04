# services1.ps1 - 300150527
# Objectif : Lister les services liés à Active Directory et vérifier leur état.

# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName


# Vérifier l’état d’un service spécifique
Get-Service -Name NTDS, ADWS, DFSR
