#jesmina 
# Étudiant : 300150303
# Domaine : DC300150303-00.local
# TP Active Directory - OU
# Script complet regroupant création, modification, gestion utilisateurs et OU

# -----------------------------
# Étape 0 : Variables de base
# -----------------------------
$studentNumber = 300150303
$studentInstance = "00"

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Importer le module AD
Import-Module ActiveDirectory

# -----------------------------
# Étape 1 : Vérification du domaine et DC
# -----------------------------
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# -----------------------------
# Étape 2 : Liste des utilisateurs du domaine
# -----------------------------
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName

# -----------------------------
# Étape 3 : Créer un nouvel utilisateur
# -----------------------------
New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Credential $cred

# -----------------------------
# Étape 4 : Modifier un utilisateur
# -----------------------------
Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Credential $cred

# -----------------------------
# Étape 5 : Désactiver un utilisateur
# -----------------------------
Disable-ADAccount -Identity "alice.dupont" -Credential $cred

# -----------------------------
# Étape 6 : Réactiver un utilisateur
# -----------------------------
Enable-ADAccount -Identity "alice.dupont" -Credential $cred

# -----------------------------
# Étape 7 : Supprimer un utilisateur
# -----------------------------
Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred

# -----------------------------
# Étape 8 : Rechercher des utilisateurs avec un filtre
# -----------------------------
Get-ADUser -Filter "Name -like 's*'" -Properties Name, SamAccountName |
Select-Object Name, SamAccountName

# -----------------------------
# Étape 9 : Exporter les utilisateurs dans un CSV
# -----------------------------
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8

# -----------------------------
# Étape 10 : Créer une OU "Students" et déplacer l’utilisateur
# -----------------------------
# Vérifier si l'OU existe
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
}

# Déplacer l’utilisateur depuis CN=Users
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Credential $cred

# Vérifier le déplacement
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName
