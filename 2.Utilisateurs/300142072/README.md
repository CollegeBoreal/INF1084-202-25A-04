# 300142072

TP : Simulation d'Active Directory avec Powershell

❗: Avant tout, s'assurer d'avoir creer le repertoire dans lequel seront stockes nos scripts.

🔢: Creation d'utilisateurs simules

🅰️ creation du script pour utilisteurs1
```sh
nano utilisateurs1.ps1
```
:b: Execution du script powershell
``` sh
.\utilisateurs1.ps1
```
❗: lors de l'ajout des utilisateurs, toujours ajouter une virgule a la fin.

🔢: Creation de groupe simules

Le code de reference a ete modifie afin qu'il puisse fonctionner convenablement. 
la ligne de code  ```. $PSScriptRoot\utilisateurs1.ps1``` a ete utilisee afin d'importer le script de l'utilisateur1 et de l'inclure dans l'execution de ce script. il permet donc la liaison entre le script de l'utilisateur1 et de l'utilisateur2.

🔢: Requetes et filtres

Pour que le script marche, il faut ajouter une ligne de code qui permettra l'importation des informations du script utilisateurs1 dans ce script qui est celui de l'utilisateurs3.
``` sh
. . \utilisateurs1.ps1
```

🔢: Import et export CSV

🅰️ definition du chemin du fichier csv
Bien definir le chemin ou sera importer le fichier csv.

``` sh
$CsvPath = "C:\Users\sigad\Developer\INF1084-202-25A-03\2.Utilisateurs\300142072\file_utilisateurs1.csv"
```
:b: Modification des objects.

Lors de l'execution de ce scipt, il se peut que le tableau contenant les utilisateurs soient vides. Ceci est due au fait que les objects (utilisateurs) crees dans utilisteurs1.ps1 ne sont pas au format des objects powershell. Pour cela , nous avons ajoute la commande suivante devant chaque object pour qu'ils soient pris en compte dans powershell.

``` sh
[PSCustomObject]
```

:c: Ajout des utilisateurs importes dans le groupe
``` sh
$ImportGroupe += $UsersImportes
```







 












