# utilisateurs2.ps1
# Matricule: 300150284
$Matricule = "300150284"
$ExportDir = "C:\TP_AD_$Matricule"

# Charger $Users depuis la session ou depuis le CSV exporté
if (-not $Users) {
    $csvPath = Join-Path $ExportDir "UsersSimules_$Matricule.csv"
    if (Test-Path $csvPath) {
        $Users = Import-Csv -Path $csvPath
        Write-Host "Users importés depuis $csvPath"
    } else {
        Write-Error "Aucun tableau \$Users en session et $csvPath introuvable. Lance d'abord utilisateurs1.ps1"
        return
    }
}

# Créer la structure de groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Exercice 2 : ajouter tous les utilisateurs dont OU = "Stagiaires" dans GroupeFormation
$Groups["GroupeFormation"] = $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher membres du groupe
Write-Host "== Membres de GroupeFormation =="
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom) - $($_.Login)" }

