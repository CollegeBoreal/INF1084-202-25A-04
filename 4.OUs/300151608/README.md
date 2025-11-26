Travail Pratique – Active Directory (Gestion des Utilisateurs et OU)

INF1084 – Services Réseau

Étudiant : Mohammed Aiche

ID : 300151608

Collège Boréal – Automne 2025

🟦 INTRODUCTION 

Dans ce travail pratique 🖥️, j’ai appris à utiliser PowerShell pour gérer les utilisateurs dans un domaine Active Directory.
J’ai créé des comptes, modifié des informations, activé et désactivé des utilisateurs, exporté des données et organisé les objets dans une OU.
Chaque étape m’a permis de mieux comprendre comment un administrateur système gère la structure d’un domaine au quotidien 🔐📂.

1️⃣ Étape 1 – Création d’utilisateurs simples

➡️ Dans cette étape, j’ai créé des utilisateurs de base dans le domaine à l’aide de la commande New-ADUser.
Cette action simule l’ajout d’employés dans un système Active Directory.

<img width="740" height="357" alt="ousetap1" src="https://github.com/user-attachments/assets/f50c81f4-f108-4e2e-a1c8-96bc673b757a" />

2️⃣ Étape 2 – Ajout des groupes

➡️ J’ai ajouté des utilisateurs dans un groupe afin de simuler la gestion des permissions.
Cela permet d’appliquer des règles de sécurité et des accès par groupe.

<img width="607" height="314" alt="ousetap2" src="https://github.com/user-attachments/assets/b6533477-acd0-47e9-abd3-a180501ace72" />

3️⃣ Étape 3 – Affichage et filtrage des utilisateurs

➡️ J’ai utilisé Get-ADUser pour afficher les comptes existants et filtrer ceux qui sont actifs.
C’est une étape essentielle pour vérifier les utilisateurs du domaine.

<img width="685" height="280" alt="ousetap3" src="https://github.com/user-attachments/assets/a279e8ef-3822-46fc-b236-3d8d1c586481" />

4️⃣ Étape 4 – Modification d’un utilisateur

➡️ J’ai modifié un utilisateur avec Set-ADUser afin de changer son email et son prénom.
Cette étape montre comment mettre à jour les informations d’un compte sans le recréer.

<img width="620" height="29" alt="ousetap4" src="https://github.com/user-attachments/assets/620a18ae-e5ad-4b69-a716-c8bb67209ad9" />

5️⃣ Étape 5 – Désactivation d’un utilisateur

➡️ Grâce à Disable-ADAccount, j’ai désactivé un utilisateur pour lui retirer temporairement l’accès au domaine.
Cette opération est utilisée lorsqu’un employé quitte l’entreprise.

<img width="614" height="65" alt="ousetap5" src="https://github.com/user-attachments/assets/a619b443-7c31-4017-8235-473e28088fdc" />

6️⃣ Étape 6 – Réactivation d’un utilisateur

➡️ J’ai réactivé le même utilisateur avec Enable-ADAccount, ce qui restaure son accès.
C’est utile lorsqu’un compte doit être réutilisé après une suspension.

<img width="512" height="56" alt="ousetap6" src="https://github.com/user-attachments/assets/41519876-85e8-4ce6-b57d-a5687d496cd0" />

7️⃣ Étape 7 – Suppression d’un utilisateur

➡️ J’ai supprimé un compte avec Remove-ADUser.
Cette étape démontre la gestion du cycle de vie complet d’un utilisateur.

<img width="608" height="53" alt="ousetap7" src="https://github.com/user-attachments/assets/8661d4c5-acaa-44f3-bbdb-a6d04921338b" />

8️⃣ Étape 8 – Recherche avec filtres

➡️ À l’aide d’un filtre sur GivenName, j’ai recherché tous les utilisateurs dont le prénom commence par “A”.
C’est une technique courante dans les grandes entreprises.

<img width="782" height="46" alt="ousetap8" src="https://github.com/user-attachments/assets/b33276ca-7871-4065-a89e-d595ec1b7a59" />

9️⃣ Étape 9 – Exportation des utilisateurs dans un CSV

➡️ J’ai exporté les comptes du domaine avec Export-Csv.
Cela permet de générer des rapports ou de sauvegarder les données des utilisateurs.

<img width="560" height="179" alt="ousetap9" src="https://github.com/user-attachments/assets/a39e233c-0b6a-4052-8f9c-f7b124a10128" />

🔟 Étape 10 – Création d’une OU et déplacement d’un utilisateur

➡️ J’ai vérifié l’existence de l’OU “Students”, puis je l’ai créée si elle n’existait pas.
➡️ Ensuite, j’ai déplacé l’utilisateur depuis CN=Users vers OU=Students avec Move-ADObject.

<img width="782" height="302" alt="ousetap10" src="https://github.com/user-attachments/assets/d475269a-96fb-4e21-b823-fc05da7375e1" />


🟧 CONCLUSION 

Ce TP m’a aidé à maîtriser les commandes essentielles d’Active Directory ⚙️.
J’ai compris comment créer, gérer, déplacer et exporter les utilisateurs, ainsi que l’importance d’organiser un domaine avec des OU.
C’était une bonne expérience pour développer mes compétences en administration système 💼💪.







