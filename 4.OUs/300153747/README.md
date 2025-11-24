300153747
bootstrap.ps1
```powershell
# vos informations
$studentNumber = 300153747
$studentInstance = "00"

# les noms respectifs
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# les informations de sécurité
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)
```
<details>
```powershell


```
  
</details>
utilisateur1.ps1
```powershel
# ETAPE 0 : Configuration des variables
$studentNumber = 300153747
$studentInstance = "00"

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# ETAPE 1 : Vérification de l'environnement
Import-Module ActiveDirectory

Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# ETAPE 2 : Liste des utilisateurs du domaine
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
```
utilisateur2.ps1
```powershell
# ETAPE 3 : Créer un nouvel utilisateur
New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Server $domainName

# ETAPE 4 : Modifier un utilisateur
Set-ADUser -Identity "alice.dupont" `
           -Server $domainName `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie"

```
utilisateur3.ps1
```powershell
# ETAPE 5 : Désactiver un utilisateur
Disable-ADAccount -Identity "alice.dupont" -Server $domainName

# ETAPE 6 : Réactiver un utilisateur
Enable-ADAccount -Identity "alice.dupont" -Server $domainName

# ETAPE 7 : Supprimer un utilisateur
Remove-ADUser -Identity "alice.dupont" -Server $domainName -Confirm:$false

# ETAPE 8 : Rechercher des utilisateurs avec un filtre
Get-ADUser -Filter "Name -like 's*'" -Server $domainName -Properties Name, SamAccountName |
Select-Object Name, SamAccountName

# ETAPE 9 : Exporter les utilisateurs dans un CSV
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
```
utilisateur4.ps1
```powershell
#ETAPE 10 : Créer une OU "Students"
# Vérifier si l'OU existe
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -Server $domainName -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local" -Server $domainName
}

# Déplacer l'utilisateur depuis CN=Users
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Server $domainName

# Vérifier le déplacement
Get-ADUser -Identity "alice.dupont" -Server $domainName | Select-Object Name, DistinguishedName
```






