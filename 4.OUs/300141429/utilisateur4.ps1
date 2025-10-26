# ========================================
# TP Active Directory - Partie 4
# Gestion des OU
# ========================================

# Définir les variables correctes
$domainName = "DC300141429.local"
$netbiosName = "DC300141429"

# ========================================
# ETAPE 10 : Créer une OU "Students"
# ========================================

# Vérifier si l'OU "Students" existe déjà
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -Server $domainName -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local" -Server $domainName
    Write-Host "OU 'Students' créée."
}
else {
    Write-Host "OU 'Students' existe déjà."
}

# ========================================
# Déplacer l'utilisateur "Alice Dupont"
# ========================================

# Récupérer l'utilisateur
$user = Get-ADUser -Filter {SamAccountName -eq "alice.dupont"} -Server $domainName

if ($user) {
    Write-Host "Utilisateur trouvé : $($user.DistinguishedName)"

    $targetOU = "OU=Students,DC=$netbiosName,DC=local"

    Move-ADObject -Identity $user.DistinguishedName -TargetPath $targetOU -Server $domainName

    Write-Host "Utilisateur déplacé vers : $targetOU"
}
else {
    Write-Host "L'utilisateur 'alice.dupont' est introuvable dans le domaine $domainName."
}

# ========================================
# Vérifier le déplacement
# ========================================

Get-ADUser -Identity "alice.dupont" -Server $domainName | Select-Object Name, DistinguishedName

