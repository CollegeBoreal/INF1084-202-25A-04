# Auteur : Haroune Berkani (300141570)

# Step 1 : Lister les services liés à Active Directory
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Step 2 : Vérifier l’état des services spécifiques
Get-Service -Name NTDS, ADWS, DFSR
