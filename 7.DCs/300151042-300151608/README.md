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


![WhatsApp Image 2025-12-09 at 17 10 04 (6)](https://github.com/user-attachments/assets/0f99db9b-aecf-46e5-ad27-4d3260de9817)

voici mes effort pour avoir le nom du domain 
<img width="1366" height="768" alt="Capture d’écran (175)" src="https://github.com/user-attachments/assets/86caf69c-1b7f-4ffa-9339-a5f79b77d02a" />



