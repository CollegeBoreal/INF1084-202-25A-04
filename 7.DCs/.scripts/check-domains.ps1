# --------------------------------------
# Script pour vérifier les domaines étudiants et générer README.md
# --------------------------------------

# Forcer UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'

# Dot-source la fonction Safe-DnsLookup depuis check1.ps1
. .scripts/check1.ps1

# Charger la liste des VMs/domains depuis students.ps1
. ../.scripts/students.ps1

# Vérifier que $DOMAINS et $NETBIOS existent
if (-not $DOMAINS -or -not $NETBIOS) {
    Write-Host "Les variables `$DOMAINS ou `$NETBIOS sont manquantes dans students.ps1" -ForegroundColor Red
    exit
}

# Préparer le contenu Markdown
$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"
$md = @()
$md += "# Vérification des domaines au $timestamp"
$md += ""
$md += "| # | Boreal :id: | Domaine (netbios) | Résultat |"
$md += "|---|-------------|-----------------|----------|"

# Initialisation des compteurs
$i = 0
$s = 0
$counter = 1

foreach ($tld in $DOMAINS) {

    $URL = "[<image src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i])?s=460&v=4' width=20 height=20></image>](https://github.com/$($IDS[$i]))"
    $id = $ETUDIANTS[$i]
    $FILE = "$id/README.md"

    # Nom complet du netbios
    $FQDN = "netbios.$tld"

    Write-Host "Test DNS A-record : $FQDN ..." -ForegroundColor Cyan

    # 🔹 Ignorer les TLD contenant "@monboreal.ca"
    if ($tld -like "*@monboreal.ca*") {
        Write-Host "Ignoré : $tld (domaine interne)" -ForegroundColor Gray
        $md += "| $counter | [$id](../$FILE) $URL | $tld | :x: |"
    }
    else {
        # Utiliser Safe-DnsLookup pour éviter les blocages
        $dnsIP = Safe-DnsLookup $FQDN 2
        if ($dnsIP) {
            Write-Host "  ✅ A-record détecté : $dnsIP"
            $md += "| $counter | [$id](../$FILE) $URL | $FQDN | :heavy_check_mark: |"
            $s++
        } else {
            Write-Host "  ❌ Échec DNS ou timeout" -ForegroundColor Red
            $md += "| $counter | [$id](../$FILE) $URL | $FQDN | :x: |"
        }
    }

    $i++
    $counter++
}

# Résumé
$COUNT = "\$\\frac{$s}{$i}$"
$STATS = [math]::Round(($s * 100) / $i, 2)
$SUM = "\$\displaystyle\sum_{i=1}^{$i} s_i$"
$md += "| :abacus: | $COUNT = $STATS% | | $SUM = $s |"

# Exporter le README.md
$md | Set-Content -Path ".scripts/Check-DOMAINS.md" -Encoding UTF8
Write-Host "README.md généré avec succès !" -ForegroundColor Green
