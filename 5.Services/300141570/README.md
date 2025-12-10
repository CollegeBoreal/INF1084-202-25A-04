300141570 Haroune Berkani
## 📸 Capture 1 — Exécution du script services3.ps1 (Affichage des logs AD DS)
<img width="1302" height="200" alt="3" src="https://github.com/user-attachments/assets/272ee308-1bc8-4983-bf0f-44b2c7908a53" />
Cette capture montre l’exécution du script `services3.ps1`, qui permet d’afficher les événements récents liés au service Active Directory Domain Services (NTDS). 
On observe dans la console plusieurs logs de type *Information*, confirmant que les opérations internes (défragmentation en ligne, réplication, maintenance NTDS) fonctionnent correctement.  
Cette étape démontre que le contrôleur de domaine enregistre bien ses événements et que le script fonctionne pour l’analyse des logs AD DS.

---

## 📸 Capture 2 — Liste des services AD DS via services1.ps1
<img width="1918" height="1078" alt="2" src="https://github.com/user-attachments/assets/48b563be-8ad7-4d9d-be08-9f413b462860" />
Cette capture correspond à l’exécution du script `services1.ps1`, qui liste les principaux services Active Directory :
- NTDS (Active Directory Domain Services)
- ADWS (Active Directory Web Services)
- DFSR (DFS Replication)
- KDC (Kerberos Key Distribution Center)
- Netlogon
- IsmServ

Le statut *Running* confirmé pour chaque service montre que tous les services essentiels d’Active Directory fonctionnent normalement.

---

## 📸 Capture 3 — Exécution du script services4.ps1 (Arrêt et redémarrage du service DFSR)
<img width="1018" height="267" alt="1" src="https://github.com/user-attachments/assets/d9b66c06-4aa3-4b3c-846a-9955cc5c723d" />
Cette capture montre l'exécution du script `services4.ps1`, qui :
1. Arrête le service DFSR  
2. Vérifie son statut  
3. Redémarre le service  

Le résultat affiche d’abord **Stopped**, puis **Running**, ce qui confirme le bon fonctionnement du script et la capacité à gérer un service Windows lié à Active Directory.

---

## 📸 Capture 4 — Vérification finale du statut des services AD DS
<img width="811" height="160" alt="Screenshot 2025-12-10 032354" src="https://github.com/user-attachments/assets/24049ecd-a47e-41f0-aa20-3244de4e0e09" />
Cette capture affiche :
- La liste complète des services Active Directory
- Le statut final du service DFSR après redémarrage
- Le résultat de la commande `(Get-Service DFSR).Status`

Cette étape prouve que les services AD DS sont stables après manipulation et que les scripts exécutés ont produit les résultats attendus.






