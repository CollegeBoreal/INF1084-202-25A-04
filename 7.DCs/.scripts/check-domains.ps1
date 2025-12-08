# --------------------------------------
# Script pour accéder aux AD DS des étudiants et générer README.md
# --------------------------------------

# Forcer UTF-8 dans tout le script
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'

# Charger la liste des VMs depuis students.ps1
. ../.scripts/students.ps1

# Vérifier que $DOMAINS et $NETBIOS existent
if (-not $DOMAINS -or -not $NETBIOS) {
    Write-Host "Les variables `$DOMAINS ou `$NETBIOS sont manquantes dans students.ps1" -ForegroundColor Red
    exit
}

# Préparer le contenu Markdown
$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"
$md = @()
$md += "# Precision au $timestamp"
$md += ""
$md += "| Table des matieres            | Description                                             |"
$md += "|-------------------------------|---------------------------------------------------------|"
$md += "| :a: [Presence](#a-presence)   | L'etudiant.e a fait son travail    :heavy_check_mark:   |"
$md += "| :b: [Precision](#b-precision) | L'etudiant.e a reussi son travail  :tada:               |"
$md += ""
$md += ":bulb: Le mot de passe Administrateur (en Anglais) de la VM est **Infra@2024**"
$md += ""
$md += "## Legende"
$md += ""
$md += "| Signe              | Signification                 |"
$md += "|--------------------|-------------------------------|"
$md += "| :heavy_check_mark: | AD DS a ete installe          |"
$md += "| :x:                | AD DS est inexistant          |"
$md += "| :no_entry:         | Acces refuse                  |"
$md += ""
$md += "## :b: Precision"
$md += ""
$md += "| :hash: | Boreal :id: | :slot_machine: VM   | :tada:   |"
$md += "|--------|-------------|---------------------|----------|"

# Initialisation des compteurs
$i = 0
$s = 0
$counter = 1

# Boucle sur chaque domaine
foreach ($tld in $DOMAINS) {

    $URL = "[<image src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i])?s=460&v=4' width=20 height=20></image>](https://github.com/$($IDS[$i]))"
    $id = $ETUDIANTS[$i]
    $FILE = "$id/README.md"

    # A-record complet
    $FQDN = "netbios.$tld"

    $VM = $FQDN

    Write-Host "Ping A-record : $FQDN ..." -ForegroundColor Cyan

    #
    # 🔵 1. Tester le A-record (PING)
    #
    $ping = Test-Connection -ComputerName $FQDN -Count 1 -Quiet

    if (-not $ping) {
        Write-Host "$FQDN ne répond pas au ping." -ForegroundColor Yellow
        $md += "| $counter | [$id](../$FILE) $URL | $VM | :x: |"

        $i++
        $counter++
        continue
    }

    #
    # 🟢 2. Tester AD DS via WinRM
    #
    try {
        $Session = New-PSSession -ComputerName $FQDN -ErrorAction Stop

        $ADStatus = Invoke-Command -Session $Session -ScriptBlock {
            (Get-WindowsFeature AD-Domain-Services).InstallState
        }

        if ($ADStatus -eq 4) {
            $statusIcon = ":heavy_check_mark:"
            $s++
        }
        else {
            $statusIcon = ":x:"
        }

        # Ajouter une ligne dans le tableau Markdown
        $md += "| $counter | [$id](../$FILE) $URL | $VM | $statusIcon |"

        Remove-PSSession $Session
    }
    catch {
        Write-Host "Échec de connexion à $FQDN : $($_.Exception.Message)" -ForegroundColor Red
        $md += "| $counter | [$id](../$FILE) $URL | $VM | :no_entry: |"
    }

    #
    # 🔢 3. Mise à jour des compteurs
    #
    $i++
    $counter++
}

# Résumé final
$COUNT = "\$\\frac{$s}{$i}$"
$STATS = [math]::Round(($s * 100) / $i, 2)
$SUM = "\$\displaystyle\sum_{i=1}^{$i} s_i$"

$md += "| :abacus: | $COUNT = $STATS% | | $SUM = $s |"

# Exporter le README.md
$md | Set-Content -Path ".scripts/Check-DOMAINS.md" -Encoding UTF8
Write-Host "README.md généré avec succès !" -ForegroundColor Green

