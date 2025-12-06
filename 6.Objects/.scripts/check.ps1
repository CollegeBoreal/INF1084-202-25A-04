# --------------------------------------
# Script pour tester les partages SMB étudiants + WinRM (auth)
# --------------------------------------

# Forcer UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'

# Charger la liste des étudiants et serveurs depuis students.ps1
. ../.scripts/students.ps1

if (-not $SERVERS -or -not $ETUDIANTS) {
    Write-Host "Les variables `$SERVERS ou `$ETUDIANTS n'ont pas été trouvées dans students.ps1" -ForegroundColor Red
    exit
}

# Identifiants de l'étudiant
$etudiant = "Etudiant1"
$plainPassword = "Pass123!"  # changer si chaque étudiant a un mot de passe différent
$Password = ConvertTo-SecureString $plainPassword -AsPlainText -Force
$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"

# Préparer le Markdown
$md = @()
$md += "# Precision au $timestamp"
$md += ""
$md += "| Table des matieres            | Description                                             |"
$md += "|-------------------------------|---------------------------------------------------------|"
$md += "| :a: [Presence](#a-presence)   | L'etudiant.e a fait son travail    :heavy_check_mark:   |"
$md += "| :b: [Precision](#b-precision) | L'etudiant.e a reussi son travail  :tada:               |"
$md += ""
$md += ":bulb: Le mot de passe de ***Etudiant1*** est ***Pass123!***"
$md += ""
$md += "## Legende"
$md += ""
$md += "| Signe              | Signification                    |"
$md += "|--------------------|----------------------------------|"
$md += "| :heavy_check_mark: | Accès OK                          |"
$md += "| :x:                | Service désactivé / ressource off |"
$md += "| :no_entry:         | Acces refuse / host down          |"
$md += "| :warning:          | Mot de passe à changer            |"
$md += ""
$md += "## :b: Precision"
$md += ""
$md += "| :hash: | Boreal :id: | Partage SMB | WinRM (auth) | Statut SMB |"
$md += "|--------|-------------|--------------|---------------|-------------|"

# Boucle sur chaque étudiant
$counter = 1
for ($i = 0; $i -lt $ETUDIANTS.Count; $i++) {

    $URL = "[<image src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i])?s=460&v=4' width=20 height=20></image>](https://github.com/$($IDS[$i]))"    
    $id = $ETUDIANTS[$i]
    $FILE = "$id/README.md"
    $vm = $SERVERS[$i]

    Write-Host "Test pour $id sur $vm..." -ForegroundColor Cyan

    # ------------------------------
    # Test WinRM (auth complète)
    # ------------------------------
    $rdpUser = "$($NETBIOS[$i])\$etudiant"
    $CredsRDP = New-Object System.Management.Automation.PSCredential ($rdpUser, $Password)

    try {
        $null = Test-WSMan -ComputerName $vm -Credential $CredsRDP -Authentication Negotiate -ErrorAction Stop
        $winrmIcon = ":heavy_check_mark:"      # Auth OK
    }
    catch {
        $msg = $_.Exception.Message

        if ($msg -match "Access is denied") {
            $winrmIcon = ":no_entry:"           # mauvais mot de passe ou droits
        }
        elseif ($msg -match "WinRM cannot process the request") {
            $winrmIcon = ":x:"                  # WinRM désactivé
        }
        elseif ($msg -match "not found|unreachable|could not be resolved") {
            $winrmIcon = ":no_entry:"           # Host down
        }
        else {
            $winrmIcon = ":x:"                  # Autre erreur
        }
    }

    # ------------------------------
    # Test SMB
    # ------------------------------
    $sharePath = "\\$vm\SharedResources"
    $CredsSMB = New-Object System.Management.Automation.PSCredential ($etudiant, $Password)
    $driveName = "S"

    try {
        New-PSDrive -Name $driveName -PSProvider FileSystem -Root $sharePath -Credential $CredsSMB -ErrorAction Stop | Out-Null

        if (Test-Path "$($driveName):\") { 
            $statusIcon = ":heavy_check_mark:" 
        }

        Remove-PSDrive -Name $driveName -ErrorAction SilentlyContinue
    }
    catch {
        if ($_.Exception.Message -match "password is not correct|incorrect") { 
            $statusIcon = ":no_entry:" 
        }
        elseif ($_.Exception.Message -match "must be changed") { 
            $statusIcon = ":warning:" 
        }
        elseif ($_.Exception.Message -match "cannot be found") { 
            $statusIcon = ":x:" 
        }
        else { 
            $statusIcon = ":no_entry:" 
        }
    }

    # ------------------------------
    # Ligne Markdown
    # ------------------------------
    $md += "| $counter | [$id](../$FILE) $URL | \\\\$vm\\SharedResources | $winrmIcon | $statusIcon |"
    $counter++
}

# Exporter le Markdown dans Check.md
$md | Set-Content -Path ".scripts/Check.md" -Encoding UTF8
Write-Host "Check.md généré avec succès !" -ForegroundColor Green
