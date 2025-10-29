# ===========================
# utilisateurs4.ps1
# Gestion des OU & Nettoyage
# ===========================

$studentNumber   = 300152410
$studentInstance = 0
$netbiosName     = "DC$studentNumber-$studentInstance"
$domainFqdn      = "$netbiosName.local"
$domainDN        = "DC=$netbiosName,DC=local"

Import-Module ActiveDirectory

# 1️⃣ Créer une OU "Students" si elle n'existe pas
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path $domainDN
    Write-Host "OU 'Students' créée."
} else {
    Write-Host "OU 'Students' existe déjà."
}

# 2️⃣ Déplacer l’utilisateur dans l’OU
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,$domainDN" `
              -TargetPath "OU=Students,$domainDN"

# 3️⃣ Vérifier le déplacement
Get-ADUser -Identity "adupont" | Select-Object Name, DistinguishedName

# 4️⃣ (Optionnel) Supprimer un utilisateur de test
# Remove-ADUser -Identity "adupont" -Confirm:$false
