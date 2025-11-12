# TP Active Directory – OU et gestion des utilisateurs

## Étudiant
- Nom : Massinissa Mameri  
- ID : 300151841  
- Domaine : DC300151841-00.local  

## Description
Ce TP utilise PowerShell pour gérer les utilisateurs dans un domaine Active Directory et organiser les comptes dans une unité d’organisation (OU) nommée **Students**.

## Scripts fournis

- `bootstrap.ps1` : configure les variables du domaine et les identifiants administrateur.  
- `utilisateurs1.ps1` : crée l'utilisateur **Alice Dupont** dans le conteneur `CN=Users`.  
- `utilisateurs2.ps1` : modifie les informations d'Alice (prénom et courriel) et affiche la liste des utilisateurs actifs.  
- `utilisateurs3.ps1` : désactive puis réactive le compte d'Alice et vérifie son statut.  
- `utilisateurs4.ps1` : crée l’OU **Students**, déplace Alice dans cette OU et lance l’export des utilisateurs vers `TP_AD_Users.csv`.  
- `TP_AD_Users_300151841.ps1` : script qui exporte les utilisateurs du domaine dans le fichier `TP_AD_Users.csv`.  

## Déplacement de l'utilisateur vers l’OU Students

L'utilisateur **Alice Dupont** est déplacé depuis le conteneur par défaut `CN=Users` vers l'unité d'organisation `OU=Students` :

```powershell
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=DC300151841-00,DC=local" `
              -TargetPath "OU=Students,DC=DC300151841-00,DC=local"
Get-ADUser -Identity "alice.dupont" | Select Name, DistinguishedName
