# TP 6.Objects – Objets AD, partage et RDP  
Étudiant : **300141570**

Ce TP utilise PowerShell pour gérer les objets Active Directory et configurer :

- Une **OU** `Students`
- Un **groupe** `Students`
- Des **utilisateurs** dans l’OU `Students`
- Un **dossier partagé** `C:\SharedResources` et un **partage SMB** `SharedResources`
- Une **GPO** qui mappe automatiquement le lecteur réseau **Z:** vers `\\<serveur>\SharedResources`
- L’activation du **RDP** pour permettre aux étudiants de se connecter à distance

## Fichiers

- `utilisateurs0.ps1`  
  Prépare l’environnement : charge `bootstrap.ps1`, affiche les infos du domaine et importe les modules `ActiveDirectory` et `GroupPolicy`.

- `utilisateurs1.ps1`  
  Crée l’OU `Students`, le groupe `Students` et plusieurs utilisateurs (`Etudiant1`, `Etudiant2`, `Etudiant3`) dans l’OU, puis les ajoute au groupe.

- `utilisateurs2.ps1`  
  Crée le dossier `C:\SharedResources`, le partage SMB `SharedResources`, la GPO `MapSharedFolder` pour mapper le lecteur **Z:** et active le RDP sur le serveur.

## Pré-requis

- Être connecté sur le **DC Windows Server 2022** avec AD DS installé.  
- Avoir cloné le dépôt du cours INF1084-202-25A.  
- Le fichier `4.OUs/bootstrap.ps1` doit être configuré avec :  
  - `studentNumber = 300141570`  
  - `studentInstance = 0` (ou la valeur donnée par le prof)

## Utilisation

Dans une console PowerShell **en administrateur**, se placer dans le dossier du TP :

```powershell
cd C:\Users\Administrator\INF1084-202-25A-04\6.Objects\300141570
<img width="1915" height="1078" alt="2" src="https://github.com/user-attachments/assets/8804caf1-a8fb-49b5-83e5-96388625c4c1" />
<img width="1918" height="1078" alt="1" src="https://github.com/user-attachments/assets/1b4f40d2-121f-4c2a-a968-51f8932a110a" />
