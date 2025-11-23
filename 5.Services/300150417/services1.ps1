# TP Services AD - Étape 1
# Auteur : Abdelatif Nemous - 300150417

# Lister tous les services liés à Active Directory
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l’état des principaux services AD
Get-Service -Name NTDS, ADWS, DFSR
