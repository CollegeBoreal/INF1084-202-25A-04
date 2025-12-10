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

SECTION B — Commandes exécutées sur la VM de Belkacem (DC300150385)

✅ Dans cette section, nous présentons les tests effectués depuis la VM de Belkacem (DC300150385) pour vérifier la relation de confiance avec le domaine de Massinissa (DC300151841).

✅ 1. Vérification du domaine de Massinissa

Commande exécutée :

Get-ADDomain -Server DC300151841-00.local -Credential $cred

![Wait](https://github.com/user-attachments/assets/9ac0ce70-5584-4252-ad39-0a6771a0bd53)


Cette commande permet de récupérer toutes les informations du domaine de Massinissa (DC300151841-00.local) depuis la VM de Belkacem.
Le résultat montre que le domaine est accessible et reconnu, confirmant que la relation d’approbation fonctionne.

✅ 2. Liste des utilisateurs du domaine de Massinissa

Commande exécutée :

Get-ADUser -Filter * -Server DC300151841-00.local -Credential $cred | Select SamAccountName, DistinguishedName

![Wait](https://github.com/user-attachments/assets/28dd2f89-5675-4f80-bc34-d73d65ce1952)


La liste des utilisateurs est correctement affichée, ce qui confirme que Belkacem peut interroger les objets AD du domaine de Massinissa.

✅ 3. Test d’accès au partage “SharedResources”

Commande :

net use \\DC300151841\SharedResources /user:DC300151841-00.local\administrator *

![Wait](https://github.com/user-attachments/assets/1e14fbfa-fde6-43bd-8497-e8b202f18c72)


Le message “The command completed successfully.” confirme que :

Le partage de Massinissa est accessible,

L’authentification croisée entre les domaines fonctionne,

Le trust est fonctionnel dans les deux sens.

✅ 4. Vérification des trusts configurés

Commande :

nltest /domain_trusts

![Wait](https://github.com/user-attachments/assets/ed3266df-6534-4cf4-9deb-f6b891b2c3be)


Le résultat affiche bien :

Le domaine de Belkacem

Le domaine de Massinissa

Une relation Direct Outbound / Direct Inbound

Cela confirme que le trust bidirectionnel est bien établi.

✅ 5. Vérification des trusted domains

Commande :

nltest /trusted_domains

![Wait](https://github.com/user-attachments/assets/b9a35c95-0db5-483f-9acf-cdb6962d60b0)


Cette commande affiche aussi les deux domaines et confirme que la relation d’approbation est active et fonctionnelle.

✅ Résultat global

Les tests réalisés depuis la VM de Belkacem confirment que :

Le domaine de Massinissa est accessible

Les utilisateurs du domaine distant sont consultables

L’accès réseau partagé est fonctionnel

Les relations de confiance apparaissent correctement dans nltest

Cela démontre que la relation de confiance est bien configurée dans les deux sens.

✅ 6. Conclusion

La relation de confiance entre les deux forêts :

a été créée correctement,

permet l’accès aux objets Active Directory du domaine distant,

permet l’accès aux ressources partagées,

et les tests confirment une communication fonctionnelle entre les deux environnements.

🎉 Laboratoire réussi à 100%.
