# --------------------------------------
# Script pour tester les partages SMB étudiants avec montage temporaire
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
$Creds = New-Object System.Management.Automation.PSCredential ($etudiant, $Password)


# Préparer le Markdown
$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"
$md = @()
$md += "# Precision au $timestamp"
$md += ""
$md += "| Table des matieres            | Description                                             |"
$md += "|-------------------------------|---------------------------------------------------------|"
$md += "| :a: [Presence](#a-presence)   | L'etudiant.e a fait son travail    :heavy_check_mark:   |"
$md += "| :b: [Precision](#b-precision) | L'etudiant.e a reussi son travail  :tada:               |"
$md += ""
$md += ":bulb: Le mot de passe de ***Etudiant1*** est ***Press123!***"
$md += ""
$md += "## Legende"
$md += ""
$md += "| Signe              | Signification                 |"
$md += "|--------------------|-------------------------------|"
$md += "| :heavy_check_mark: | AD DS et repertoire OK         |"
$md += "| :x:                | AD DS ou repertoire inexistant |"
$md += "| :no_entry:         | Acces refuse - pwd incorrect   |"
$md += "| :warning:          | Acces refuse - pwd a changer   |"
$md += ""
$md += "## :b: Precision"
$md += ""
$md += "| :hash: | Boreal :id: | VM/Serveur | Partage SMB | Statut |"
$md += "|--------|-------------|------------|-------------|--------|"

# Boucle sur chaque étudiant
$counter = 1
for ($i = 0; $i -lt $ETUDIANTS.Count; $i++) {

    $URL = "[<image src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i])?s=460&v=4' width=20 height=20></image>](https://github.com/$($IDS[$i]))"    
    $id = $ETUDIANTS[$i]
    $FILE = "$id/README.md"

    $vm = $SERVERS[$i]
    Write-Host "Test SMB pour $etudiant sur $sharePath ..." -ForegroundColor Cyan

    # Chemin SMB et lecteur temporaire
    $sharePath = "\\$vm\SharedResources"
    $driveName = "S"  # Lettre temporaire, peut être dynamique si besoin

    try {
        # Monter le partage SMB temporairement
        New-PSDrive -Name $driveName -PSProvider FileSystem -Root $sharePath -Credential $Creds -ErrorAction Stop | Out-Null

        # Vérifier l'accès correctement
        if (Test-Path "$($driveName):\") { $statusIcon = ":heavy_check_mark:" }
        Remove-PSDrive -Name $driveName
    }
    catch {
        if ($_.Exception.Message -match "password is not correct|incorrect") { $statusIcon = ":no_entry:" }
        elseif ($_.Exception.Message -match "must be changed") { $statusIcon = ":warning:" }
        elseif ($_.Exception.Message -match "cannot be found") { $statusIcon = ":x:" }
        else { $statusIcon = ":no_entry:" }
    }


    # Ajouter la ligne au Markdown
    $md += "| $counter | [$id](../$FILE) $URL  | $vm | $sharePath | $statusIcon |"
    $counter++
}

# Exporter le Markdown dans Check.md
$md | Set-Content -Path ".scripts/Check.md" -Encoding UTF8
Write-Host "Check.md généré avec succès !" -ForegroundColor Green
