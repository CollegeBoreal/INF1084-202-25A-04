<#
Script : trusts2.ps1
Objectif : Création et vérification d’un trust entre deux forêts Active Directory
Auteur : Chakib Rahmani (300150399)
Contexte : Travail en binôme – Administration Windows
Remarque :
    Ce script suppose que la résolution DNS entre les deux forêts est
    déjà fonctionnelle (conditional forwarder configuré côté DNS).
#>

# ============================
# Variables des forêts
# ============================

# Forêt locale (étudiant)
$LocalForest  = "DC300150399-00.local"

# Forêt distante (enseignant)
$RemoteForest = "DC300098957-90.local"

# Nom logique du trust (pour l’administration)
$TrustName = "Trust_DC300150399_to_DC300098957"

Write-Host "Forêt locale  : $LocalForest"
Write-Host "Forêt distante: $RemoteForest"
Write-Host "Nom du trust  : $TrustName"

# ============================
# Vérification préalable : DNS & ping
# (normalement déjà testé dans trusts1.ps1)
# ============================

Write-Host "`n[INFO] Vérification rapide de la résolution DNS..."
try {
    Resolve-DnsName $RemoteForest -ErrorAction Stop | Out-Null
    Write-Host "[OK] Résolution DNS vers $RemoteForest"
}
catch {
    Write-Host "[ERREUR] Résolution DNS échouée pour $RemoteForest"
    Write-Host "         Vérifier le conditional forwarder DNS avant de créer le trust."
}

Write-Host "`n[INFO] Test de connectivité (ping)..."
try {
    Test-Connection $RemoteForest -Count 2 -ErrorAction Stop | Out-Null
    Write-Host "[OK] Ping vers $RemoteForest réussi"
}
catch {
    Write-Host "[ATTENTION] Ping vers $RemoteForest échoué."
    Write-Host "            Le trust risque de ne pas pouvoir être établi."
}

# ============================
# Création du trust (PowerShell)
# ============================
<#
On utilise New-ADTrust pour créer un trust bidirectionnel entre les deux forêts.
Type de trust : Forest
Direction     : Bidirectional
Transitivité  : Forest transitive (utilisation typique entre deux forêts)
#>

Write-Host "`n[INFO] Création du trust bidirectionnel entre les deux forêts..."

try {
    New-ADTrust `
        -Name          $RemoteForest `
        -SourceForest  $LocalForest `
        -TargetForest  $RemoteForest `
        -TrustType     Forest `
        -Direction     Bidirectional `
        -ForestTransitive $true `
        -Confirm:$false

    Write-Host "[OK] Trust créé (commande New-ADTrust exécutée depuis la forêt locale)."
}
catch {
    Write-Host "[ERREUR] Échec lors de la création du trust."
    Write-Host "        Message : $($_.Exception.Message)"
}

# ============================
# Vérification du trust (cmdlets AD)
# ============================

Write-Host "`n[INFO] Vérification du trust côté Active Directory..."

try {
    $TrustObject = Get-ADTrust -Identity $RemoteForest -ErrorAction Stop
    Write-Host "[OK] Objet de trust trouvé dans l’AD :"
    $TrustObject | Format-List Name, TrustType, Direction, ForestTransitive
}
catch {
    Write-Host "[ERREUR] Impossible de récupérer le trust via Get-ADTrust."
    Write-Host "        Vérifier que le trust a bien été créé."
}

# ============================
# Vérification du trust (API .NET)
# ============================

Write-Host "`n[INFO] Vérification via .NET (Forest.GetCurrentForest().GetAllTrustRelationships())..."

try {
    $CurrentForest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
    $Trusts = $CurrentForest.GetAllTrustRelationships()

    $Trusts | Format-Table TargetName, Direction, TrustType

    Write-Host "`n[INFO] Filtrage sur la forêt distante :"
    $Trusts |
        Where-Object { $_.TargetName -eq $RemoteForest } |
        Format-Table TargetName, Direction, TrustType
}
catch {
    Write-Host "[ERREUR] Impossible d’interroger les trusts via l’API .NET."
    Write-Host "        Message : $($_.Exception.Message)"
}

# ============================
# Tests d’accès (à documenter dans le rapport)
# ============================
<#
Exemples de tests fonctionnels à effectuer une fois le trust établi :

1. Depuis la forêt locale :
   - Lister les trusts :
       Get-ADTrust -Filter *

2. Interroger le domaine distant (exemples génériques) :
       Get-ADDomain -Server DC300098957-90.local
       Get-ADUser -Filter * -Server DC300098957-90.local -ResultSetSize 5

3. Tester qu’un utilisateur de la forêt distante peut accéder à une ressource partagée
   dans la forêt locale (dossier partagé, etc.) après attribution des permissions.

Ces tests doivent être décrits dans le README.md (rapport court) avec captures d’écran.
#>
