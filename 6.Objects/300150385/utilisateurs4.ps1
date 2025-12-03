# ============================================
# Script : utilisateurs4.ps1
# Objectif : Tests finaux du TP (AD, GPO, RDP, Partage)
# Étudiant : Belkacem Medjkoune - 300150385
# ============================================

# Variables globales
$GroupName = "Students"
$Users = @("Etudiant1","Etudiant2")
$GPOName = "MapSharedFolder"

Write-Host "===== Vérifications finales du TP Active Directory =====" -ForegroundColor Cyan

# --- 1. Vérification de l'existence des utilisateurs ---
Write-Host "`n[1] Contrôle des comptes utilisateurs..." -ForegroundColor Yellow

foreach ($user in $Users) {
    $UserObj = Get-ADUser -Filter "SamAccountName -eq '$user'" -ErrorAction SilentlyContinue
    if ($UserObj) {
        Write-Host "✔ Utilisateur trouvé : $user" -ForegroundColor Green
    }
    else {
        Write-Host "✘ Utilisateur manquant : $user" -ForegroundColor Red
    }
}

# --- 2. Vérification de l'appartenance au groupe Students ---
Write-Host "`n[2] Vérification des membres du groupe Students..." -ForegroundColor Yellow

$GroupMembers = Get-ADGroupMember -Identity $GroupName -ErrorAction SilentlyContinue

foreach ($user in $Users) {
    if ($GroupMembers | Where-Object { $_.SamAccountName -eq $user }) {
        Write-Host "✔ $user appartient bien au groupe $GroupName" -ForegroundColor Green
    }
    else {
        Write-Host "✘ $user n'est PAS dans le groupe $GroupName" -ForegroundColor Red
    }
}

# --- 3. Vérification de la présence de la GPO ---
Write-Host "`n[3] Vérification de la GPO configurée..." -ForegroundColor Yellow

$CheckGPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue

if ($CheckGPO) {
    Write-Host "✔ La GPO '$GPOName' est présente dans le domaine." -ForegroundColor Green
}
else {
    Write-Host "✘ La GPO '$GPOName' est introuvable !" -ForegroundColor Red
}

# --- 4. Application des stratégies de groupe ---
Write-Host "`n[4] Forçage de l'application des GPO..." -ForegroundColor Yellow

gpupdate /force | Out-Null

Write-Host "`n✔ Mise à jour des stratégies terminée." -ForegroundColor Green

# --- Conclusion ---
Write-Host "`n===== FIN DU SCRIPT =====" -ForegroundColor Cyan
Write-Host "Veuillez maintenant vérifier :" -ForegroundColor White
Write-Host " • La présence du lecteur réseau Z:" -ForegroundColor White
Write-Host " • La connexion RDP pour les utilisateurs du groupe Students" -ForegroundColor White
