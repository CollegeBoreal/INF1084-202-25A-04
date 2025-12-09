Projet Active 7.DCs – Mohammed Aiche & Hichem Hamdi

Mise en Place et Automatisation d’une Relation de Confiance Bidirectionnelle entre Deux Forêts Active Directory

Titre : Test-Connection vers la forêt de Hichem

<img width="712" height="116" alt="windows 01" src="https://github.com/user-attachments/assets/2ca725f1-12d0-43cc-9c67-b5b8cb04c257" />

Le serveur DC300151608 arrive à joindre dc300151042.local avec Test-Connection.
La communication réseau fonctionne, nécessaire avant de créer le trust.

Fenêtre d’authentification pour la seconde forêt

<img width="929" height="447" alt="windows 02" src="https://github.com/user-attachments/assets/3bb465c3-211c-43e3-94bb-76251a81bf89" />

PowerShell demande les identifiants administrateur de DC300151042-00, ce qui confirme que la connexion entre les deux domaines fonctionne et que l’interrogation AD est possible.

Lecture du domaine DC300151042 via PowerShell


<img width="953" height="482" alt="windows 03" src="https://github.com/user-attachments/assets/c5dd89d1-8e6d-4944-816a-77f277a1e01f" />


La commande Get-ADDomain affiche toutes les informations de la forêt distante : DN, DNSRoot, Controllers, SID…
Cela confirme que l’accès administratif au domaine de Hichem fonctionne.

Récupération des comptes utilisateurs du domaine distant

<img width="920" height="221" alt="windows 04" src="https://github.com/user-attachments/assets/e6848929-a752-42d9-988e-3b577a96300b" />

La commande Get-ADUser -Filter * list les utilisateurs de la forêt DC300151042.
Preuve que la communication AD entre les deux forêts fonctionne correctement.

Montage du PSDrive AD2

<img width="593" height="283" alt="windows 05" src="https://github.com/user-attachments/assets/89ee19ad-130f-4791-9938-f9269d97ad39" />

Le PSDrive AD2 pointe vers l’AD de DC300151042-00.
Cela permet de naviguer dans la forêt distante comme dans un disque.


nslookup et ping vers la forêt Hichem

<img width="579" height="340" alt="windows 06" src="https://github.com/user-attachments/assets/2d3b10ad-6d7a-4cad-8583-cf246dd2136c" />

nslookup résout correctement DC300151042-00.local → 10.7.236.238 et 10.0.0.10.
Le ping montre un TTL expiré mais pas de perte, ce qui indique que le routage fonctionne.
DNS OK = condition essentielle pour créer un trust.

📸 Image 1 — Export et redémarrage du service NFS

Titre : Application des exports NFS

![WhatsApp Image 2025-12-09 at 17 10 04 (4)](https://github.com/user-attachments/assets/30b03ede-2012-49a9-b12a-ccb4d917942e)

La commande sudo exportfs -a applique les règles d’exportation, puis sudo systemctl restart nfs-kernel-server redémarre le service pour activer la configuration.

📸 Image 2 — Tests Ping et DNS entre les deux contrôleurs AD

Titre : Validation DNS et connectivité entre les deux forêts

![WhatsApp Image 2025-12-09 at 17 10 04](https://github.com/user-attachments/assets/7763d520-3c58-4a5a-8c87-fb7c50f958e6)

Les tests montrent des difficultés de résolution DNS (erreur “non-existent domain”), puis un ping réussi après correction.
La communication réseau fonctionne finalement entre les deux DC.

📸 Image 3 — Vérification du Trust avec NLTEST

Titre : Vérification du trust entre les domaines

![WhatsApp Image 2025-12-09 at 17 10 04 (1)](https://github.com/user-attachments/assets/e48b1948-6e53-4004-8ef5-90f47874ca36)

La commande nltest /trusted_domains affiche les trusts configurés.
Les deux domaines apparaissent : preuve que la relation de confiance existe et fonctionne.

📸 Image 4 — Test-Connection vers DC300151608

Titre : Ping de la forêt distante

![WhatsApp Image 2025-12-09 at 17 10 04 (3)](https://github.com/user-attachments/assets/e69bd485-ebb4-46eb-aac9-42a0cb00dd43)

Test-Connection répond avec 1ms, ce qui confirme une bonne connectivité entre les DC.

📸 Image 5 — Authentification avec Get-Credential

Titre : Saisie des identifiants du domaine partenaire

![WhatsApp Image 2025-12-09 at 17 10 04 (4)](https://github.com/user-attachments/assets/ad3f6258-7b11-4d3c-be67-87c5b10bfbbb)

La commande Get-Credential recueille les identifiants administrateur du domaine DC300151042-00, nécessaires pour créer ou vérifier le trust.


✅ Conclusion

La mise en place de la relation de confiance entre les forêts DC300151608.local et DC300151042-00.local a été réalisée avec succès.
Les tests préalables — résolution DNS, communication réseau, interrogation du domaine distant et authentification — ont confirmé que l’infrastructure était prête pour établir le trust.

Grâce aux commandes PowerShell utilisées (Test-Connection, nslookup, Get-ADDomain, Get-ADUser, PSDrive, nltest), nous avons pu :

vérifier la connectivité entre les deux contrôleurs de domaine,

valider la résolution DNS des deux forêts,

accéder aux objets du domaine partenaire,

confirmer la création effective du trust via NLTEST,

assurer que la relation de confiance est fonctionnelle dans les deux sens.

Ce projet démontre notre capacité à configurer et administrer un environnement Active Directory multi-forêts, tout en utilisant des outils d’automatisation pour faciliter la gestion réseau.
La communication entre les deux forêts est maintenant opérationnelle, permettant le partage sécurisé de ressources et l’authentification inter-domaines.


voici mes effort pour avoir le nom du domain 
<img width="1366" height="768" alt="Capture d’écran (175)" src="https://github.com/user-attachments/assets/86caf69c-1b7f-4ffa-9339-a5f79b77d02a" />



