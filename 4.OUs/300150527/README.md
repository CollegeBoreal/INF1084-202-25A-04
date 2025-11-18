# 🧭 TP Active Directory – Gestion des Utilisateurs et des OU

## 👤 Informations Étudiant
- **Nom :** Bouraoui Akrem  
- **Numéro étudiant :** 300150527  
- **Instance :** 00  
- **Nom de domaine :** DC300150527-00.local  
- **Nom NetBIOS :** DC300150527-00  



## ⚙️ Étape 0 – Configuration des variables


$studentNumber = 300150527
$studentInstance = "00"
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)
📁 Fichier : bootstrap.ps1
Ce script initialise les variables globales du domaine et les identifiants administrateur.




## 🧩 Étape 1 – Préparation de l’environnement


Import-Module ActiveDirectory
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
📄 Vérifie la configuration du domaine et le contrôleur de domaine.

----------------------------------------

## 👥 Étape 2 – Liste des utilisateurs du domaine

Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
📋 Liste les utilisateurs actifs créés dans le domaine.

-----------------------------------------------

## 🧍 Étape 3 – Créer un utilisateur

New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Credential $cred
✅ Utilisateur Alice Dupont ajouté avec succès.

-------------------------------------

## 📝 Étape 4 – Modifier un utilisateur

Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Credential $cred
🖊️ Mise à jour du prénom et de l’adresse courriel.

----------------------------------------------

## 🚫 Étape 5 – Désactiver un utilisateur

Disable-ADAccount -Identity "alice.dupont" -Credential $cred
👤 L’utilisateur Alice Dupont est désactivé.

------------------------------------------

## 🔁 Étape 6 – Réactiver un utilisateur

Enable-ADAccount -Identity "alice.dupont" -Credential $cred
🔓 L’utilisateur est maintenant réactivé.

----------------------------------------------------

## ❌ Étape 7 – Supprimer un utilisateur


Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred
🗑️ L’utilisateur a été supprimé définitivement.

---------------------------------------------------

## 🧾 Étape 8 – Exporter la liste des utilisateurs


Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
📤 Génère un fichier CSV contenant la liste des utilisateurs.

--------------------------------------------

## 🗂️ Étape 9 – Créer une Unité d’Organisation (OU)

if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
}
📁 OU Students créée avec succès.

--------------

## 🚀 Étape 10 – Déplacer un utilisateur vers une OU

Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Credential $cred

Vérifier le déplacement
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName
