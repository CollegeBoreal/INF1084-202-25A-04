=
$OU = "OU=Promo2025,DC=tondomaine,DC=local"
$Groupe = "Etudiants2025"

if (-not (Get-ADGroup -Filter {Name -eq $Groupe})) {
    New-ADGroup -Name $Groupe -SamAccountName $Groupe -GroupScope Global -Path $OU
}

$utilisateurs = @(
    @{Nom="User1"; Prenom="Test1"; Login="user1"; Mdp="Password123!"},
    @{Nom="User2"; Prenom="Test2"; Login="user2"; Mdp="Password123!"},
    @{Nom="User3"; Prenom="Test3"; Login="user3"; Mdp="Password123!"},
    @{Nom="User4"; Prenom="Test4"; Login="user4"; Mdp="Password123!"},
    @{Nom="User5"; Prenom="Test5"; Login="user5"; Mdp="Password123!"}
)

foreach ($u in $utilisateurs) {
    if (-not (Get-ADUser -Filter {SamAccountName -eq $u.Login})) {
        New-ADUser -Name "$($u.Prenom) $($u.Nom)" `
                   -GivenName $u.Prenom `
                   -Surname $u.Nom `
                   -SamAccountName $u.Login `
                   -AccountPassword (ConvertTo-SecureString $u.Mdp -AsPlainText -Force) `
                   -Path $OU `
                   -Enabled $true
    }
}

$usersOU = Get-ADUser -SearchBase $OU -Filter *
foreach ($user in $usersOU) {
    Add-ADGroupMember -Identity $Groupe -Members $user.SamAccountName
}

Get-ADGroupMember -Identity $Groupe | Select-Object Name,SamAccountName | Export-Csv -Path ".\Etudiants2025.csv" -NoTypeInformation

