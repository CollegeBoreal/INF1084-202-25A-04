<#
Script : trusts1.ps1
Objectif : Préparation et vérification avant création d’un trust Active Directory
Auteur : Chakib Rahmani (300150399)
Contexte : Travail en binôme – Administration Windows
#>

# ============================
# Variables des forêts
# ============================

# Forêt locale (étudiant)
$LocalForest = "DC300150399-00.local"

# Forêt distante (enseignant)
$RemoteForest = "lab208.collegeboreal.ca"

Write-Host "Forêt locale : $LocalForest"
Write-Host "Forêt distante : $RemoteForest"

# ============================
# Tests DNS et connectivité
# ============================

Write-Host "`nTest de résolution DNS de la forêt distante..."

try {
    Resolve-DnsName $RemoteForest
}
catch {
    Write-Host "Résolution DNS impossible pour $RemoteForest"
    Write-Host "Un conditional forwarder DNS vers la forêt distante est requis."
}

Write-Host "`nTest de connectivité réseau (ping)..."

try {
    Test-Connection $RemoteForest -Count 2
}
catch {
    Write-Host "Connexion impossible vers $RemoteForest (DNS non résolu)."
}

# ============================
# Récupération des identifiants AD distants
# ============================

Write-Host "`nDemande des identifiants administrateur de la forêt distante..."
$CredAD2 = Get-Credential -Message "Entrez les identifiants administrateur de la forêt AD distante"

# ============================
# NOTE IMPORTANTE
# ============================

<#
La création du conditional forwarder DNS vers la forêt distante
n’est pas effectuée dans ce script, car l’adresse IP du serveur DNS
de la forêt distante n’a pas été communiquée.

Commande prévue (non exécutée) :

Add-DnsServerConditionalForwarderZone `
 -Name "lab208.collegeboreal.ca" `
 -MasterServers <IP_DNS_PROF> `
 -ReplicationScope Forest
#>
