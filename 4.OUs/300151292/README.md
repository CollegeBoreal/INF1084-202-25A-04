# Étudiant : 300151292
# Nom : Amine Kahil
# Domaine : DC300151292-00.local
# TP Active Directory - OU

---

Ce TP est divisé en **4 fichiers PowerShell** :

###  **utilisateurs1.ps1** - Configuration et Listage
- Configuration initiale des variables de domaine
- Vérification de l'environnement Active Directory
- Listage des utilisateurs actifs du domaine

###  **utilisateurs2.ps1** - Création et Modification
- Création d'un nouvel utilisateur (Alice Dupont)
- Modification des attributs utilisateur

###  **utilisateurs3.ps1** - Gestion des comptes
- Désactivation et réactivation de comptes
- Recherche d'utilisateurs avec filtres
- Export des données vers CSV

###  **utilisateurs4.ps1** - Gestion des OU et Nettoyage
- Création d'Unités Organisationnelles (OU)
- Déplacement d'utilisateurs entre containers

---

#  Étapes du laboratoire

## Étape 0 : Configuration des variables

$studentNumber = 300151292
$studentInstance = "00"

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

---

## Étape 1 : Vérification de l'environnement

Import-Module ActiveDirectory
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

 Vérifie que ton domaine est bien configuré.

---

## Étape 2 : Liste des utilisateurs du domaine

Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName

 Capture d'écran : images/liste_utilisateurs.png

---

## Étape 3 : Créer un nouvel utilisateur

New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Credential $cred

 Lutilisateur Alice Dupont est créé avec succès.

---

## Étape 4 : Modifier un utilisateur

Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Credential $cred

---

## Étape 5 : Désactiver un utilisateur

Disable-ADAccount -Identity "alice.dupont" -Credential $cred

---

## Étape 6 : Réactiver un utilisateur

Enable-ADAccount -Identity "alice.dupont" -Credential $cred

---

## Étape 7 : Supprimer un utilisateur

Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred

---

## Étape 8 : Exporter les utilisateurs dans un fichier CSV

Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8

---

## Étape 9 : Créer une OU "Students" et déplacer l'utilisateur

if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
}

Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Credential $cred

Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName

 Capture : images/deplacement_ou.png

---

##  Résumé des fichiers

- `bootstrap.ps1` : Variables globales et credentials
- `utilisateurs1.ps1`  `utilisateurs4.ps1` : Étapes du TP
- `rapport.txt` : Résumé et validations
- `images/` : Captures décran de validation
