# 300142072

TP : Simulation d'Active Directory avec Powershell

❗: Avant tout, s'assurer d'avoir creer le repertoire dans lequel seront stockes nos scripts.

:1: Creation d'utilisateurs simules

🅰️ creation du script pour utilisteurs1
```sh
nano utilisateurs1.ps1
```
:b: Execution du script powershell
``` sh
.\utilisateurs1.ps1
```
❗: lors de l'ajout des utilisateurs, toujours ajouter une virgule a la fin.

:2: Creation de groupe simules

Le code de reference a ete modifie afin qu'il puisse fonctionner convenablement. 
la ligne de code sh ```. $PSScriptRoot\utilisateurs1.ps1``` a ete utilisee afin d'importer le script de l'utilisateur1 et de l'inclure dans l'execution de ce script. il permet donc la liaison entre le script de l'utilisateur1 et de l'utilisateur2.

 








