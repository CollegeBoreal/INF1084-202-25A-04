Import-Module ActiveDirectory -ErrorAction Stop

Write-Host "Domaine local :" (Get-ADDomain).DNSRoot "(" (Get-ADDomain).NetBIOSName ")"
Write-Host "Domaine partenaire :" "DC300151233-00.local" "(DC300151233)"

$remoteDnsRoot  = "DC300151233-00.local"
$remoteNetbios  = "DC300151233-00"

Write-Host ""

### 1) TEST DE PING
Write-Host "[1] Test de ping vers le domaine distant..."
Test-Connection $remoteDnsRoot -Count 1 -Quiet

Write-Host ""

### 2) INFOS DU DOMAINE DISTANT
Write-Host "[2] Informations du domaine distant..."
try {
    Get-ADDomain -Server $remoteDnsRoot -Credential (
        Get-Credential -Message "Compte admin domaine distant (ex: Administrator@DC300151233-00.local)"
    ) | Select DNSRoot, NetBIOSName, Forest
}
catch {
    Write-Warning $_.Exception.Message
}

### 3) UTILISATEURS DU DOMAINE DISTANT
Write-Host "[3] Quelques utilisateurs du domaine distant..."
try {
    Get-ADUser -Filter * -Server $remoteDnsRoot -Credential (
        Get-Credential -Message "Re-saisis le même compte admin du domaine distant"
    ) -ResultSetSize 5 |
        Select SamAccountName, Name
}
catch {
    Write-Warning $_.Exception.Message
}

### 4) MONTER PSDRIVE
Write-Host "[4] Montage du PSDrive AD2..."
try {
    Remove-PSDrive AD2 -Force -ErrorAction SilentlyContinue
    New-PSDrive -Name AD2 -PSProvider ActiveDirectory -Root "" -Server $remoteDnsRoot `
        -Credential (Get-Credential -Message "Dernière fois: compte admin distant")
    Write-Host "Montage AD2 réussi." -ForegroundColor Green
} catch {
    Write-Host "ERREUR MONTAGE AD2 :" $_.Exception.Message -ForegroundColor Red
}

Write-Host ""
Write-Host "Préparation AD2 terminée."
