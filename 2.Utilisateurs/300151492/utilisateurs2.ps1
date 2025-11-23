# ============================================
# utilisateurs2.ps1 - Exercice 2 
# Ajouter tous les stagiaires au GroupeFormation
# ============================================

# Créer la liste d'utilisateurs (COMPLÈTE)
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Thomas"; Login="tmartin"; OU="Stagiaires"},
    @{Nom="Garcia"; Prenom="Marie"; Login="mgarcia"; OU="Professeurs"},
    @{Nom="Hammiche"; Prenom="Hacen"; Login="hhammiche"; OU="Psychologue"},
    @{Nom="Rabia"; Prenom="Bouhali"; Login="brabia"; OU="Professeurs"}
)

# Créer des groupes - SOLUTION SIMPLE
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Filtrer tous les stagiaires
$Stagiaires = $Users | Where-Object {$_.OU -eq "Stagiaires"}

# Assigner directement le tableau de stagiaires
$Groups["GroupeFormation"] = $Stagiaires

# Afficher les membres du GroupeFormation
Write-Host "`n=== Membres du GroupeFormation ===" -ForegroundColor Cyan
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "  - $($_.Prenom) $($_.Nom) ($($_.Login))" -ForegroundColor Yellow
}

Write-Host "`nNombre de membres dans GroupeFormation : $($Groups['GroupeFormation'].Count)" -ForegroundColor Green
