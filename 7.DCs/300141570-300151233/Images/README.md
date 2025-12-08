Screenshot 1.1.png – Test du ping vers le domaine distant (communication réseau OK)
<img width="1912" height="1076" alt="1 1" src="https://github.com/user-attachments/assets/2039b14d-b5b7-4487-b0ad-59491a328730" />

Screenshot 1.2.png – Vérification réussie du ping entre les deux DC (latence et connectivité)

<img width="1915" height="1076" alt="1 2" src="https://github.com/user-attachments/assets/e3c49c8d-5d65-4e38-9c44-6dd029f80757" />

Screenshot 1.png – Exécution du script trust0.ps1 et confirmation de création du trust bidirectionnel
<img width="1918" height="1079" alt="1" src="https://github.com/user-attachments/assets/7606abf3-8290-4c20-953c-d45225c4df0c" />

Screenshot 2.png – Ouverture de la console Active Directory Domains and Trusts
<img width="1035" height="166" alt="2" src="https://github.com/user-attachments/assets/9110751a-90ff-4fcd-a729-b0d087bb1c79" />


Screenshot 3.1.png – Affichage des détails AD via Get-ADDomain (informations du domaine local)

<img width="1913" height="1077" alt="3 1" src="https://github.com/user-attachments/assets/0657e3e6-e68e-4a9d-abbe-354b1872faf9" />

Screenshot 3.2.png – Requête Get-ADDomain sur le domaine distant (ADWS fonctionne)
<img width="1491" height="565" alt="3 2" src="https://github.com/user-attachments/assets/6f6f98f7-0eca-46bf-9f7e-6327ddf6cf99" />


Screenshot 4.png – Test-Connection avec succès entre DC local et DC distant
<img width="1652" height="546" alt="4" src="https://github.com/user-attachments/assets/c1865441-adc4-45b7-8a04-715456c26fb6" />


Screenshot 5.png – Get-ADDomain (domaine local) – affichage complet des propriétés AD
<img width="953" height="455" alt="5" src="https://github.com/user-attachments/assets/7bf18878-274f-4721-a455-594dfb3ce7c8" />


Screenshot 6.png – Get-ADDomain -Server DC distant – validation de la visibilité inter-domaines
<img width="1917" height="1076" alt="6" src="https://github.com/user-attachments/assets/500e00b4-2feb-42fb-993e-59758a48f3ff" />


Screenshot part 3.png – Get-ADTrust -Filter * – validation du trust bidirectionnel (Bidirectional, MIT)
<img width="751" height="156" alt="part 3" src="https://github.com/user-attachments/assets/9d5a7d10-4cc2-4c43-bd64-8368c9ee0442" />
