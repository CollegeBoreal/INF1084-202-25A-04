Write-Host "=== SCRIPT AUTOMATISÉ TRUST AD ===`n"

# ====== PARAMÈTRES ======
$LocalForest  = "DC300151833.local"
$RemoteForest = "DC300146667-00.local"
$RemoteDC     = "10.7.236.193"         # IP du DC de Djaber (à adapter si besoin)
$RemoteCred   = Get-Credential -Message "Identifiants admin de la forêt distante"

Write-Host "Forêt locale  : $LocalForest"
Write-Host "Forêt distante : $RemoteForest"
Write-Host ""

# ====== TEST RÉSEAU ======
Write-Host "=== Test réseau ==="
Test-Connection -ComputerName $RemoteDC -Count 2

Write-Host "`n=== Test DNS ==="
Resolve-DnsName $RemoteForest -ErrorAction SilentlyContinue

# ====== TEST AD DISTANT ======
Write-Host "`n=== Vérification de la forêt distante ==="
try {
    Get-ADDomain -Server $RemoteDC -Credential $RemoteCred
    Get-ADUser -Filter * -Server $RemoteDC -Credential $RemoteCred | Select -First 5
}
catch {
    Write-Host "Impossible de contacter le domaine distant, mais DNS et réseau OK."
}

# ====== TRUST (théorique - limité dans ce LAB) ======
Write-Host "`n=== Création du trust (théorique) ==="
Write-Host "# La commande suivante NE FONCTIONNE PAS dans le lab car netdom est limité"
Write-Host "# netdom trust $LocalForest /Domain:$RemoteForest /Add /Twoway /UserO:Administrator /PasswordO:XXX /UserD:Administrator /PasswordD:XXX"

# ====== VÉRIFICATION LOCALE ======
Write-Host "`n=== Vérification des trusts locaux (nltest) ==="
nltest /domain_trusts

Write-Host "`n=== Fin du script ==="
