nano utilisateurs1.sh
 Comment creer le script
Pour créer un script PowerShell avec nano, tapez nano utilisateurs1.ps1 pour ouvrir l'éditeur, écrivez votre code PowerShell (variables, commandes, etc.), sauvegardez avec Ctrl+O puis Entrée, et quittez avec Ctrl+X. Le fichier doit obligatoirement avoir l'extension .ps1 et peut ensuite être exécuté avec:

PowerShell -ExecutionPolicy Bypass -File .\utilisateurs1.ps1.
.\utilisateurs1.sh
 Comment executer le script
Windows bloque par défaut l'exécution des scripts PowerShell (.ps1) pour des raisons de sécurité via la politique "ExecutionPolicy".

Solution la solution est d'executer la commandes:

PowerShell -ExecutionPolicy Bypass -File .\utilisateurs1.ps1
Explication
La commande Bypass permet d'exécuter temporairement le script sans modifier définitivement les paramètres de sécurité du système. Cette approche maintient la protection globale tout en autorisant l'exécution ponctuelle du script nécessaire.

nano utilisateurs1.sh
❌ message d'erreur
.\utilisateurs1.ps1 : File C:\Users\franc\Developer\inf1084-202-25A-03\2.Utilisateurs\300143951\utilisateurs1.ps1 cannot be loaded because running scripts is disabled on this system.
 For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
 At line:1 char:1+ .\utilisateurs1.ps1 + ~~~~~~~~~~~~~~~~~~~ + CategoryInfo          : SecurityError: (:) [], PSSecurityExceptio 
+ FullyQualifiedErrorId : UnauthorizedAccess
