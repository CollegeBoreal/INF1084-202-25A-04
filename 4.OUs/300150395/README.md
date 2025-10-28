Étudiant : 300150395
Domaine : DC300150395-0.local



🧮 Laboratoires
Gérer les utilisateurs dans ton domaine DC999999999-0.local, avec les corrections pour le container CN=Users et la création de l’OU Students.

📚 Travail à soumettre :
 Créer un répertoire avec ton 🆔 (votre identifiant boreal)
 mkdir  🆔
 cd  🆔
 dans le répertoire ajouter le fichier README.md
 touch README.md
 Créer un répertoire images
 mkdir images
 touch images/.gitkeep
 envoyer vers le serveur git
 remonter au repertoire précédent
 cd ..
 git add 🆔
 git commit -m "mon fichier ..."
 git push
Domaine cible : DC999999999-0.local Outils : PowerShell avec module ActiveDirectory

⚠️ Chaque étudiant a un domaine unique basé sur son numéro étudiant.

Voici comment organiser ça et l’adapter à PowerShell :

0️⃣ Nom du domaine basé sur le numéro étudiant
Si ton numéro d’étudiant est 999999999 et que tu as le numéro d'instance netbios 30 (pour éviter les erreurs de duplicatas):

$studentNumber = 999999999
$studentInstance = 0

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"
$domainName : FQDN du domaine (DC999999999-0.local)
$netbiosName : Nom NetBIOS court (DC999999999-0)
Cela garantit un nom unique pour chaque étudiant même si plusieurs étudiants font le TP sur le même réseau isolé.
1️⃣ Préparer l’environnement
# Importer le module AD
Import-Module ActiveDirectory

# Vérifier le domaine et les DC
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
2️⃣ Liste des utilisateurs du domaine
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
⚠️ Remarque : les utilisateurs créés par défaut sont dans CN=Users, pas dans une OU.

🔑 Pour les operations néscessitant les informations sécurisées de l'administrateur

$cred = Get-Credential  # entrer Administrator@$domainName et le mot de passe
3️⃣ Créer un nouvel utilisateur
New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Credential $cred
4️⃣ Modifier un utilisateur
Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Credential $cred
5️⃣ Désactiver un utilisateur
Disable-ADAccount -Identity "alice.dupont" -Credential $cred
6️⃣ Réactiver un utilisateur
Enable-ADAccount -Identity "alice.dupont" -Credential $cred
7️⃣ Supprimer un utilisateur
Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred
8️⃣ Rechercher des utilisateurs avec un filtre
Get-ADUser -Filter "GivenName -like 'A*'" -Properties Name, SamAccountName |
Select-Object Name, SamAccountName
9️⃣ Exporter les utilisateurs dans un CSV
Get-ADUser -Filter * -Server $domain -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
1️⃣ 0️⃣ Déplacer un utilisateur vers une OU Students
Crée l’OU si elle n’existe pas :
# Vérifier si l'OU existe
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
}
Déplacer l’utilisateur depuis CN=Users :
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Credential $cred
Vérifier le déplacement :
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName
✅ Bilan du TP
Après ce TP, l’étudiant saura :

Lister tous les utilisateurs d’un domaine
Créer, modifier, activer/désactiver et supprimer des utilisateurs
Appliquer des filtres et exporter les données
Déplacer des utilisateurs depuis le container par défaut CN=Users vers une OU spécifique
