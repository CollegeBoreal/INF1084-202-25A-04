#!/usr/bin/env pwsh
# --------------------------------------
# PowerShell version of participation.sh
# --------------------------------------

# Import student arrays from PowerShell script
. .scripts/students.ps1

# Header
Write-Output "# Participation au $(Get-Date -Format 'dd-MM-yyyy HH:mm')"
Write-Output ""

Write-Output "| Table des matières            | Description                                             |"
Write-Output "|-------------------------------|---------------------------------------------------------|"
Write-Output "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
Write-Output "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"
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
Write-Output "|:hash:| Boréal :id:                | :id:.md    | :rocket: |"
Write-Output "|------|----------------------------|------------|----------|"

# Initialize counters
$i = 0
$s = 0  # Success counter

# Loop through each student
foreach ($id in $ETUDIANTS) {

    $URL = "[{0}](https://github.com/{0}) <image src='https://avatars0.githubusercontent.com/u/{1}?s=460&v=4' width=20 height=20></image>" -f $IDS[$i], $AVATARS[$i]
    $FILE = "$id.md"

    $OK     = "| $i | [$id](../$FILE) :point_right: $URL | :heavy_check_mark: | :heavy_check_mark: |"
    $KO_WEB = "| $i | [$id](../$FILE) :point_right: $URL | :heavy_check_mark: | :x: |"
    $KO     = "| $i | [$id](../$FILE) :point_right: $URL | :x: |"

    if (Test-Path $FILE) {
        # Get git log info for this file
        $log = git log --format=fuller -- $FILE 2>$null

        if ($log -match 'Author:.*noreply') {
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

    # Compute live stats (like Bash bc)
    if ($i -gt 0) {
        $STATS = [math]::Round(($s * 100.0 / $i), 2)
    }
    else {
        $STATS = 0
    }

    $COUNT = "\$\\frac{$s}{$i}\$"
    $SUM   = "\$\displaystyle\sum_{i=1}^{$i} s_i\$"
}

Write-Output "| :abacus: | $COUNT = $STATS% | $SUM = $s |"

