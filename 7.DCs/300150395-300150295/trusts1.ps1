<#
Script  : check-trust.ps1
Auteur  : Ismail TRACHE (300150395)
Cours   : INF1084 – Services Réseau Windows
But     : Vérifier la connectivité avec le DC du binôme,
          explorer son AD et créer/vérifier un trust de forêt bidirectionnel
          entre DC300150395-00.local et DC300150295-00.local.

À exécuter sur : DC300150395 (ton DC)
#>

param(
    # Forêt / domaine local (toi)
    [string]$ThisForestFQDN = "DC300150395-00.local",
    [string]$ThisDC         = "DC300150395.DC300150395-00.local",

    # Forêt / domaine distant (ton binôme)
    [string]$PeerForestFQDN = "DC300150295-00.local",
    [string]$PeerDC         = "DC300150295-00.local"
)

Write-Host "=== Création et vérification du trust entre $ThisForestFQDN et $PeerForestFQDN ===" -ForegroundColor Cyan

# ---------------------------------------------------------------------
# 0) Chargement du module AD
# ---------------------------------------------------------------------
Import-Module ActiveDirectory -ErrorAction Stop

Write-Host "`n[0] Informations sur TON DC" -ForegroundColor Yellow
$localDC = Get-ADDomainController
$localDC | Select-Object HostName,IPv4Address,Domain,Forest | Format-List

# ---------------------------------------------------------------------
# 1) Vérifier la connectivité réseau et DNS vers le DC distant
# ---------------------------------------------------------------------
Write-Host "`n[1] Vérification ping vers le DC distant ($PeerDC)..." -ForegroundColor Yellow
if (-not (Test-Connection -ComputerName $PeerDC -Count 2 -Quiet)) {
    throw "Le DC distant $PeerDC ne répond pas au ping. Vérifie réseau/Hyper-V."
}
Write-Host "[OK] $PeerDC répond au ping."

Write-Host "`n[2] Vérification DNS vers $PeerDC..." -ForegroundColor Yellow
try {
    $dns = Resolve-DnsName -Name $PeerDC -ErrorAction Stop
    Write-Host "[OK] DNS résout $PeerDC -> $($dns.IPAddress)"
} catch {
    throw "DNS ne résout pas $PeerDC. Vérifie les zones/délais."
}

Write-Host "`n[3] Vérification des ports critiques (88, 389, 445, 135)..." -ForegroundColor Yellow
$ports = 88,389,445,135
foreach ($p in $ports) {
    $res = Test-NetConnection -ComputerName $PeerDC -Port $p
    if (-not $res.TcpTestSucceeded) {
        throw "Port $p vers $PeerDC est FERMÉ. Ouvre le firewall ou désactive-le pour le labo."
    }
}
Write-Host "[OK] Tous les ports nécessaires sont ouverts vers $PeerDC."

# ---------------------------------------------------------------------
# 2) Récupérer des infos sur le domaine distant
# ---------------------------------------------------------------------
Write-Host "`n[4] Connexion au domaine distant via Get-ADDomain..." -ForegroundColor Yellow
$credPeer = Get-Credential -Message "Compte admin du domaine $PeerForestFQDN (ex: Administrateur)"

try {
    $peerDomain = Get-ADDomain -Server $PeerDC -Credential $credPeer -ErrorAction Stop
    Write-Host "[OK] Domaine distant détecté : $($peerDomain.DNSRoot)"
    Write-Host "     SID du domaine distant : $($peerDomain.DomainSID.Value)"
} catch {
    Write-Host "[ERREUR] Impossible de contacter le domaine distant via Get-ADDomain." -ForegroundColor Red
    Write-Host "         Vérifie les identifiants admin du domaine $PeerForestFQDN."
    throw
}

# ---------------------------------------------------------------------
# 3) Créer un PSDrive AD2:\ pour naviguer dans l'AD distant
# ---------------------------------------------------------------------
Write-Host "`n[5] Montage d'un PSDrive AD2: vers la forêt distante..." -ForegroundColor Yellow
$peerRootDN = ("DC=" + ($PeerForestFQDN -replace "\.",",DC="))  # ex: DC=DC300150295-00,DC=local

New-PSDrive `
    -Name AD2 `
    -PSProvider ActiveDirectory `
    -Root $peerRootDN `
    -Server $PeerDC `
    -Credential $credPeer `
    -ErrorAction SilentlyContinue | Out-Null

Write-Host "[OK] PSDrive 'AD2:' monté sur $PeerForestFQDN (root = $peerRootDN)."
Write-Host "     Exemple : Set-Location AD2:\ puis Get-ChildItem pour parcourir leur AD."

# ---------------------------------------------------------------------
# 4) Création du trust de forêt AVEC NETDOM (car New-ADTrust n'existe pas ici)
# ---------------------------------------------------------------------
Write-Host "`n[6] Création du trust de forêt bidirectionnel avec NETDOM..." -ForegroundColor Yellow

# Comptes admin locaux et distants
$localAdmin = "$ThisForestFQDN\Administrateur"
$peerAdmin  = "$PeerForestFQDN\Administrateur"

Write-Host "Local domain  : $ThisForestFQDN (admin : $localAdmin)"
Write-Host "Remote domain : $PeerForestFQDN (admin : $peerAdmin)"
Write-Host ""
Write-Host "NETDOM va te demander :" -ForegroundColor DarkYellow
Write-Host " - le mot de passe de $localAdmin (UserD)"
Write-Host " - puis le mot de passe de $peerAdmin (UserO)"
Write-Host ""

# Commande NETDOM pour créer un trust de forêt bidirectionnel
& netdom trust $PeerForestFQDN `
    /domain:$ThisForestFQDN `
    /twoway `
    /ForestTrust `
    /UserD:$localAdmin `
    /PasswordD:* `
    /UserO:$peerAdmin `
    /PasswordO:* 

Write-Host "[INFO] Si aucune erreur rouge n'est apparue ci-dessus, le trust a été créé." -ForegroundColor Green

# ---------------------------------------------------------------------
# 5) Vérification des trusts via Get-ADTrust
# ---------------------------------------------------------------------
Write-Host "`n[7] Vérification des trusts existants via Get-ADTrust..." -ForegroundColor Yellow

try {
    Get-ADTrust -Filter * | Format-Table Name,Direction,TrustType,Source,Target
} catch {
    Write-Host "[ERREUR] Get-ADTrust a échoué. Vérifie le module AD." -ForegroundColor Red
}

# ---------------------------------------------------------------------
# 6) Vérification du trust via NETDOM /verify
# ---------------------------------------------------------------------
Write-Host "`n[8] Vérification du trust via NETDOM /verify..." -ForegroundColor Yellow
Write-Host "Commande : netdom trust $PeerForestFQDN /domain:$ThisForestFQDN /verify" -ForegroundColor DarkYellow
Write-Host ""

try {
    & netdom trust $PeerForestFQDN /domain:$ThisForestFQDN /verify
} catch {
    Write-Host "[ERREUR] La vérification NETDOM a échoué." -ForegroundColor Red
}

Write-Host "`n=== Script terminé : connectivité, infos AD, trust et vérifications effectués. ===" -ForegroundColor Cyan
