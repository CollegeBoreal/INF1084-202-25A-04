# ======================================
# Script de vérification des prérequis Trust AD
# Auteur : Hacen (300151492)
# Binôme : Mohamed (300150284)
# Date : Décembre 2025
# Cours : INF1084-202-25A-04
# ======================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "VÉRIFICATION DES PRÉREQUIS TRUST AD" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$erreurs = 0
$avertissements = 0

# ======================================
# SECTION 1: INFORMATIONS LOCALES
# ======================================
Write-Host "📋 SECTION 1: Informations de votre environnement" -ForegroundColor Yellow
Write-Host "================================================`n" -ForegroundColor Yellow

try {
    $monDomaine = Get-ADDomain
    Write-Host "✅ Domaine Active Directory:" -ForegroundColor Green
    Write-Host "   • Nom DNS: $($monDomaine.DNSRoot)" -ForegroundColor White
    Write-Host "   • Nom NetBIOS: $($monDomaine.NetBIOSName)" -ForegroundColor White
    Write-Host "   • Forêt: $($monDomaine.Forest)" -ForegroundColor White
    Write-Host "   • Niveau fonctionnel: $($monDomaine.DomainMode)" -ForegroundColor White
} catch {
    Write-Host "❌ ERREUR: Impossible de récupérer les infos du domaine" -ForegroundColor Red
    $erreurs++
}

Write-Host "`n✅ Contrôleur de domaine:" -ForegroundColor Green
$monDC = $env:COMPUTERNAME
$monDCFQDN = "$monDC.$($monDomaine.DNSRoot)"
Write-Host "   • Nom court: $monDC" -ForegroundColor White
Write-Host "   • FQDN: $monDCFQDN" -ForegroundColor White

# ======================================
# SECTION 2: CONFIGURATION RÉSEAU
# ======================================
Write-Host "`n📡 SECTION 2: Configuration réseau" -ForegroundColor Yellow
Write-Host "================================================`n" -ForegroundColor Yellow

$adapters = Get-NetIPAddress -AddressFamily IPv4 | Where-Object {
    $_.InterfaceAlias -notlike "*Loopback*" -and 
    $_.IPAddress -notlike "169.254.*"
}

if ($adapters) {
    Write-Host "✅ Adaptateurs réseau configurés:" -ForegroundColor Green
    foreach ($adapter in $adapters) {
        Write-Host "   • Interface: $($adapter.InterfaceAlias)" -ForegroundColor White
        Write-Host "     IP: $($adapter.IPAddress)" -ForegroundColor White
        Write-Host "     Préfixe: /$($adapter.PrefixLength)" -ForegroundColor White
    }
    $monIP = $adapters[0].IPAddress
} else {
    Write-Host "❌ ERREUR: Aucun adapteur réseau valide trouvé" -ForegroundColor Red
    $erreurs++
    $monIP = "NON_CONFIGURÉ"
}

# Passerelle par défaut
$gateway = Get-NetRoute -AddressFamily IPv4 | Where-Object {$_.DestinationPrefix -eq "0.0.0.0/0"}
if ($gateway) {
    Write-Host "`n✅ Passerelle par défaut: $($gateway.NextHop)" -ForegroundColor Green
} else {
    Write-Host "`n⚠️  ATTENTION: Pas de passerelle par défaut configurée" -ForegroundColor Yellow
    $avertissements++
}

# ======================================
# SECTION 3: CONFIGURATION DNS
# ======================================
Write-Host "`n🔍 SECTION 3: Configuration DNS" -ForegroundColor Yellow
Write-Host "================================================`n" -ForegroundColor Yellow

$dnsServers = Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {
    $_.InterfaceAlias -notlike "*Loopback*"
}

if ($dnsServers) {
    Write-Host "✅ Serveurs DNS configurés:" -ForegroundColor Green
    foreach ($dns in $dnsServers) {
        if ($dns.ServerAddresses) {
            Write-Host "   • Interface: $($dns.InterfaceAlias)" -ForegroundColor White
            Write-Host "     Serveurs: $($dns.ServerAddresses -join ', ')" -ForegroundColor White
        }
    }
} else {
    Write-Host "❌ ERREUR: Aucun serveur DNS configuré" -ForegroundColor Red
    $erreurs++
}

# Test de résolution DNS locale
Write-Host "`n🧪 Test de résolution DNS locale:" -ForegroundColor Cyan
try {
    $testLocal = Resolve-DnsName $monDomaine.DNSRoot -ErrorAction Stop
    Write-Host "✅ Résolution de $($monDomaine.DNSRoot) réussie" -ForegroundColor Green
} catch {
    Write-Host "❌ ERREUR: Impossible de résoudre votre propre domaine" -ForegroundColor Red
    $erreurs++
}

# ======================================
# SECTION 4: SERVICES ACTIVE DIRECTORY
# ======================================
Write-Host "`n⚙️  SECTION 4: Services Active Directory" -ForegroundColor Yellow
Write-Host "================================================`n" -ForegroundColor Yellow

$servicesAD = @(
    @{Nom="ADWS"; Description="Active Directory Web Services"},
    @{Nom="DNS"; Description="DNS Server"},
    @{Nom="Netlogon"; Description="Netlogon"},
    @{Nom="NTDS"; Description="Active Directory Domain Services"},
    @{Nom="KDC"; Description="Kerberos Key Distribution Center"}
)

foreach ($svc in $servicesAD) {
    $service = Get-Service -Name $svc.Nom -ErrorAction SilentlyContinue
    if ($service) {
        if ($service.Status -eq "Running") {
            Write-Host "✅ $($svc.Description) ($($svc.Nom)): En cours d'exécution" -ForegroundColor Green
        } else {
            Write-Host "❌ $($svc.Description) ($($svc.Nom)): ARRÊTÉ" -ForegroundColor Red
            $erreurs++
        }
    } else {
        Write-Host "⚠️  $($svc.Description) ($($svc.Nom)): Service non trouvé" -ForegroundColor Yellow
        $avertissements++
    }
}

# ======================================
# SECTION 5: CONNECTIVITÉ INTERNET
# ======================================
Write-Host "`n🌐 SECTION 5: Connectivité Internet" -ForegroundColor Yellow
Write-Host "================================================`n" -ForegroundColor Yellow

Write-Host "🧪 Test de connectivité vers Internet (Google DNS):" -ForegroundColor Cyan
try {
    $testInternet = Test-Connection -ComputerName 8.8.8.8 -Count 2 -ErrorAction Stop
    Write-Host "✅ Internet accessible (ping vers 8.8.8.8 réussi)" -ForegroundColor Green
    Write-Host "   Temps de réponse moyen: $([math]::Round(($testInternet | Measure-Object ResponseTime -Average).Average))ms" -ForegroundColor White
} catch {
    Write-Host "⚠️  ATTENTION: Pas d'accès Internet détecté" -ForegroundColor Yellow
    Write-Host "   (Ceci peut être normal selon votre configuration réseau)" -ForegroundColor Gray
    $avertissements++
}

Write-Host "`n🧪 Test de résolution DNS externe (github.com):" -ForegroundColor Cyan
try {
    $testDnsExt = Resolve-DnsName github.com -ErrorAction Stop
    Write-Host "✅ Résolution DNS externe fonctionne" -ForegroundColor Green
} catch {
    Write-Host "⚠️  ATTENTION: Résolution DNS externe échouée" -ForegroundColor Yellow
    $avertissements++
}

# ======================================
# SECTION 6: PRÉPARATION POUR MOHAMED
# ======================================
Write-Host "`n👥 SECTION 6: Configuration pour Mohamed" -ForegroundColor Yellow
Write-Host "================================================`n" -ForegroundColor Yellow

Write-Host "📋 Informations à envoyer à Mohamed (300150284):`n" -ForegroundColor Cyan

$infosAEnvoyer = @"
================================
MES INFORMATIONS (Hacen - 300151492)
================================

🏷️  DOMAINE:
   • Nom DNS: $($monDomaine.DNSRoot)
   • Nom NetBIOS: $($monDomaine.NetBIOSName)

🖥️  CONTRÔLEUR DE DOMAINE:
   • Nom court: $monDC
   • FQDN: $monDCFQDN

📡 RÉSEAU:
   • Adresse IP: $monIP

🔧 COMMANDES POUR MOHAMED:
   Il doit configurer son DNS pour pointer vers mon domaine:
   
   Add-DnsServerConditionalForwarderZone -Name "$($monDomaine.DNSRoot)" -MasterServers $monIP

================================
"@

Write-Host $infosAEnvoyer -ForegroundColor White

# ======================================
# SECTION 7: TEST VERS MOHAMED
# ======================================
Write-Host "`n🔗 SECTION 7: Test de connectivité vers Mohamed" -ForegroundColor Yellow
Write-Host "================================================`n" -ForegroundColor Yellow

Write-Host "⚠️  Pour tester la connexion avec Mohamed, j'ai besoin de ses informations:" -ForegroundColor Yellow
Write-Host "`nEntrez les informations de Mohamed (ou appuyez sur Entrée pour passer):" -ForegroundColor Cyan

$domaineMohamed = Read-Host "Domaine de Mohamed (ex: DC300150284-00.local)"
if ($domaineMohamed) {
    Write-Host "`n🧪 Test de résolution DNS vers le domaine de Mohamed..." -ForegroundColor Cyan
    try {
        $testMohamed = Resolve-DnsName $domaineMohamed -ErrorAction Stop
        Write-Host "✅ Domaine de Mohamed résolu avec succès!" -ForegroundColor Green
        Write-Host "   Adresse(s) IP: $($testMohamed.IPAddress -join ', ')" -ForegroundColor White
        
        # Test ping
        Write-Host "`n🧪 Test ping vers le domaine de Mohamed..." -ForegroundColor Cyan
        try {
            $pingMohamed = Test-Connection -ComputerName $domaineMohamed -Count 2 -ErrorAction Stop
            Write-Host "✅ Ping réussi vers Mohamed!" -ForegroundColor Green
            Write-Host "   IP: $($pingMohamed[0].IPV4Address)" -ForegroundColor White
            Write-Host "   Temps: $($pingMohamed[0].ResponseTime)ms" -ForegroundColor White
        } catch {
            Write-Host "⚠️  Ping échoué (le firewall peut bloquer le ping)" -ForegroundColor Yellow
            $avertissements++
        }
        
    } catch {
        Write-Host "❌ Impossible de résoudre le domaine de Mohamed" -ForegroundColor Red
        Write-Host "   Mohamed doit d'abord configurer son DNS!" -ForegroundColor Yellow
        $erreurs++
    }
} else {
    Write-Host "ℹ️  Test vers Mohamed ignoré (entrez ses infos plus tard)" -ForegroundColor Gray
}

# ======================================
# SECTION 8: VÉRIFICATION DES TRUSTS EXISTANTS
# ======================================
Write-Host "`n🔐 SECTION 8: Trusts Active Directory existants" -ForegroundColor Yellow
Write-Host "================================================`n" -ForegroundColor Yellow

try {
    $trusts = Get-ADTrust -Filter * -ErrorAction Stop
    if ($trusts) {
        Write-Host "⚠️  ATTENTION: Des trusts existent déjà!" -ForegroundColor Yellow
        $trusts | Select-Object Name, Direction, TrustType, Created | Format-Table -AutoSize
        $avertissements++
    } else {
        Write-Host "✅ Aucun trust existant (configuration propre)" -ForegroundColor Green
    }
} catch {
    Write-Host "ℹ️  Impossible de vérifier les trusts (peut être normal)" -ForegroundColor Gray
}

# ======================================
# SECTION 9: RÉSUMÉ ET RECOMMANDATIONS
# ======================================
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "RÉSUMÉ DE LA VÉRIFICATION" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if ($erreurs -eq 0 -and $avertissements -eq 0) {
    Write-Host "✅✅✅ PARFAIT! Votre système est prêt pour le Trust!" -ForegroundColor Green
} elseif ($erreurs -eq 0) {
    Write-Host "✅ Système fonctionnel avec $avertissements avertissement(s)" -ForegroundColor Yellow
} else {
    Write-Host "❌ $erreurs erreur(s) critique(s) et $avertissements avertissement(s)" -ForegroundColor Red
}

Write-Host "`n📊 Statistiques:" -ForegroundColor Cyan
Write-Host "   • Erreurs critiques: $erreurs" -ForegroundColor $(if($erreurs -gt 0){"Red"}else{"Green"})
Write-Host "   • Avertissements: $avertissements" -ForegroundColor $(if($avertissements -gt 0){"Yellow"}else{"Green"})

Write-Host "`n📋 PROCHAINES ÉTAPES:" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

if ($erreurs -gt 0) {
    Write-Host "`n❌ CORRIGER D'ABORD LES ERREURS CI-DESSUS!" -ForegroundColor Red
}

Write-Host "`n1️⃣  Envoyez vos informations à Mohamed:" -ForegroundColor Yellow
Write-Host "   • Copiez les informations de la Section 6" -ForegroundColor White

Write-Host "`n2️⃣  Demandez à Mohamed de:" -ForegroundColor Yellow
Write-Host "   • Configurer son IP réseau" -ForegroundColor White
Write-Host "   • Configurer son DNS vers votre domaine" -ForegroundColor White
Write-Host "   • Vous envoyer ses informations" -ForegroundColor White

Write-Host "`n3️⃣  Une fois que Mohamed a configuré:" -ForegroundColor Yellow
Write-Host "   • Configurez votre DNS vers son domaine" -ForegroundColor White
Write-Host "   • Relancez ce script pour vérifier la connectivité" -ForegroundColor White

Write-Host "`n4️⃣  Quand tout est vert:" -ForegroundColor Yellow
Write-Host "   • Exécutez le script: .\creer-trust.ps1" -ForegroundColor White

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "FIN DE LA VÉRIFICATION" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Sauvegarder les informations dans un fichier
$outputFile = "verification-prereqs-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"
$infosAEnvoyer | Out-File $outputFile
Write-Host "💾 Vos informations ont été sauvegardées dans: $outputFile" -ForegroundColor Cyan