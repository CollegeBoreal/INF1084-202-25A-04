🛡️ Projet Final – Active Directory
🔗 Création d’un Trust entre deux Domaines AD DS

Étudiants : Amine (300150268) & Kemiche (300151292)
Cours : INF1084 – Administration Windows Server

🎯 Objectif du laboratoire

Ce projet consiste à configurer une relation de trust (approbation) entre deux domaines Active Directory afin de permettre la communication, la résolution DNS, et l’accès aux ressources entre les deux forêts.

Les objectifs exacts :

Vérifier la connectivité réseau entre les deux contrôleurs de domaine

Configurer les enregistrements DNS nécessaires

Exécuter un trust bidirectionnel via PowerShell

Tester l'accès entre les domaines

Vérifier la navigation Active Directory croisée

1️⃣ Préparation DNS

Chaque domaine doit être capable de résoudre le nom de domaine de l’autre.

✔️ Vérification DNS locale

Nous avons ajouté la zone conditionnelle sur chaque serveur et créé les enregistrements A.

📌 Exemple de zone DNS créée

2️⃣ Test de résolution DNS
Commande utilisée :
Resolve-DnsName VM01.DC300150268-40.local

✔️ Résultat attendu et obtenu :

3️⃣ Test de connectivité réseau (Ping)
Commande :
ping VM01.DC300150268-40.local

✔️ Résultat positif :

4️⃣ Exécution du script trusts1.ps1

Ce script devait créer un trust bidirectionnel.
Le script demande deux fois un mot de passe :

Le mot de passe du domaine local

Le mot de passe du domaine distant

❌ Résultat obtenu :

L’erreur indique :

The specified domain either does not exist or could not be contacted.

Cela confirme que le trust n’a pas pu être créé, malgré la connectivité réseau.

5️⃣ Vérification manuelle DNS après correction

Après modification de la zone DNS et ajout de l’enregistrement manquant :

✔️ Nouveau Resolve-DnsName fonctionnel

✔️ Nouveau Ping fonctionnel

📌 Conclusion

Même si le trust ne s’est pas créé automatiquement via le script, nous avons :

Configuré les zones DNS nécessaires

Corrigé la résolution entre les deux domaines

Vérifié le ping et le resolve

Préparé l’environnement pour exécuter correctement le trust

Réussi les tests réseau et DNS, étape obligatoire pour le trust

Ces étapes montrent que la communication entre les deux domaines fonctionne.

📝 Message final dans le README

Ce laboratoire nous a permis de comprendre le fonctionnement des trusts dans Active Directory.
Nous avons configuré le DNS, vérifié la communication, testé la résolution de noms et exécuté les scripts de trust.
Malgré l’échec du trust automatique, les prérequis réseau et DNS sont validés.
Projet réalisé par Amine & Kemiche – Groupe Active Directory.