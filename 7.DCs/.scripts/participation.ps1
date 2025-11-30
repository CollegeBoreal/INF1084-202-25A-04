#!/usr/bin/env pwsh
# --------------------------------------
# PowerShell equivalent of participation.sh (with domain column)
# --------------------------------------

. ../.scripts/students.ps1

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
Write-Output "|:hash:| Boréal :id:                | README.md    | images | :globe_with_meridians: Domaines |"
Write-Output "|------|----------------------------|--------------|--------|---------------------------------|"

# Initialize counters
$i = 0
$s = 0

foreach ($id in $GROUPES) {

    $first, $second = $id -split '-'

    $first = [int]$first
    $second = [int]$second

    $i1 = [Array]::IndexOf($ETUDIANTS, $first)
    $i2 = [Array]::IndexOf($ETUDIANTS, $second)

    $URL1 = "[<image src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i1])?s=460&v=4' width=20 height=20></image>](https://github.com/$($IDS[$i1]))"

    if ($second -eq 300098957) {
       $URL2 = "[<image src='https://avatars0.githubusercontent.com/u/62551735?s=460&v=4' width=20 height=20></image>](https://github.com/b300098957)"
    }
    else {
       $URL2 = "[<image src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i2])?s=460&v=4' width=20 height=20></image>](https://github.com/$($IDS[$i2]))"
    }

    # Domaines
    $URL3 = "$($DOMAINS[$i1])"
    if ($second -eq 300098957) {
       $URL4 = "lab208.collegeboreal.ca"
    }
    else {
       $URL4 = "$($DOMAINS[$i2])"
    }

    # ---- REMPLACEMENT PAR :eyes: SI monboreal.ca ----
    if ($URL3 -match "monboreal\.ca$") { $URL3 = ":eyes:" }
    if ($URL4 -match "monboreal\.ca$") { $URL4 = ":eyes:" }

    $FILE = "$id/README.md"
    $FOLDER = "$id/images"

    $OK = "| $i | [$id](../$FILE) :point_right: $URL1 :busts_in_silhouette: $URL2 | :heavy_check_mark: | :x: | $URL3 :link: $URL4 |"
    $FULL_OK = "| $i | [$id](../$FILE) :point_right: $URL1 :busts_in_silhouette: $URL2 | :heavy_check_mark: | :heavy_check_mark: | $URL3 :link: $URL4 |"
    $KO = "| $i | [$id](../$FILE) :point_right: $URL1 :busts_in_silhouette: $URL2 | :x: | :x: | $URL3 :link: $URL4 |"
    
    if (Test-Path $FILE) {
        $ACTUAL_NAME = Split-Path -Leaf (Resolve-Path $FILE)
        if ($ACTUAL_NAME -eq "README.md") {
            if (Test-Path $FOLDER) {
                Write-Output $FULL_OK
                $s++
            }
            else {
                Write-Output $OK
            }
        }
        else {
            Write-Output $KO
        }
    }
    else {
        Write-Output $KO
    }

    $i++
    $COUNT = "\$\\frac{$s}{$i}\$"
    if ($i -gt 0) {
        $STATS = [math]::Round(($s * 100.0 / $i), 2)
    }
    else {
        $STATS = 0
    }
    $SUM = "\$\displaystyle\sum_{i=1}^{$i} s_i\$"
}

Write-Output "| :abacus: | $COUNT = $STATS% | $SUM = $s |"

