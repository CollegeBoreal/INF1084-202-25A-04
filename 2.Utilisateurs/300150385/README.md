Travail réalisé

Nom : MEDJKOUNE
Prénom : BELKACEM
Numéro étudiant : 300150385

Ce travail pratique avait pour objectif de simuler un environnement Active Directory à l’aide de PowerShell afin de mieux comprendre la logique des utilisateurs, des groupes et des unités d’organisation (OU).
Voici l’ensemble des actions réalisées durant ce TP :

1️⃣ Création des utilisateurs simulés

J’ai construit une liste d’utilisateurs sous forme d’objets PowerShell.

Trois premiers utilisateurs ont été créés : Dupont Alice, Lemoine Sarah, Benali Karim, tous dans l’OU Stagiaires.

J’ai ensuite ajouté deux utilisateurs supplémentaires afin d’enrichir la liste, conformément aux exigences de l’exercice 1.

L’affichage final a permis de vérifier que l’ensemble des utilisateurs apparaissait correctement.

2️⃣ Création et gestion des groupes

Deux groupes ont été définis : GroupeFormation et ProfesseursAD.

J’ai ajouté un premier utilisateur dans GroupeFormation pour valider la structure.

Ensuite, comme demandé dans l’exercice 2, j’ai ajouté tous les utilisateurs appartenant à l’OU Stagiaires dans ce groupe.

3️⃣ Application de filtres et requêtes PowerShell

J’ai utilisé Where-Object pour effectuer des recherches ciblées :

utilisateurs dont le nom commence par B,

utilisateurs appartenant à l’OU Stagiaires.

Pour l’exercice 3, j’ai exécuté un filtre permettant de trouver tous les utilisateurs dont le prénom contient la lettre “a”, sans distinguer les majuscules et minuscules.

4️⃣ Exportation et importation CSV

J’ai exporté tous les utilisateurs simulés dans un fichier CSV :
UsersSimules.csv.

J’ai ensuite importé ce fichier dans PowerShell pour recharger les utilisateurs.

Enfin, comme demandé, j’ai créé un groupe ImportGroupe dans lequel j’ai ajouté tous les utilisateurs importés.

5️⃣ Mini-projet final

Pour finaliser le TP, j’ai réalisé un script complet comprenant :

La création de 5 utilisateurs simulés dans l’OU Promo2025.

La création du groupe Etudiants2025.

L’ajout automatique de tous les utilisateurs Promo2025 dans ce groupe.

L’exportation de la liste finale des membres du groupe sous format CSV pour preuve et documentation.

Conclusion

Ce TP m’a permis de comprendre concrètement comment manipuler les objets Active Directory en PowerShell, même dans un environnement simulé. La création d’utilisateurs, la gestion de groupes, l’utilisation de filtres et l’exportation de données représentent des opérations essentielles en administration système. Ces exercices m’ont aidé à renforcer ma maîtrise des applets de commande ADDS et à me préparer efficacement à la gestion réelle d’un environnement Active Directory professionnel.
