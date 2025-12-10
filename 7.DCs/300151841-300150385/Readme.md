🎛️ Active Directory – Relation de Confiance entre Deux Forêts

Étudiants :

Massinissa Mameri – 300151841

Belkacem – 300150385

Cours : INF1084 – Administration Windows Server
TP Final : Création et vérification d’une relation de confiance (TRUST) entre deux forêts AD

🏗️ 1. Objectif du laboratoire

Ce laboratoire a pour objectif :

De configurer un trust entre deux forêts Active Directory distinctes

De vérifier la communication entre les deux domaines

De tester la résolution DNS, l’accès aux objets AD et l’accès aux ressources partagées

D’effectuer toutes les manipulations en ligne de commande (PowerShell + netdom + nltest)

🌐 2. Infrastructure AD
Élément	Domaine de Massinissa	Domaine de Belkacem
Domaine	DC300151841-00.local	DC300150385-00.local
NETBIOS	DC300151841-00	DC300150385-00
Contrôleur de Domaine	DC300151841	DC300150385
OS	Windows Server 2019	Windows Server 2019
🛠️ 3. Commandes exécutées
✔ 3.1 – Création du Credential (OBLIGATOIRE)

Sur les deux VMs :

$cred = Get-Credential

✔ 3.2 – Vérifier le domaine distant
Depuis la VM de Massinissa :
Get-ADDomain -Server DC300150385-00.local -Credential
![wait](https://github.com/user-attachments/assets/6f1d11bd-be30-4d8b-95c9-677310fc1718)

Depuis la VM de Belkacem :
Get-ADDomain -Server DC300151841-00.local -Credential $cred

✔ 3.3 – Lister les utilisateurs du domaine distant
Massinissa → Belkacem :
Get-ADUser -Filter * -Server DC300150385-00.local -Credential $cred | Select SamAccountName, DistinguishedName
![wait](https://github.com/user-attachments/assets/3f60fdad-4771-484b-be0d-4942e133f7af)


Belkacem → Massinissa :
Get-ADUser -Filter * -Server DC300151841-00.local -Credential $cred | Select SamAccountName, DistinguishedName

✔ 3.4 – Création de la relation de confiance (TRUST) bidirectionnelle
Depuis la VM de Massinissa :
netdom trust DC300150385-00.local /Domain:DC300151841-00.local /UserD:administrator /PasswordD:* /Add /Realm /TwoWay



Depuis la VM de Belkacem :
netdom trust DC300151841-00.local /Domain:DC300150385-00.local /UserD:administrator /PasswordD:* /Add /Realm /TwoWay

✔ 3.5 – Vérification du Trust

Afficher les trusts existants :

nltest /domain_trusts


Afficher les trusted domains :

nltest /trusted_domains
![wait](https://github.com/user-attachments/assets/96e56697-abb7-4146-a57c-bf1045dc2e85)

✔ 3.6 – Test d’accès à un partage distant
Massinissa → partage de Belkacem :
net use \\DC300150385\SharedResources /user:DC300150385-00.local\administrator *

Belkacem → partage de Massinissa :
net use \\DC300151841\SharedResources /user:DC300151841-00.local\administrator *


Résultat attendu :

The command completed successfully.

📸 4. Captures d’écran à fournir
🖼️ CAPTURES sur la VM de Massinissa (DC300151841)

Get-ADDomain -Server DC300150385-00.local

Get-ADUser -Filter * -Server DC300150385-00.local

net use \\DC300150385\SharedResources

nltest /domain_trusts

nltest /trusted_domains

🖼️ CAPTURES sur la VM de Belkacem (DC300150385)

Get-ADDomain -Server DC300151841-00.local

Get-ADUser -Filter * -Server DC300151841-00.local

net use \\DC300151841\SharedResources

nltest /domain_trusts

nltest /trusted_domains

✅ 5. Conclusion

La relation de confiance entre les deux forêts :

a été créée correctement,

permet l’accès aux objets Active Directory du domaine distant,

permet l’accès aux ressources partagées,

et les tests confirment une communication fonctionnelle entre les deux environnements.

🎉 Laboratoire réussi à 100%.
