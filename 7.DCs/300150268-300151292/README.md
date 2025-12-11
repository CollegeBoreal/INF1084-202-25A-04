🛡️ Projet Final – Active Directory
🔗 Création d’un Trust entre deux Domaines AD DS

Étudiants : Amine (300151292) & Kemiche (300150268)
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

<img width="518" height="405" alt="Screenshot 2025-12-10 180628" src="https://github.com/user-attachments/assets/afb9e682-ea82-4a0a-b14e-fea50691ffaf" />

2️⃣ Test de résolution DNS
Commande utilisée :
Resolve-DnsName VM01.DC300150268-40.local

✔️ Résultat attendu et obtenu :
<img width="474" height="109" alt="Screenshot 2025-12-10 180818" src="https://github.com/user-attachments/assets/52fe8ac5-dd86-416f-b169-d79f1b5bca38" />


3️⃣ Test de connectivité réseau (Ping)
Commande :
ping VM01.DC300150268-40.local

✔️ Résultat positif :
<img width="467" height="163" alt="Screenshot 2025-12-10 180841" src="https://github.com/user-attachments/assets/12172029-806a-4ddd-8198-d5eb53a7b01c" />


4️⃣ Vérification du Trust (nltest / netdom / AD)

✔️ Vérification avec nltest

nltest /domain_trusts
![WhatsApp Image 2025-12-10 at 20 03 24_ca080643](https://github.com/user-attachments/assets/ef007655-0bad-4293-a7e7-1f76d7838f37)

Résultat :
👉 Le domaine DC300150268-40.local voit DC300151292-00.local dans la liste des trusts.

5️⃣ Vérification SOA du domaine distant
Resolve-DnsName DC300151292-00.local -Type SOA

![WhatsApp Image 2025-12-10 at 20 03 24_c685fd64](https://github.com/user-attachments/assets/9e17bbc1-cc04-4370-ae78-4dc46543bb85)

📝 Message final dans le README

Ce laboratoire nous a permis de comprendre le fonctionnement des trusts dans Active Directory.
Nous avons configuré le DNS, vérifié la communication, testé la résolution de noms et exécuté les scripts de trust.
Malgré l’échec du trust automatique, les prérequis réseau et DNS sont validés.
Projet réalisé par Amine & Kemiche – Groupe Active Directory.
