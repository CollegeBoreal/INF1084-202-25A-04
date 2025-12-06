Import-Module ActiveDirectory
. .\bootstrap.ps1

# ÉTAPE 10 : Créer l'OU "Students" si elle n'existe pas
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -Server $domainName -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local" -Server $domainName
}

# Trouver l'utilisateur Alice où qu'elle soit dans l'AD
$user = Get-ADUser -Filter "SamAccountName -eq 'alice.dupont'" -Properties DistinguishedName -Server $domainName

if ($user) {
    # Déplacer l'utilisateur vers l'OU Students
    Move-ADObject -Identity $user.DistinguishedName `
                  -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
                  -Server $domainName

    Write-Host "Utilisateur déplacé !"
} else {
    Write-Host "Utilisateur alice.dupont introuvable dans l'AD."
}

# Vérifier le déplacement
Get-ADUser -Identity "alice.dupont" -Server $domainName | Select-Object Name, DistinguishedName

