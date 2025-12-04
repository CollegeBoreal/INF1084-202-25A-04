Import-Module ActiveDirectory -ErrorAction Stop

Write-Host "======== TRUST0 : Détection du domaine ==========" -ForegroundColor Cyan

# Detect local domain automatically
$Local = Get-ADDomain
$LocalDNS = $Local.DNSRoot
$LocalNETBIOS = $Local.NetBIOSName

Write-Host "Domaine local détecté : $LocalDNS ($LocalNETBIOS)" -ForegroundColor Green

# AUTO-DETECT remote domain depending where the script runs
if ($LocalDNS -eq "DC300141570.local") {

    # You are Haroune (your DC)
    $RemoteDNS = "DC300151233-00.local"
    $RemoteNETBIOS = "DC300151233-00"
    Write-Host "Ton partenaire est : $RemoteDNS" -ForegroundColor Yellow

} elseif ($LocalDNS -eq "DC300151233-00.local") {

    # You are the partner
    $RemoteDNS = "DC300141570.local"
    $RemoteNETBIOS = "DC300141570"
    Write-Host "Ton partenaire est : $RemoteDNS" -ForegroundColor Yellow

} else {

    Write-Host "ERREUR: Domaine inconnu. Vérifie le script." -ForegroundColor Red
    exit
}

# Ask for remote-domain credentials
$CredRemote = Get-Credential -Message "Entrez un compte Administrateur du domaine distant ($RemoteDNS)"

Write-Host "`n[1] Test de ping vers le domaine distant..." -ForegroundColor Cyan
Test-Connection $RemoteDNS -Count 2 -ErrorAction SilentlyContinue |
    Select-Object Source,Destination,IPV4Address,Bytes,ResponseTime

Write-Host "`n[2] Informations du domaine distant via ADWS..." -ForegroundColor Cyan
try {
    Get-ADDomain -Server $RemoteDNS -Credential $CredRemote |
        Select-Object DNSRoot,NetBIOSName,Forest
}
catch {
    Write-Warning "Impossible de contacter le domaine distant : $($_.Exception.Message)"
}

Write-Host "`n[3] Quelques utilisateurs du domaine distant..." -ForegroundColor Cyan
try {
    Get-ADUser -Filter * -Server $RemoteDNS -Credential $CredRemote -ResultSetSize 5 |
        Select-Object SamAccountName,Name
}
catch {
    Write-Warning "Impossible de lister les utilisateurs du domaine distant."
}

Write-Host "`n[4] Montage du PSDrive AD2..." -ForegroundColor Cyan
try {
    Remove-PSDrive AD2 -ErrorAction SilentlyContinue
    New-PSDrive -Name AD2 -PSProvider ActiveDirectory -Root $RemoteDNS -Server $RemoteDNS -Credential $CredRemote | Out-Null
    Write-Host "Montage AD2 réussi." -ForegroundColor Green
}
catch {
    Write-Warning "Impossible de monter AD2 : $($_.Exception.Message)"
}

Write-Host "`nPréparation AD2 terminée." -ForegroundColor Green

