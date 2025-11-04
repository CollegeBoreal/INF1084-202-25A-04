# --------------------------------------
# participation.ps1
# PowerShell version of the Bash script
# --------------------------------------

# Import student arrays
. ../.scripts/students.ps1

# Current timestamp
$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"

# Header
Write-Output "# Participation au $timestamp"
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
Write-Output "|:hash:| Boréal :id:                | README.md    | bootstrap.ps1 | :one: | :two: | :three: | :four: |"
Write-Output "|------|----------------------------|--------------|---------------|-------|-------|---------|--------|"

$i = 0
$s = 0

foreach ($id in $ETUDIANTS) {
    $URL = "[<image src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i])?s=460&v=4' width=20 height=20></image>](https://github.com/$($IDS[$i]))"
    $FILE = "$id/README.md"
    $BOOT = "$id/bootstrap.ps1"; $OK_BOOT = ":x:"
    $USR1 = "$id/utilisateurs1.ps1"; $OK_USR1 = ":x:"
    $USR2 = "$id/utilisateurs2.ps1"; $OK_USR2 = ":x:"
    $USR3 = "$id/utilisateurs3.ps1"; $OK_USR3 = ":x:"
    $USR4 = "$id/utilisateurs4.ps1"; $OK_USR4 = ":x:"
    $KO = "| $i | [$id](../$FILE) $URL | :x: | :x: | :x: | :x: | :x: | :x: |"

    if (Test-Path $FILE) {
        $actualName = Split-Path -Leaf (Resolve-Path $FILE)
        if ($actualName -eq "README.md") {
            if (Test-Path $BOOT) { $OK_BOOT = ":hiking_boot:" }
            if (Test-Path $USR1) { $OK_USR1 = ":heavy_check_mark:" }
            if (Test-Path $USR2) { $OK_USR2 = ":heavy_check_mark:" }
            if (Test-Path $USR3) { $OK_USR3 = ":heavy_check_mark:" }
            if (Test-Path $USR4) { $OK_USR4 = ":heavy_check_mark:" }

            $FULL_OK = "| $i | [$id](../$id) $URL | [:heavy_check_mark:](../$FILE) | [$OK_BOOT](../$BOOT) | $OK_USR1 | $OK_USR2 | $OK_USR3 | $OK_USR4 |"
            Write-Output $FULL_OK
            $s++
        }
        else {
            Write-Output $KO
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

Write-Output "| :abacus: | $COUNT = $STATS% | $SUM = $s |"

