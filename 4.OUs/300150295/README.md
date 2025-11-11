# 🚀 TP : Gestion des utilisateurs Active Directory avec PowerShell
### 👨‍💻 Étudiant : 300150295  
### 🌐 Domaine : DC300150295-00.local  

---

## 🎯 Objectif du TP
Gérer les utilisateurs dans ton domaine **DC300150295-00.local**, avec les corrections pour le container CN=Users et la création de l’OU Students.

---

## 🔧 Étapes principales
1. Préparer l’environnement AD  
2. Lister les utilisateurs  
3. Créer, modifier, activer/désactiver et supprimer des utilisateurs  
4. Déplacer les utilisateurs vers l’OU Students  
5. Exporter les utilisateurs dans un CSV  

---

## 📚 Commandes principales (PowerShell)

\ = 300150295
\ = 00
\ = "DC\-\.local"
\ = "DC\-\"

Import-Module ActiveDirectory

# Connexion administrateur
\ = Get-Credential

# Création d'un utilisateur test
New-ADUser -Name "Alice Dupont" 
           -GivenName "Alice" 
           -Surname "Dupont" 
           -SamAccountName "alice.dupont" 
           -UserPrincipalName "alice.dupont@\" 
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) 
           -Enabled \True 
           -Path "CN=Users,DC=\,DC=local" 
           -Credential \

# Création de l'OU Students
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=\,DC=local"
}

# Déplacement de l’utilisateur
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=\,DC=local" 
              -TargetPath "OU=Students,DC=\,DC=local" 
              -Credential \

# Vérifier
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName
