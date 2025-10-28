# --------------------------------------
# participation.ps1
# PowerShell version of participation.sh
# --------------------------------------

# Import student arrays
. ../.scripts/students.ps1

# Current date/time
$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"

# Markdown header
Write-Output "# Participation au $timestamp"
Write-Output ""

Write-Output "| Table des matières            | Description                                             |"
Write-Output "|-------------------------------|---------------------------------------------------------|"
Write-Output "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
Write-Output "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"
Write-Output ""
Write-Output ":bulb: Le mot de passe Administrateur (en Anglais) de la VM est **Infra@**:two::zero::two::four:"
Write-Output ""
Write-Output "## Légende"
Write-Output ""
Write-Output "| Signe              | Signification                 |"
Write-Output "|--------------------|-------------------------------|"
Write-Output "| :heavy_check_mark: | Prêt à être corrigé           |"
Write-Output "| :x:                | Projet inexistant             |"
Write-Output ""
Write-Output "## :a: Présence"
Write-Output ""
Write-Output "|:hash:| Boréal :id:                | :link: | :id:.md    | :rocket: |"
Write-Output "|------|----------------------------|--------|------------|----------|"

$i = 0
$s = 0

foreach ($id in $ETUDIANTS) {
    $URL = "[<image src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i])?s=460&v=4' width=20 height=20></image>](https://github.com/$($IDS[$i]))"
    $FILE = "$id/README.md"
    $server = $SERVERS[$i]

    $OK = "| $i | [$id](../$FILE) $URL | $server | :heavy_check_mark: | :heavy_check_mark: |"
    $KO_WEB = "| $i | [$id](../$FILE) $URL | $server | :heavy_check_mark: | :x: |"
    $KO = "| $i | [$id](../$FILE) $URL | $server | :x: |"

    if (Test-Path $FILE) {
        # Get Git author info for this file
        $authorCheck = git log --format=fuller -- $FILE | Select-String "Author"
        if ($authorCheck -match "noreply") {
            Write-Output $KO_WEB
        }
        else {
            Write-Output $OK
            $s++
        }
    }
    else {
        Write-Output $KO
    }

    $i++
    $COUNT = "\$\\frac{$s}{$i}$"
    $STATS = [math]::Round(($s * 100) / $i, 2)
    $SUM = "\$\displaystyle\sum_{i=1}^{$i} s_i$"
}

Write-Output "| :abacus: | $COUNT = $STATS% | | $SUM = $s |"

