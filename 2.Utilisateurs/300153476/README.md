
Les fichiers n’étaient pas au même emplacement, donc le script Utilisateur2.ps1 ne trouvait pas Utilisateur1.ps1. Il fallait soit donner le chemin complet, soit mettre les deux fichiers dans le même dossier.

Dans la déclaration de la hashtable $Groups, il manquait un point-virgule ; entre les clés, ce qui provoquait une erreur de syntaxe.

*En résumé:*
Toujours vérifier que le chemin du fichier que tu veux “importer” est correct.

Toujours séparer les clés d’une hashtable par ; 
