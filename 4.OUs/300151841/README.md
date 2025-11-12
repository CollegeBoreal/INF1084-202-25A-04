# TP Active Directory – OU et gestion des utilisateurs

## Étudiant
- Nom : Massinissa Mameri  
- ID : 300151841  
- Domaine : DC300151841-00.local  

## Description
Ce TP utilise PowerShell pour gérer les utilisateurs dans un domaine Active Directory et organiser les comptes dans une unité d’organisation (OU) nommée **Students**.

## Scripts fournis

- `bootstrap.ps1` : configure les variables du domaine et les identifiants administrateur.
![wait](https://github.com/user-attachments/assets/7cd57d06-1df5-413a-9b62-6f573d362dff)

- `utilisateurs1.ps1` : crée l'utilisateur **Alice Dupont** dans le conteneur `CN=Users`.
  ![wait](https://github.com/user-attachments/assets/6c814542-dc8b-4588-9a1c-09e5f74ae9ba")

- `utilisateurs2.ps1` : modifie les informations d'Alice (prénom et courriel) et affiche la liste des utilisateurs actifs.
- ![wait](https://github.com/user-attachments/assets/635b91fd-cb37-481d-b315-5b97ae487fbf)

- `utilisateurs3.ps1` : désactive puis réactive le compte d'Alice et vérifie son statut.
  ![wait](https://github.com/user-attachments/assets/d77e0261-f93c-4cde-b280-3c8b7f91767c)
  ![wait](https://github.com/user-attachments/assets/b0583024-4d78-4fa5-8645-325eb667122f)


- `utilisateurs4.ps1` : crée l’OU **Students**, déplace Alice dans cette OU et lance l’export des utilisateurs vers `TP_AD_Users.csv`.
![wait](https://github.com/user-attachments/assets/28078d73-367f-4edb-9527-90d42092025f)
-  
- `TP_AD_Users_300151841.ps1` : script qui exporte les utilisateurs du domaine dans le fichier `TP_AD_Users.csv`.

![wait](https://github.com/user-attachments/assets/b47e3710-29db-4999-83c4-6e9e3e0ac6b9)

  

## Déplacement de l'utilisateur vers l’OU Students

L'utilisateur **Alice Dupont** est déplacé depuis le conteneur par défaut `CN=Users` vers l'unité d'organisation `OU=Students` :
![wait](https://github.com/user-attachments/assets/493f8f3a-3df1-4864-9737-003b6bd9b417)

 
