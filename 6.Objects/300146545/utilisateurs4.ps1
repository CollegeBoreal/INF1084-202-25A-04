# ============================
# Script : utilisateurs4.ps1
# Objet : Tests finaux du TP AD
#saoudi alaoua 

$GroupName = "Students"
$Users = @("Etudiant1","Etudiant2")
$GPOName = "MapSharedFolder"

Write-Host "===== TESTS AD - TP FINAL =====" -ForegroundColor Cyan

# 1. Vérifier les utilisateurs
Write-Host "`n[1] Vérification des utilisateurs..." -ForegroundColor Yellow
foreach ($user in $Users) {
    if (Get-ADUser -Filter "SamAccountName -eq '$user'" -ErrorAction SilentlyContinue) {
        Write-Host "Utilisateur $user existe." -ForegroundColor Green
    } else {
        Write-Host "Utilisateur $user MISSING !!" -ForegroundColor Red
    }
}

# 2. Vérifier l'appartenance au groupe Students
Write-Host "`n[2] Vérification de l'appartenance au groupe Students..." -ForegroundColor Yellow
foreach ($user in $Users) {
    if (Get-ADGroupMember -Identity $GroupName | Where-Object {$_.SamAccountName -eq $user}) {
        Write-Host "$user est dans le groupe Students." -ForegroundColor Green
    } else {
        Write-Host "$user n'est PAS dans le groupe Students !" -ForegroundColor Red
    }
}

# 3. Vérifier la GPO
Write-Host "`n[3] Vérification de la GPO..." -ForegroundColor Yellow
if (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue) {
    Write-Host "La GPO $GPOName existe." -ForegroundColor Green
} else {
    Write-Host "La GPO $GPOName n'existe pas !" -ForegroundColor Red
}

# 4. Forcer l'application des GPO
Write-Host "`n[4] Forçage de l'application des GPO..." -ForegroundColor Yellow
gpupdate /force

Write-Host "`n[FIN] Tests terminés. Vérifiez maintenant RDP + lecteur réseau Z:." -ForegroundColor Cyan