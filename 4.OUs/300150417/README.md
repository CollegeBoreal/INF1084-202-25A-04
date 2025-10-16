# TP Gestion des utilisateurs et OUs

## 0️⃣ Préparation du domaine
# Définir ton numéro étudiant et instance
$studentNumber = 300150417
$studentInstance = 0

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Importer le module ActiveDirectory
Import-Module ActiveDirectory

# Vérifier le domaine et le contrôleur de domaine
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

## 1️⃣ Liste des utilisateurs existants
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName

## 2️⃣ Créer un nouvel utilisateur
$cred = Get-Credential  # entrer Administrator@$domainName et mot de passe

New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Credential $cred

## 3️⃣ Modifier un utilisateur
Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Credential $cred

## 4️⃣ Désactiver un utilisateur
Disable-ADAccount -Identity "alice.dupont" -Credential $cred

## 5️⃣ Réactiver un utilisateur
Enable-ADAccount -Identity "alice.dupont" -Credential $cred

## 6️⃣ Supprimer un utilisateur
Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred

## 7️⃣ Rechercher des utilisateurs avec un filtre
Get-ADUser -Filter "GivenName -like 'A*'" -Properties Name, SamAccountName |
Select-Object Name, SamAccountName

## 8️⃣ Exporter les utilisateurs dans un CSV
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8

## 9️⃣ Déplacer un utilisateur vers l’OU Students
# Créer l’OU Students si elle n’existe pas
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
}

# Déplacer Alice Dupont dans l’OU Students
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Credential $cred

# Vérifier le déplacement
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName, Enabled
