<<<<<<< HEAD
#
Write-Host "=== 1. Récupération des informations d'accès au domaine distant ===" -ForegroundColor Cyan
=======
=== 1. Récupération des informations d'accès au domaine distant ===" -ForegroundColor Cyan
===Write-Host "=== 1. Récupération des informations d'accès au domaine distant ===" -ForegroundColor Cyan
>>>>>>> 6d359038bf4e7a5b629a3336109fa293a584dd1f

# Demande d'identifiants du domaine DC300147629-00.local
$credAD2 = Get-Credential -Message "Identifiants administrateur du domaine DC300147629-00.local requis"



Write-Host "=== 2. Test de disponibilité du contrôleur de domaine distant ===" -ForegroundColor Cyan

# Vérifie que le DC du domaine AD2 répond au ping

Test-Connection -ComputerName "DC300147629-00.local" -Count 2Write-Host "=== 1. Récupération des informations d'accès au domaine distant ===" -ForegroundColor Cyan

# Demande d'identifiants du domaine DC300147629-00.local
$credAD2 = Get-Credential -Message "Identifiants administrateur du domaine DC300147629-00.local requis"



Write-Host "=== 2. Test de disponibilité du contrôleur de domaine distant ===" -ForegroundColor Cyan

# Vérifie que le DC du domaine AD2 répond au ping
Test-Connection -ComputerName "DC300147629-00.local" -Count 2Write-Host "=== 1. Récupération des informations d'accès au domaine distant ===" -ForegroundColor Cyan

# Demande d'identifiants du domaine DC300147629-00.local
$credAD2 = Get-Credential -Message "Identifiants administrateur du domaine DC300147629-00.local requis"



Write-Host "=== 2. Test de disponibilité du contrôleur de domaine distant ===" -ForegroundCo
=======
Test-Connection -ComputerName "DC300147629-00.local" -Count 2



Write-Host "=== 3. Consultation du domaine distant ===" -ForegroundColor Cyan

# Récupère les infos structurelles du domaine
Get-ADDomain -Server "DC300147629-00.local" -Credential $credAD2 


# Affiche la liste des comptes utilisateurs du domaine AD2
Get-ADUser -Filter * -Server "DC300147629-00.local" -Credential $credAD2



Write-Host "=== 4. Exploration d'Active Directory distant via un lecteur virtuel ===" -ForegroundColor Cyan

# Ajoute un lecteur AD virtuel pointant vers AD2
New-PSDrive -Name "AD2" -PSProvider ActiveDirectory -Root "DC300147629-00.local" -Credential $credAD2 | Out-Null

# Déplacement dans la racine du domaine AD2
Set-Location "AD2:\DC=DC300147629-00,DC=local"

# Liste les objets présents dans cette arborescence
Get-ChildItem



Write-Host "=== 5. Mise en place du lien d'approbation (trust) entre les deux domaines ===" -ForegroundColor Cyan

#Création du trust Bidirectionnel
netdom TRUST "DC300147786-00.local" `
    /Domain:"DC300147629-00.local" `
    /UserO:"Administrator" `
    /PasswordO:* `
    /UserD:"Administrator" `
    /PasswordD:* `
    /Add `
    /Realm `
    /Twoway



Write-Host "=== 6. Contrôles après mise en place du trust ===" -ForegroundColor Cyan

# Validation du trust
netdom trust "DC300147786-00.local" /Domain:"DC300147629-00.local" /Verify

# Vérifie la résolution DNS
Resolve-DnsName "DC300147629-00.local"

# Affiche les trusts connus du domaine
nltest /domain_trusts


Write-Host "=== Script exécuté avec succès ===" -ForegroundColor Green
