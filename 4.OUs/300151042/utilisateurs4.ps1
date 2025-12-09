param(
    [string]$domainDN = "DC=DC300151042-00,DC=local"  # Domaine complet sous forme DN
)

# Définir le nom de domaine
. .\bootstrap.ps1

# Demande des identifiants administratifs
$cred = Get-Credential -Message "Entrez vos identifiants AD"

Write-Host "Vérification de l'existence de l'OU 'Students'..." -ForegroundColor Cyan

# Vérifie si l’OU existe déjà
$ouExist = Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -ErrorAction SilentlyContinue

if (-not $ouExist) {
    New-ADOrganizationalUnit -Name "Students" -Path $domainDN -Credential $cred
    Write-Host "OU 'Students' créée avec succès." -ForegroundColor Green
} else {
    Write-Host "L'OU 'Students' existe déjà." -ForegroundColor Yellow
}

# Déplacement de l'utilisateur
Write-Host "Déplacement de l'utilisateur 'Alice Dupont' vers l'OU 'Students'..." -ForegroundColor Cyan

$sourcePath = "CN=Alice Dupont,CN=Users,$domainDN"
$targetPath = "OU=Students,$domainDN"

# Vérifie si l’utilisateur existe avant le déplacement
$user = Get-ADUser -Filter "SamAccountName -eq 'alice.dupont'" -ErrorAction SilentlyContinue
if ($user) {
    Move-ADObject -Identity $sourcePath -TargetPath $targetPath -Credential $cred
    Write-Host "L'utilisateur 'Alice Dupont' a été déplacé vers 'Students'." -ForegroundColor Green
} else {
    Write-Host "L'utilisateur 'alice.dupont' n'existe pas dans le domaine." -ForegroundColor Red
}

# Vérification du déplacement
Write-Host "Vérification du déplacement..." -ForegroundColor Cyan
Get-ADUser -Identity "alice.dupont" -Properties DistinguishedName |
Select-Object Name, DistinguishedName

