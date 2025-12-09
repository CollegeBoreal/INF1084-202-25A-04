# TP Objects AD - Étape 1 : Créer le dossier partagé et les utilisateurs
# Étudiant : 300150296

# Charger le bootstrap
. .\utilisateurs0.ps1

Write-Host "`n=== Création du dossier partagé ===" -ForegroundColor Green

$SharedFolder = "C:\SharedResources"

if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force
    Write-Host "Dossier créé : $SharedFolder" -ForegroundColor Cyan
}

Write-Host "`n=== Création du groupe Students ===" -ForegroundColor Green

$GroupName = "Students"
try {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access" -Path "DC=$netbiosName,DC=local" -Credential $cred -Server $domainName
    Write-Host "Groupe créé : $GroupName" -ForegroundColor Cyan
} catch {
    Write-Host "Le groupe existe déjà" -ForegroundColor Yellow
}

Write-Host "`n=== Création des utilisateurs ===" -ForegroundColor Green

$Users = @("Etudiant1", "Etudiant2")
foreach ($user in $Users) {
    try {
        New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true -Path "CN=Users,DC=$netbiosName,DC=local" -Credential $cred -Server $domainName
        Add-ADGroupMember -Identity $GroupName -Members $user -Credential $cred -Server $domainName
        Write-Host "Utilisateur créé : $user" -ForegroundColor Cyan
    } catch {
        Write-Host "Utilisateur existe déjà : $user" -ForegroundColor Yellow
    }
}

Write-Host "`n=== Création du partage SMB ===" -ForegroundColor Green

try {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
    Write-Host "Partage créé" -ForegroundColor Cyan
} catch {
    Write-Host "Le partage existe déjà" -ForegroundColor Yellow
}
