###############################################
# SCRIPT : Vérification Trust AD1 <-> AD2
# Auteur : Ton équipe 300141368-300153747
# Objectif : Vérifier la relation de confiance
###############################################

Write-Host "=== Vérification du Trust entre les deux forêts ===" -ForegroundColor Cyan

# --- a. Identifiants AD2 ---
Write-Host "`nÉtape 1 : Entrer les identifiants AD2..."
$credAD2 = Get-Credential -Message "Entrez le compte administrateur de AD2 (DC30014368-00)"

# --- b. Test de connectivité ---
Write-Host "`nÉtape 2 : Test de connectivité vers DC2..."
Test-Connection -ComputerName dc300141368-00.local -Count 2

# --- c. Interroger AD2 ---
Write-Host "`nÉtape 3 : Informations sur le domaine AD2..."
Get-ADDomain -Server dc300141368-00.local -Credential $credAD2

Write-Host "`nÉtape 4 : Liste des utilisateurs AD2..."
Get-ADUser -Filter * -Server dc300153747-00.local -Credential $credAD2 | Select Name, SamAccountName

# --- d. Naviguer dans AD2 via PSDrive ---
Write-Host "`nÉtape 5 : Création du PSDrive AD2..."
New-PSDrive -Name AD2 -PSProvider ActiveDirectory -Root "DC=DC300153747-00,DC=local" -Credential $credAD2 -ErrorAction SilentlyContinue

Write-Host "Navigation dans AD2..."
Set-Location AD2:\

Write-Host "Liste des OU de AD2 :"
Get-ChildItem

# --- e. Vérifier le Trust ---
Write-Host "`nÉtape 6 : Vérification du Trust configuré..."
Get-ADTrust -Filter * | Format-Table Name,Direction,TrustType,ForestTransitive

Write-Host "`n=== Vérification terminée ===" -ForegroundColor Green
