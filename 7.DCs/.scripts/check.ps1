# --------------------------------------
# Script pour accéder aux AD DS des étudiants et générer README.md + log global
# --------------------------------------

# Forcer UTF-8
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
$i       = 0
$s       = 0      # total AD DS OK
$counter = 1

# Créer le dossier logs si absent
if (-not (Test-Path "./logs")) { New-Item -ItemType Directory -Path "./logs" | Out-Null }
$allLogFile = "./logs/nltest_all.txt"

# Vider le log global au départ
"" | Set-Content -Path $allLogFile

# Boucle sur chaque VM
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
        $nltestResult = Invoke-Command -Session $Session -ScriptBlock {
            try {
                $output = nltest /domain_trusts 2>&1
                $exit   = $LASTEXITCODE
                return [PSCustomObject]@{
                    ExitCode = $exit
                    Output   = $output -join "`n"
                }
            }
            catch {
                return [PSCustomObject]@{
                    ExitCode = -1
                    Output   = "Erreur: $($_.Exception.Message)"
                }
            }
        }

        # Ajouter la sortie au log global
        Add-Content -Path $allLogFile -Value "===== NLTEST $VM ($id) ====="
        Add-Content -Path $allLogFile -Value $nltestResult.Output
        Add-Content -Path $allLogFile -Value "`n"

        # Affichage console
        Write-Host "`n--- SORTIE NLTEST de $VM ---" -ForegroundColor Yellow
        Write-Host $nltestResult.Output -ForegroundColor Gray
        Write-Host "--------------------------------------`n"

        # Déterminer statut pour Markdown
        # Test réussi si au moins une ligne contient (MIT) + (Direct Outbound) + (Direct Inbound)
        $foundMIT = $nltestResult.Output -split "`n" | Where-Object {
            $_ -match "\(MIT\)" -and $_ -match "\(Direct Outbound\)" -and $_ -match "\(Direct Inbound\)"
        }

        $statusIcon = if ($foundMIT.Count -ge 1) {
            $s++
            ":heavy_check_mark:"
        }
        else {
            ":x:"
        }

        # Ajouter la ligne Markdown
        $md += "| $counter | [$id](../$FILE) $githubAvatar | $VM | $statusIcon |"

        Remove-PSSession $Session
    }
    catch {
        Write-Host "Échec de connexion à $VM : $($_.Exception.Message)" -ForegroundColor Red

        $md += "| $counter | [$id](../$FILE) $githubAvatar | $VM | :no_entry: |"

        # Log erreur globale
        Add-Content -Path $allLogFile -Value "===== ERREUR $VM ($id) ====="
        Add-Content -Path $allLogFile -Value "Erreur de connexion WinRM : $($_.Exception.Message)"
        Add-Content -Path $allLogFile -Value "`n"
    }

    $i++
    $counter++
}

# Statistiques finales
$COUNT = "\$\\frac{$s}{$i}$"
$STATS = [math]::Round(($s * 100) / $i, 2)
$SUM   = "\$\displaystyle\sum_{i=1}^{$i} s_i$"

$md += "| :abacus: | $COUNT = $STATS% | | $SUM = $s |"

# Export Markdown
$md | Set-Content -Path ".scripts/Check.md" -Encoding UTF8

Write-Host "`nREADME.md généré avec succès !" -ForegroundColor Green
Write-Host "Log global des résultats : $allLogFile" -ForegroundColor Green

