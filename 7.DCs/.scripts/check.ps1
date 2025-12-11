# --------------------------------------
# Script pour accéder aux AD DS des étudiants et générer README.md
# --------------------------------------

# Forcer UTF-8 dans le script
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'

# Autoriser toutes les IP WinRM
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "10.7.236.*" -Force

# Charger la liste des VMs depuis students.ps1
. ../.scripts/students.ps1

if (-not $SERVERS) {
    Write-Host "La variable `$SERVERS n’a pas été trouvée." -ForegroundColor Red
    exit
}

# Identifiants
$User = "Administrator"
$Password = ConvertTo-SecureString 'Infra@2024' -AsPlainText -Force
$Credential = New-Object PSCredential ($User, $Password)

# Préparer le README en mémoire
$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"
$md = @()
$md += "# Precision au $timestamp"
$md += ""
$md += "| Table des matieres            | Description                                             |"
$md += "|-------------------------------|---------------------------------------------------------|"
$md += "| :a: [Presence](#a-presence)   | L'étudiant.e a fait son travail :heavy_check_mark:      |"
$md += "| :b: [Precision](#b-precision) | AD DS installé et trust fonctionnel :tada:              |"
$md += ""
$md += ":bulb: Le mot de passe Administrateur de la VM est **Infra@2024**"
$md += ""
$md += "## Legende"
$md += ""
$md += "| Signe              | Signification                 |"
$md += "|--------------------|-------------------------------|"
$md += "| :heavy_check_mark: | AD DS présent                 |"
$md += "| :x:                | AD DS absent                  |"
$md += "| :no_entry:         | Accès refusé / ERREUR         |"
$md += ""
$md += "## :b: Precision"
$md += ""
$md += "| :hash: | Boreal :id: | :slot_machine: VM   | :tada: |"
$md += "|--------|-------------|---------------------|--------|"

# Compteurs
$i     = 0
$s     = 0      # total AD DS OK
$counter = 1

foreach ($VM in $SERVERS) {

    $githubAvatar = "[<img src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i])?s=30&v=4' width=20 height=20>](" +
                    "https://github.com/$($IDS[$i]))"

    $id   = $ETUDIANTS[$i]
    $FILE = "$id/README.md"

    Write-Host "`nConnexion à $VM ..." -ForegroundColor Cyan

    try {
        # Connexion WinRM
        $Session = New-PSSession -ComputerName $VM -Credential $Credential -ErrorAction Stop

        # Vérifier AD DS via nltest
        $ADStatus = Invoke-Command -Session $Session -ScriptBlock {
            try {
                $null = nltest /domain_trusts 2>$null
                if ($LASTEXITCODE -eq 0) { return 1 } else { return -1 }
            }
            catch { return -1 }
        }

        # Statut OK si ADStatus ≠ -1
        $statusIcon = if ($ADStatus -ne -1) {
            $s++
            ":heavy_check_mark:"
        }
        else {
            ":x:"
        }

        # Ligne Markdown
        $md += "| $counter | [$id](../$FILE) $githubAvatar | $VM | $statusIcon |"

        Remove-PSSession $Session
    }
    catch {
        Write-Host "Échec de connexion à $VM : $($_.Exception.Message)" -ForegroundColor Red
        $md += "| $counter | [$id](../$FILE) $githubAvatar | $VM | :no_entry: |"
    }

    $i++
    $counter++
}

# Statistiques finales
$COUNT = "\$\\frac{$s}{$i}$"
$STATS = [math]::Round(($s * 100) / $i, 2)
$SUM   = "\$\displaystyle\sum_{i=1}^{$i} s_i$"

$md += "| :abacus: | $COUNT = $STATS% | | $SUM = $s |"

# Export
$md | Set-Content -Path ".scripts/Check.md" -Encoding UTF8

Write-Host "`nREADME.md généré avec succès !" -ForegroundColor Green

