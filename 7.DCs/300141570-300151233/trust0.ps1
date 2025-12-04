Import-Module ActiveDirectory -ErrorAction Stop

# ================================
# 📌 Domain local (moi)
# ================================
$LocalDomain   = Get-ADDomain
$LocalDNS      = $LocalDomain.DNSRoot
$LocalNetBIOS  = $LocalDomain.NetBIOSName

# ================================
# 📌 Domain distant (mon partenaire)
# 🔥 CHANGE THESE TWO LINES ONLY
# ================================
$RemoteDNS     = "DC300141570.local"          # << partner FQDN
$RemoteNetBIOS = "DC300141570"                # << partner NetBIOS

Write-Host "Domaine local      : $LocalDNS ($LocalNetBIOS)" -ForegroundColor Cyan
Write-Host "Domaine partenaire : $RemoteDNS ($RemoteNetBIOS)" -ForegroundColor Cyan

# ================================
# 🔐 Credentials du domaine distant
# ================================
$CredRemote = Get-Credential -Message "Compte admin du domaine $RemoteDNS (ex: Administrator@$RemoteDNS)"

# ================================
# [1] 🌐 Test de ping
# ================================
Write-Host "`n[1] Test de ping vers le domaine distant..." -ForegroundColor Yellow
Test-Connection -ComputerName $RemoteDNS -Count 2 -Quiet

# ================================
# [2] 🧠 Infos du domaine distant
# ================================
Write-Host "`n[2] Informations du domaine distant..." -ForegroundColor Yellow
try {
    Get-ADDomain -Server $RemoteDNS -Credential $CredRemote |
        Select-Object DNSRoot, NetBIOSName, Forest
}
catch {
    Write-Warning "Impossible de contacter le domaine distant via ADWS : $($_.Exception.Message)"
}

# ================================
# [3] 👥 Quelques utilisateurs
# ================================
Write-Host "`n[3] Quelques utilisateurs du domaine distant..." -ForegroundColor Yellow
try {
    Get-ADUser -Filter * -Server $RemoteDNS -Credential $CredRemote -ResultSetSize 5 |
        Select-Object SamAccountName, Name
}
catch {
    Write-Warning "Impossible de lister les utilisateurs : $($_.Exception.Message)"
}

# ================================
# [4] 📁 Montage du PSDrive AD2
# ================================
Write-Host "`n[4] Montage du PSDrive AD2..." -ForegroundColor Yellow
try {
    # Remove old drive if exists
    Remove-PSDrive AD2 -ErrorAction SilentlyContinue

    # Convert FQDN → DN (mandatory for AD PSDrive)
    $RemoteDN = ($RemoteDNS -replace "\.", ",DC=")
    $RemoteDN = "DC=" + $RemoteDN

    New-PSDrive -Name AD2 -PSProvider ActiveDirectory -Root $RemoteDN -Server $RemoteDNS -Credential $CredRemote | Out-Null

    Write-Host "Montage AD2 réussi." -ForegroundColor Green
}
catch {
    Write-Warning "Impossible de monter AD2 : $($_.Exception.Message)"
}

Write-Host "`nPréparation AD2 terminée." -ForegroundColor Green
