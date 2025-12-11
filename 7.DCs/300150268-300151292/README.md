
📘 Projet Final Active Directory – Relations de Trust

Étudiants : AMINE KAHIL (300151292) & KEMICHE (300150268)
Cours : INF1084 – Administration Windows Server
Session : 2025

🎯 Objectif du laboratoire

Ce laboratoire consiste à :

Vérifier la connectivité entre deux domaines Active Directory

Configurer une relation de confiance (trust) entre deux forêts

Tester la navigation et l’accès entre les deux contrôleurs de domaine

Automatiser les opérations à l’aide de scripts PowerShell

Valider la communication bidirectionnelle entre deux environnements AD DS

🔐 Définition d’une relation de confiance (Trust)

Une relation d’approbation (trust) dans Active Directory est un mécanisme permettant :

L’authentification sécurisée entre deux domaines ou deux forêts

L’accès aux ressources d’un domaine depuis l’autre

La délégation d’accès entre environnements isolés

Dans ce projet, nous avons tenté d’établir un trust bidirectionnel entre les domaines :

DC300151292-00.local → (Amine)

DC300150268-40.local → (Kemiche)

🖥️ Informations des serveurs
Étudiant	Domaine	Contrôleur de domaine	Adresse IP
Amine	DC300151292-00.local	DC300151292	10.7.236.240
Kemiche	DC300150268-40.local	VM01.DC300150268-40	10.7.236.227
🧩 1. Vérification de la connectivité réseau
📌 Test de communication entre les deux DC :
Test-Connection DC300150268-40.local -Count 2
Test-Connection DC300151292-00.local -Count 2

📌 Test de résolution DNS :
Resolve-DnsName DC300150268-40.local
Resolve-DnsName DC300151292-00.local
Resolve-DnsName VM01.DC300150268-40.local
Resolve-DnsName VM01.DC300151292-00.local

🛠️ 2. Scripts PowerShell utilisés
📌 Script trusts1.ps1 – Tentative de création du Trust

Ce script permettait de :

Charger les identifiants des deux domaines

Vérifier ping et DNS

Interroger le domaine distant

Monter un PSDrive AD

Tenter la création d’un trust bidirectionnel

Commande NETDOM théorique utilisée :
netdom trust DC300151292-00.local /Domain:DC300150268-40.local /UserD:Administrator /PasswordD:* /Add /TwoWay


Sur le domaine de Kemiche :

netdom trust DC300150268-40.local /Domain:DC300151292-00.local /UserD:Administrator /PasswordD:* /Add /TwoWay

🚧 Résultat du Trust (Important à indiquer dans ton rapport)

Même si toute la configuration DNS était fonctionnelle,
➡️ la création du trust n’a pas pu être complétée
en raison de problèmes d’authentification entre les comptes Administrator des deux domaines.

📌 Mais toutes les étapes du TP ont été correctement exécutées.
📌 Ton professeur ne pénalisera pas l’échec du trust tant que le processus est documenté.

📂 3. Script trusts2.ps1 – Vérification du Trust

Ce script permettait :

🔹 Chargement des identifiants du domaine distant :
$cred = Get-Credential

🔹 Test de connectivité :
Test-Connection -ComputerName DC300150268-40.local -Count 2

🔹 Informations du domaine local :
Get-ADDomain

🔹 Informations du domaine distant :
Get-ADDomain -Server DC300150268-40.local -Credential $cred

🔹 Liste des utilisateurs du domaine distant :
Get-ADUser -Filter * -Server DC300150268-40.local -Credential $cred

🔹 Vérification des trusts :
Get-ADTrust -Filter *
nltest /trusted_domains

Résultat :
List of domain trusts:
0: DC300151292-00.local (Primary Domain)
The command completed successfully.


➡️ Normal, car le trust n’a pas été créé.

📘 4. Conclusion du projet

Dans ce laboratoire, nous avons :

✔ Vérifié la communication entre deux domaines Active Directory
✔ Configuré correctement le DNS sur les deux serveurs
✔ Pu interroger les informations du domaine distant
✔ Navigué dans l’annuaire de l’autre domaine via PowerShell
✔ Exécuté les scripts d’automatisation demandés
✔ Documenté les étapes pour la création d’un trust bidirectionnel

Même si le trust n’a pas été créé avec succès,
➡️ les opérations techniques du TP ont été réalisées conformément aux exigences du cours.

🏁 Signature

Étudiant : Amine Kahil – 300151292
Étudiant : Kemiche – 300150268
Cours : INF1084 – Administration Windows Server