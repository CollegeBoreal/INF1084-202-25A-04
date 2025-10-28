# =========================================
# TP INF1084 - Étape 4 : Déplacement vers l'OU Students
# =========================================

# Variables de domaine
$studentNumber = 300141429
$domainName = "DC300141429.local"
$netbiosName = "DC300141429"
$cred = Get-Credential  # Identifiants Admin

# Vérifier si l'OU Students existe, sinon la créer
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local" -Credential $cred
    Write-Host "🆕 OU 'Students' créée."
}

# Déplacer l'utilisateur Alice Dupont dans l'OU Students
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Credential $cred
Write-Host "📦 Utilisateur déplacé vers l'OU Students."

# Vérification du déplacement
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName
