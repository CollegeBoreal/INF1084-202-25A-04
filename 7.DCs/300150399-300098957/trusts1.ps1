# trusts1.ps1
# Diagnostic et preparation du trust entre :
# - Foret locale  : DC300150399-00.local
# - Foret distante: DC300098957-00.local
# Etudiant : Chakib Rahmani (300150399)
# Enseignant (VM distante) : 10.7.236.170

# =====================================================================
# 0. Variables de contexte
# =====================================================================

$LocalDomain  = "DC300150399-00.local"
$RemoteDomain = "DC300098957-00.local"
$RemoteDC     = "DC300098957-90.local"
$RemoteDC_IP  = "10.7.236.170"

<<<<<<< HEAD
# Forêt distante (enseignant)
$RemoteForest = "DC300098957-90.local"
=======
Write-Host "=== CONTEXTE ===" -ForegroundColor Cyan
Write-Host "Foret locale  : $LocalDomain"
Write-Host "Foret distante: $RemoteDomain"
Write-Host "Controller distant : $RemoteDC ($RemoteDC_IP)"
Write-Host ""
>>>>>>> aa271641 (push du script)

# =====================================================================
# 1. Demande des identifiants du domaine distant
# =====================================================================

Write-Host "=== 1. Demande des identifiants du domaine distant ===" -ForegroundColor Cyan
$cred = Get-Credential -Message "Entrez un compte admin du domaine $RemoteDomain"

# =====================================================================
# 2. Test de connectivite et resoluton DNS
# =====================================================================

Write-Host "=== 2. Test de connectivite vers le DC distant (ICMP) ===" -ForegroundColor Cyan
Test-Connection -ComputerName $RemoteDC -Count 2 -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "=== 2b. Test de resolution DNS vers le DC distant ===" -ForegroundColor Cyan
try {
    Resolve-DnsName $RemoteDC -ErrorAction Stop
}
catch {
    Write-Host "ECHEC de la resolution DNS pour $RemoteDC. Un conditional forwarder est requis." -ForegroundColor Red
}

# =====================================================================
# 3. Informations du domaine local
# =====================================================================

Write-Host ""
Write-Host "=== 3. Informations sur le domaine local ($LocalDomain) ===" -ForegroundColor Cyan
Get-ADDomain

# =====================================================================
# 4. Documentation : commande pour ajouter un conditional forwarder
# =====================================================================

Write-Host ""
Write-Host "=== 4. Commande recommande pour creer un conditional forwarder ===" -ForegroundColor Yellow

Write-Host "Add-DnsServerConditionalForwarderZone -Name `"$RemoteDomain`" -MasterServers `"$RemoteDC_IP`" -ReplicationScope `"Forest`""

Write-Host ""
Write-Host "Cette commande n'est pas executee automatiquement." -ForegroundColor DarkYellow
Write-Host "Elle doit etre lancee une fois que l'IP DNS du domaine distant est valide." -ForegroundColor DarkYellow

# =====================================================================
# 5. Preparation du trust (verification prerequis)
# =====================================================================

<<<<<<< HEAD
Add-DnsServerConditionalForwarderZone `
 -Name "DC300098957-90.local" `
 -MasterServers 10.7.236.170 `
 -ReplicationScope Forest
#>
=======
Write-Host ""
Write-Host "=== 5. Verification preliminaire avant creation du trust ===" -ForegroundColor Cyan
Write-Host "Prerequis :" 
Write-Host "- DNS resolu dans les deux sens"
Write-Host "- Connectivite ICMP"
Write-Host "- Ports RPC/SMB/LDAP ouverts"
Write-Host "- Identifiants admin valides"
Write-Host ""

Write-Host "=== Fin du script trusts1.ps1 - Diagnostic termine ===" -ForegroundColor Green
>>>>>>> aa271641 (push du script)
