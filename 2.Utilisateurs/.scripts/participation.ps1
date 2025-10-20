# --------------------------------------
# participation.ps1
# Check if each student's scripts exist AND run correctly
# --------------------------------------

# Import student arrays
. ../.scripts/students.ps1

# Timestamp
$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"

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
Write-Output "| :x:                | Projet inexistant ou échoué   |"
Write-Output "| :boom:             | Erreur d’exécution du script  |"
Write-Output ""
Write-Output "## :a: Présence"
Write-Output ""
Write-Output "|:hash:| Boréal :id:  | README.md | :one: | :two: | :three: | :four: |"
Write-Output "|------|--------------|-----------|-------|-------|---------|--------|"

$i = 0
$s = 0

foreach ($id in $ETUDIANTS) {
    $URL = "[<image src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i])?s=460&v=4' width=20 height=20></image>](https://github.com/$($IDS[$i]))"
    $FILE = "$id/README.md"

    $scripts = @(
        "$id/utilisateurs1.ps1",
        "$id/utilisateurs2.ps1",
        "$id/utilisateurs3.ps1",
        "$id/utilisateurs4.ps1"
    )

    $status = @()
    foreach ($script in $scripts) {
        if (-not (Test-Path $script)) {
            $status += ":x:"
            continue
        }

        # Try to execute the student script quietly
        try {
            pwsh -NoLogo -NoProfile -ExecutionPolicy Bypass -File $script *> $null
            if ($LASTEXITCODE -eq 0) {
                $status += ":heavy_check_mark:"
            } else {
                $status += ":boom:"  # Non-zero exit code
            }
        }
        catch {
            $status += ":boom:"  # Execution error
        }
    }

    $KO = "| $i | [$id](../$FILE) $URL | :x: | :x: | :x: | :x: | :x: |"

    if (Test-Path $FILE) {
        $actualName = Split-Path -Leaf (Resolve-Path $FILE)
        if ($actualName -eq "README.md") {
            $FULL_OK = "| $i | [$id](../$FILE) $URL | :heavy_check_mark: | $($status -join ' | ') |"
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

