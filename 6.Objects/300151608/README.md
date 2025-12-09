TP – 6.Objects

Présenté par :

Mohammed Aiche
Numéro étudiant : 300151608

Présenté à :


Établissement :

Collège Boréal

<img width="668" height="409" alt="obj1" src="https://github.com/user-attachments/assets/9a6aadac-90e0-432c-bafc-78e2f11c5b2f" />


📌 Script : utilisateurs1.ps1

<img width="675" height="418" alt="obj2" src="https://github.com/user-attachments/assets/9f4af980-b2a1-4fd2-8e3a-9d0b2e9559aa" />



🎯 Objectif

Ce script a pour but de créer les objets Active Directory nécessaires au partage de ressources :

un dossier partagé,

un groupe de sécurité,

des utilisateurs de test,

et un partage SMB auquel ce groupe aura accès.

🧩 Fonctionnalités détaillées
1️⃣ Chargement de l’environnement Active Directory

Le script importe les modules AD et GroupPolicy ainsi que les variables provenant du bootstrap.ps1.
Cela garantit que le domaine, le NetBIOS et les chemins sont bien configurés.

2️⃣ Création du dossier partagé

Un dossier C:\SharedResources est créé s’il n’existe pas déjà.
Ce dossier servira comme emplacement commun accessible aux utilisateurs du groupe Students.

3️⃣ Création du groupe Students

Un groupe AD nommé Students est généré.
Ce groupe recevra les permissions d’accès au partage et au RDP (si configuré plus tard).

4️⃣ Création des utilisateurs de test

Le script crée deux utilisateurs simples :

Etudiant1

Etudiant2

Ces comptes reçoivent un mot de passe par défaut et sont automatiquement activés.

5️⃣ Ajout des utilisateurs au groupe

Les utilisateurs nouvellement créés sont ajoutés au groupe Students.
Cela permet de centraliser la gestion des permissions.

6️⃣ Création du partage SMB

Un partage réseau SMB nommé SharedResources est créé et lié au dossier préparé.
Le groupe Students obtient les droits d’accès complets.

📌 Script : utilisateurs2.ps1

<img width="647" height="393" alt="obj3" src="https://github.com/user-attachments/assets/4933f0bf-b06d-419c-a144-28807ee4c699" />

🎯 Objectif

Ce script vise à automatiser la configuration d’un lecteur réseau (Z:) via une GPO.
L’objectif est que chaque utilisateur de l’OU Students voie automatiquement ce lecteur à la connexion.

🧩 Fonctionnalités détaillées
1️⃣ Création de la GPO


Le script crée une GPO appelée MapSharedFolder, sauf si elle existe déjà.
Cette GPO contiendra la politique de mappage du lecteur.

2️⃣ Liaison de la GPO à l’OU Students

La GPO est liée à :

OU=Students,DC=tonDomaine,DC=local


Ceci garantit que seuls les utilisateurs de cette OU appliqueront la politique.

3️⃣ Création d’un script de logon

Un dossier C:\Scripts est créé, puis un fichier .bat nommé :

MapDrive-Z.bat


Ce script contient la ligne :

net use Z: \\DC\SharedResources /persistent:no


Ce fichier permet de monter automatiquement le lecteur Z:.

4️⃣ Association du script à la GPO

La GPO est modifiée pour exécuter ce script de logon à chaque connexion utilisateur.
On utilise pour cela la clé de registre dans :

HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System

✔️ Résultat attendu

<img width="590" height="222" alt="obj4" src="https://github.com/user-attachments/assets/d11c8f59-b527-4377-b897-2489a2fd4aa6" />



Avec un compte du groupe Students :

Le lecteur Z: apparaît automatiquement.

Le partage \\Serveur\SharedResources est accessible.

Avec un utilisateur hors du groupe :

Le lecteur Z: ne s’affiche pas.

Le partage SMB n’est pas acce
