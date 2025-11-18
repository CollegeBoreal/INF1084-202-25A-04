# utilisateurs2.ps1
# Auteur : Imad Boudeuf - 300152410
# Description : Suppression d’utilisateurs Active Directory

Import-Module ActiveDirectory

$users = @("jdupont", "smoreau", "atremblay", "lnguyen")

foreach ($user in $users) {
    if (Get-ADUser -Filter {SamAccountName -eq $user}) {
        Remove-ADUser -Identity $user -Confirm:$false
        Write-Host "Utilisateur supprimé : $user"
    }
    else {
        Write-Host "Utilisateur non trouvé : $user"
    }
}
