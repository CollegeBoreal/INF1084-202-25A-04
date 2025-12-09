# Dot-sourcing pour récupérer $Users depuis utilisateurs1.ps1
Write-Host "Chargement des utilisateurs via dot-sourcing..."
. .\utilisateurs1.ps1
Write-Host "Utilisateurs chargés depuis Script 1."

# Création des groupes simulés
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

Write-Host "Groupes créés : GroupeFormation, ProfesseursAD."

# Exercice 2 : Ajouter tous les utilisateurs dont l’OU = Stagiaires
$Stagiaires = $Users | Where-Object {$_.OU -eq "Stagiaires"}

foreach ($u in $Stagiaires) {
    $Groups["GroupeFormation"] += $u
    Write-Host "Ajout de $($u.Prenom) $($u.Nom) dans GroupeFormation."
}

Write-Host "Ajout des utilisateurs dans GroupeFormation terminé."

# Affichage final
Write-Host "--- Contenu du groupe GroupeFormation ---"
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom)"
}