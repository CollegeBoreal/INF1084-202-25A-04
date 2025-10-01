$OU = "OU=Promo2025,DC=tondomaine,DC=local"
$Groupe = "Etudiants2025"

if (-not (Get-ADGroup -Filter {Name -eq $Groupe})) {
    New-ADGroup -Name $Groupe -SamAccountName $Groupe -GroupScope Global -Path $OU
}

$utilisateurs = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; Mdp="Password123!"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; Mdp="Password123!"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; Mdp="Password123!"},
    @{Nom="Martin"; Prenom="Luc"; Login="lmartin"; Mdp="Password123!"},
    @{Nom="Nguyen"; Prenom="Linh"; Login="lnguyen"; Mdp="Password123!"}
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

