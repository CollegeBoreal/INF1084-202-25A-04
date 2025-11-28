# utilisateurs1.ps1
# Auteur : Imad Boudeuf - 300152410
# Description : Création d’utilisateurs Active Directory

Import-Module ActiveDirectory

$users = @(
    @{Nom="Dupont"; Prenom="Jean"; OU="OU=RH,DC=dc300152410-00,DC=local"},
    @{Nom="Moreau"; Prenom="Sophie"; OU="OU=Marketing,DC=dc300152410-00,DC=local"},
    @{Nom="Tremblay"; Prenom="Alexandre"; OU="OU=IT,DC=dc300152410-00,DC=local"},
    @{Nom="Nguyen"; Prenom="Linh"; OU="OU=Ventes,DC=dc300152410-00,DC=local"}
)

foreach ($user in $users) {
    $Sam = $user.Prenom.Substring(0,1).ToLower() + $user.Nom.ToLower()
    $UPN = "$Sam@dc300152410-00.local"
    $Password = ConvertTo-SecureString "Password@123" -AsPlainText -Force

    New-ADUser `
        -Name "$($user.Prenom) $($user.Nom)" `
        -GivenName $user.Prenom `
        -Surname $user.Nom `
        -SamAccountName $Sam `
        -UserPrincipalName $UPN `
        -AccountPassword $Password `
        -Enabled $true `
        -Path $user.OU `
        -ChangePasswordAtLogon $false `
        -PasswordNeverExpires $true

    Write-Host "Utilisateur créé : $Sam"
}
