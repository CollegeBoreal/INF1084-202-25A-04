 
# utilisateurs4.ps1
# Objectif : Exporter et importer les utilisateurs simulés
# Version corrigée pour exécution automatique (College Boréal)

# Déterminer le dossier actuel du script (pour que les chemins soient toujours bons)
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $ScriptPath

# Importer la liste d'utilisateurs depuis utilisateurs1.ps1
if (Test-Path "$ScriptPath\utilisateurs1.ps1") {
    . "$ScriptPath\utilisateurs1.ps1"
    Write-Host "✅ utilisateurs1.ps1 importé avec succès."
} else {
    Write-Host "⚠️ Fichier utilisateurs1.ps1 introuvable."
    exit
}

# Exporter en CSV
$path = "$ScriptPath\UsersSimules.csv"
$Users | Export-Csv -Path $path -NoTypeInformation
Write-Host "📁 Fichier exporté vers $path"

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path $path
Write-Host "✅ Importation réussie :"
$ImportedUsers | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Créer un groupe ImportGroupe et y ajouter les utilisateurs importés
$Groups = @{"ImportGroupe" = @()}
$Groups["ImportGroupe"] += $ImportedUsers

Write-Host "👥 Membres du groupe ImportGroupe :"
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

Write-Host "✅ Script exécuté sans erreur."
