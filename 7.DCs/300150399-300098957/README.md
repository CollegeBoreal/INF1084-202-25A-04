🛡️ Création et Validation d’un Trust entre Deux Forêts Active Directory
📌 Contexte du travail

Travail réalisé dans le cadre du cours INF1084 – Administration Windows au Collège Boréal.

Étudiant : Chakib Rahmani (300150399)

Binôme / Forêt distante : Enseignant (300098957)

Adresse de la VM distante : 10.7.236.170

Objectif général : Créer et valider un trust entre deux forêts Active Directory, en ligne de commande uniquement (CLI), tout en documentant les étapes nécessaires (DNS, vérification, tests d’accès).

🌳 Topologie des deux forêts
🔵 Forêt locale (étudiant)

Domaine : DC300150399-00.local

Rôle : Contrôleur de domaine (DC) + Serveur DNS

Environnement : VM Windows Server (étudiant)

🟢 Forêt distante (enseignant)

Domaine : DC300098957.local

DC distant : DC300098957-90.local

Adresse IP : 10.7.236.170

Type : Domaine interne de laboratoire (non résolu par Internet)

🧪 Étape 1 — Vérification DNS et Connectivité

Depuis le contrôleur de domaine local, la commande suivante permet de vérifier la résolution DNS :

Resolve-DnsName DC300098957-90.local


Sortie obtenue :

Name                     Type  TTL  Section  IPAddress
----                     ----  ---  -------  ---------
DC300098957-90.local      A     0    Answer   10.7.236.170

✔️ Résultat

Résolution DNS réussie

Connectivité ICMP confirmée

❗ Conclusion initiale

La forêt locale ne pouvait pas résoudre la forêt distante avant l’ajout du conditional forwarder.
Une configuration DNS était donc obligatoire avant toute création de trust.

⚙️ Étape 2 — Préparation du Trust (script trusts1.ps1)

Le script trusts1.ps1 réalise les actions suivantes :

🔧 Fonctionnalités du script :

Définition des variables (domaine local, domaine distant, IP du DC distant)

Vérification DNS + ICMP

Demande des identifiants administrateur du domaine distant

Génération de la commande recommandée pour ajouter un conditional forwarder

💡 Commande recommandée (documentée dans le script)
Add-DnsServerConditionalForwarderZone `
  -Name "DC300098957.local" `
  -MasterServers "10.7.236.170" `
  -ReplicationScope "Forest"


Cette commande n’était pas exécutée automatiquement : elle est fournie pour être lancée une fois l’information du prof confirmée.

🔐 Étape 3 — Création et Vérification du Trust (script trusts2.ps1)

Le script trusts2.ps1 automatise la validation du trust entre les deux forêts.

🔧 Opérations réalisées :

Vérification DNS, ICMP et accès réseau

Interrogation du domaine distant via :

Get-ADDomain

Get-ADUser

Vérification du trust via :

Get-ADTrust

API .NET : GetAllTrustRelationships()

Test d’accès inter-forêt (SMB via \\DC300098957-90.local\NETLOGON)

🔎 Type de trust configuré :

Forest trust

Bidirectionnel

Transitifs entre forêts

🔐 Commande utilisée pour créer le trust (exécutée manuellement) :
netdom trust DC300150399-00.local /Domain:DC300098957.local /UserD:Administrator /PasswordD:* /Add /Realm /TwoWay


✔️ Résultat : Trust créé avec succès.

🟢 Étape 4 — Vérification du Trust (réussite)

La commande suivante confirme l’existence du trust :

Get-ADTrust -Filter *


Sortie (exemple) :

Name              Source                     Target              Direction
----              ------                     ------              ---------
DC300098957.local DC=DC300150399-00,DC=local DC300098957.local   Bidirectional

🖼️ Trust opérationnel (capture)
<img src="images/Capture d’écran 2025-12-10 233537.png" width="900"/>
📌 Limitations initiales résolues


✅ Conclusion

Ce travail démontre :

L’importance critique du DNS dans la mise en place d’un trust Active Directory

L’intérêt de l’automatisation via PowerShell pour :

Diagnostiquer

Configurer

Vérifier
de manière reproductible, claire et professionnelle

Les scripts trusts1.ps1 et trusts2.ps1 assurent un pipeline complet :
diagnostic → configuration → vérification.

📚 Références

Documentation Microsoft Active Directory

Commandes PowerShell :

New-ADTrust

Get-ADTrust

Add-DnsServerConditionalForwarderZone

netdom trust


mon nom de domaine n'est pas encore disponible.
