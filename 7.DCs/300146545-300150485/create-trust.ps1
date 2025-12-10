<#
Script : create-trust.ps1
Objectif : Créer un trust bidirectionnel entre deux forêts Active Directory
Auteur : 300150485 & 300146545
#>

Write-Host "=== Création d'une relation de confiance entre deux forêts AD ===" -ForegroundColor Cyan

# 1️⃣ Demander les informations d'identification du domaine distant
$credAD2 = Get-Credential -Message "Entrez les identifiants administrateur de la forêt AD2"

# 2️⃣ Définir les informations des deux forêts
$DomainA = "DC300150485.local"
$DomainB = "DC300146545.local"

# 3️⃣ Vérifier la résolution DNS
Write-Host "Test DNS des deux forêts..." -ForegroundColor Yellow
Resolve-DnsName $DomainA
Resolve-DnsName $DomainB

# 4️⃣ Tester la connectivité réseau
Write-Host "Test de connectivité..." -ForegroundColor Yellow
Test-Connection -ComputerName $DomainB -Count 2
Test-Connection -ComputerName $DomainA -Count 2

# 5️⃣ Créer le trust bidirectionnel
Write-Host "Création du Trust bidirectionnel..." -ForegroundColor Green

netdom trust $DomainB `
    /Domain:$DomainA `
    /add `
    /forest `
    /twoway `
    /UserD:$($credAD2.UserName) `
    /PasswordD:$credAD2.GetNetworkCredential().Password `
    /UserO:"Administrator" `
    /PasswordO:"Infra@2024"

Write-Host "=== Trust terminé ===" -ForegroundColor Cyan
