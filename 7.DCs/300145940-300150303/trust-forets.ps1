<<<<<<< HEAD
# ================================
# SCRIPT TRUST DE FORÊTS - TP INF1084
# Étudiants : Haroune & Partenaire
# ================================
=======
<# 
  trust-forets.ps1
  Groupe : 300145940 (Tasnim) - 300150303
  Projet : Relation de confiance entre deux forêts Active Directory
#>
>>>>>>> d5208504ff78280af0d2aab50e5a67bc758437a4

$LocalDomain = "DC300145940-0.local"        # TON DOMAINE
$RemoteDomain = "DC300150303-00.local"      # DOMAINE PARTENAIRE

<<<<<<< HEAD
Write-Host "=== Étape 1 : Récapitulatif ===" -ForegroundColor Cyan
Write-Host "Domaine local   : $LocalDomain"
Write-Host "Domaine distant : $RemoteDomain"
Write-Host ""

# ================================
Write-Host "=== Étape 2 : Vérification de la connectivité ===" -ForegroundColor Cyan

Write-Host "`nTest vers le DC local ($LocalDomain)..."
Test-Connection -ComputerName $LocalDomain -Count 2

Write-Host "`nTest vers le DC distant ($RemoteDomain)..."
Test-Connection -ComputerName $RemoteDomain -Count 2

# ================================
Write-Host "`n=== Étape 3 : Informations de domaines ===" -ForegroundColor Cyan

Write-Host "`nForêt locale : $LocalDomain"
Get-ADDomain

Write-Host "`nForêt distante : $RemoteDomain"
Get-ADDomain -Server $RemoteDomain

# ================================
Write-Host "`n=== Étape 4 : Création du trust de forêt bidirectionnel ===" -ForegroundColor Cyan

netdom trust $LocalDomain /Domain:$RemoteDomain /UserD:administrator /PasswordD:* /Add /TwoWay /Realm
=======
# === Paramètres des deux forêts ===
$ForestLocal   = "DC300145940-0.local"       # ta forêt
$ForestRemote  = "DC300150303-00.local"      # forêt du partenaire

$LocalDC       = "DC300145940-0"             # nom de ton DC
$RemoteDC      = "DC300150303-00"            # nom du DC partenaire

Write-Host "=== Projet : Trust entre $ForestLocal et $ForestRemote ===`n"

# ---------------------------------------------------------------------------
# Étape 1 : Demander les informations d'un compte admin de la forêt distante
# ---------------------------------------------------------------------------
Write-Host "Étape 1 : Crédentiels pour la forêt distante ($ForestRemote)..." -ForegroundColor Cyan
$credRemote = Get-Credential -Message "Entrez un compte administrateur de la forêt $ForestRemote"

# ---------------------------------------------------------------------------
# Étape 2 : Vérifier la connectivité réseau (ping) vers les deux DC
# ---------------------------------------------------------------------------
Write-Host "`nÉtape 2 : Vérification de la connectivité..." -ForegroundColor Cyan

Write-Host "Test vers le DC local ($LocalDC) :" -ForegroundColor Yellow
if (Test-Connection -ComputerName $LocalDC -Count 2 -Quiet) {
    Write-Host "  -> OK, le DC local répond au ping."
} else {
    Write-Warning "  -> ÉCHEC : le DC local ne répond pas au ping."
}

Write-Host "Test vers le DC distant ($RemoteDC) :" -ForegroundColor Yellow
$remoteReachable = Test-Connection -ComputerName $RemoteDC -Count 2 -Quiet
if ($remoteReachable) {
    Write-Host "  -> OK, le DC distant répond au ping."
} else {
    Write-Warning "  -> ÉCHEC : le DC distant ne répond pas au ping."
}

# ---------------------------------------------------------------------------
# Étape 3 : Informations de domaine pour chaque forêt
# ---------------------------------------------------------------------------
Write-Host "`nÉtape 3 : Informations de domaines..." -ForegroundColor Cyan

Write-Host "`nForêt locale : $ForestLocal" -ForegroundColor Yellow
Get-ADDomain -Server $LocalDC

Write-Host "`nForêt distante : $ForestRemote" -ForegroundColor Yellow
if ($remoteReachable) {
    try {
        Get-ADDomain -Server $RemoteDC -Credential $credRemote
    }
    catch {
        Write-Warning "Impossible de récupérer les informations du domaine distant : $($_.Exception.Message)"
    }
} else {
    Write-Warning "  -> Sauté : le DC distant n'est pas joignable."
}

# ---------------------------------------------------------------------------
# Étape 4 : (Exemple) Création du trust - à activer/adapter si demandé
# ---------------------------------------------------------------------------
Write-Host "`nÉtape 4 : Création du trust (EXEMPLE, commenté)..." -ForegroundColor Cyan
Write-Host "Le code pour New-ADTrust est laissé en commentaire pour ne pas modifier l'environnement." -ForegroundColor DarkGray

<#
New-ADTrust -Name $ForestRemote `
            -SourceForest $ForestLocal `
            -TargetForest $ForestRemote `
            -Direction Bidirectional `
            -Forest `
            -Confirm:$false
#>

# ---------------------------------------------------------------------------
# Étape 5 : Vérifier les trusts existants
# ---------------------------------------------------------------------------
Write-Host "`nÉtape 5 : Vérification des trusts existants..." -ForegroundColor Cyan
try {
    Get-ADTrust -Filter * | Format-Table Name, Direction, TrustType -AutoSize
}
catch {
    Write-Warning "Impossible de lister les trusts : $($_.Exception.Message)"
}

# ---------------------------------------------------------------------------
# Étape 6 : Créer un PSDrive pour naviguer dans la forêt distante
# ---------------------------------------------------------------------------
Write-Host "`nÉtape 6 : Navigation dans la forêt distante via PSDrive..." -ForegroundColor Cyan

if ($remoteReachable) {
    try {
        # Racine AD de la forêt distante : DC=DC300150303-00,DC=local
        New-PSDrive -Name ADPARTNER `
                    -PSProvider ActiveDirectory `
                    -Root "DC=DC300150303-00,DC=local" `
                    -Server $RemoteDC `
                    -Credential $credRemote `
                    -ErrorAction Stop | Out-Null

        Set-Location ADPARTNER:\DC=DC300150303-00,DC=local

        Write-Host "Unités organisationnelles de la forêt distante :" -ForegroundColor Yellow
        Get-ChildItem
    }
    catch {
        Write-Warning "Impossible de créer ou d'utiliser le PSDrive ADPARTNER : $($_.Exception.Message)"
    }
} else {
    Write-Warning "  -> Sauté : le DC distant n'est pas joignable."
}

# ---------------------------------------------------------------------------
# Étape 7 : Lister quelques utilisateurs de la forêt distante
# ---------------------------------------------------------------------------
Write-Host "`nÉtape 7 : Liste d'utilisateurs de la forêt distante..." -ForegroundColor Cyan

if ($remoteReachable) {
    try {
        Get-ADUser -Filter * -Server $RemoteDC -Credential $credRemote -ResultSetSize 10 |
            Select-Object Name, SamAccountName
    }
    catch {
        Write-Warning "Impossible de contacter le contrôleur de domaine distant pour Get-ADUser : $($_.Exception.Message)"
    }
} else {
    Write-Warning "  -> Sauté : le DC distant n'est pas joignable."
}

Write-Host "`nScript de vérification du trust terminé." -ForegroundColor Green
>>>>>>> d5208504ff78280af0d2aab50e5a67bc758437a4

Write-Host "`nTrust forêts terminé." -ForegroundColor Green
