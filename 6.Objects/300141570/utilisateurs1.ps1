# utilisateurs1.ps1
$bootstrapPath = Join-Path $PSScriptRoot '..\..\4.OUs\300141570\bootstrap.ps1'

if (-not (Test-Path $bootstrapPath)) {
    Write-Error "Bootstrap introuvable à l'emplacement : $bootstrapPath"
    exit 1
}

. $bootstrapPath

Import-Module ActiveDirectory -ErrorAction Stop

$domain = Get-ADDomain -Server $domainName
$domainDN = $domain.DistinguishedName

$ouDN = "OU=Students,$domainDN"
$groupName = "Students"

# CREATION OU
if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=Students)" -SearchBase $domainDN -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path $domainDN -ProtectedFromAccidentalDeletion $false
}

# CREATION GROUPE
if (-not (Get-ADGroup -Filter "Name -eq 'Students'")) {
    New-ADGroup -Name "Students" -GroupScope Global -GroupCategory Security -Path $ouDN
}

# CREATATION UTILISATEURS
$password = ConvertTo-SecureString "Infra@2024" -AsPlainText -Force

$users = @(
    @{ Sam = "Etudiant1"; Prenom = "Etudiant"; Nom = "Un" }
    @{ Sam = "Etudiant2"; Prenom = "Etudiant"; Nom = "Deux" }
)

foreach ($u in $users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($u.Sam)'")) {
        New-ADUser -Name "$($u.Prenom) $($u.Nom)" `
                   -SamAccountName $u.Sam `
                   -GivenName $u.Prenom `
                   -Surname $u.Nom `
                   -AccountPassword $password `
                   -Enabled $true `
                   -Path $ouDN
        Add-ADGroupMember -Identity $groupName -Members $u.Sam
    }
}
