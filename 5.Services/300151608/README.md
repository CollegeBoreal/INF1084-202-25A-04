travail Pratique – 5.Services (Active Directory)

INF1084 – Services Réseau

Étudiant : Mohammed Aiche

ID : 300151608

Collège Boréal – Automne 2025

Groupe : 25A-04

🟦 INTRODUCTION 

Dans ce travail pratique, j’ai appris à utiliser PowerShell 🖥️ pour analyser et surveiller les services liés à Active Directory.
J’ai vérifié l’état des services importants comme NTDS et ADWS ⚙️, consulté les journaux du système 📄 et exporté les événements pour mieux comprendre le fonctionnement du domaine.
Ce TP m’a permis d’explorer les outils essentiels utilisés par les administrateurs dans un environnement Windows Server 💼🔧.

✅ 1️⃣ – Création du dossier étudiant (300151608)

💬 Dans cette étape, je crée mon propre répertoire dans 5.Services avec la commande mkdir 300151608.
Cela permet d’organiser correctement le travail demandé par le professeur.

<img width="814" height="454" alt="ser1" src="https://github.com/user-attachments/assets/a5ca4d19-f8da-495b-a948-7fb5d733a7dd" />

✅ 2️⃣ – Création du dossier images

💬 Ici je rentre dans mon dossier avec cd 300151608 puis je crée un sous-dossier images.
Ce dossier servira à stocker toutes les captures d'écran du TP.

<img width="794" height="479" alt="ser2" src="https://github.com/user-attachments/assets/291af83d-687e-415e-a446-80dcbb667a9c" />

✅ 3️⃣ – Lister les services Active Directory

💬 Cette commande liste seulement les services importants d’Active Directory : NTDS, ADWS, DFSR, KDC, Netlogon, IsmServ.
Cela permet de vérifier rapidement si les services essentiels du domaine fonctionnent.

<img width="705" height="217" alt="ser3" src="https://github.com/user-attachments/assets/665a9cd8-7c74-4b49-b1d9-5ae4556e3108" />

✅ 4️⃣ – Vérifier l’état des services AD

💬 Avec Get-Service -Name NTDS, ADWS, DFSR, je contrôle si les principaux services AD sont en état Running.
Cela confirme que mon serveur Active Directory fonctionne correctement.

<img width="793" height="499" alt="ser4" src="https://github.com/user-attachments/assets/50312eb4-340d-4542-9aa0-c2f8dd3498b7" />

✅ 5️⃣ – Afficher les événements Active Directory (20 derniers logs)

💬 La commande Get-WinEvent -LogName "Directory Service" -MaxEvents 20 affiche les événements les plus récents du service AD.
Elle permet de voir les opérations internes comme la défragmentation et la mise à jour de la base NTDS

<img width="761" height="491" alt="ser5" src="https://github.com/user-attachments/assets/5144319e-39ae-4602-ba5b-46e71864dec9" />

✅ 6️⃣ – Exporter les logs dans un fichier CSV

💬 Ici je crée le dossier C:\Logs (s’il n’existe pas) puis j’exporte les 50 derniers événements AD dans ADLogs.csv.
Cela permet de sauvegarder les événements pour une analyse ou une vérification ultérieure.

<img width="616" height="158" alt="ser6" src="https://github.com/user-attachments/assets/47bdd076-7807-43d0-aa79-7f32689f58bc" />

✅ Conclusion

Ce travail m’a permis de comprendre comment vérifier l’état des services Active Directory, analyser les journaux du système et organiser correctement les fichiers du laboratoire. Grâce aux différentes commandes PowerShell, j’ai pu confirmer que les services essentiels fonctionnent bien et que les événements du serveur sont accessibles et exportables pour une analyse future. Ce TP m’a aidé à mieux maîtriser l’administration de base d’un contrôleur de domaine Windows.








