# TP – Services Windows et Active Directory  
**Étudiant : Belkacem Medjkoune – #300150385**

## 1. Résumé du travail
Ce laboratoire avait pour objectif de manipuler et analyser les services Windows liés à Active Directory sur un contrôleur de domaine.  
À travers quatre scripts PowerShell, différentes opérations ont été réalisées :  
- Identification et vérification des services critiques d’AD DS  
- Lecture et analyse des journaux NTDS et Netlogon  
- Exportation d’événements Active Directory dans un fichier CSV  
- Arrêt, contrôle et redémarrage d’un service AD (DFSR)

Chaque étape permet de mieux comprendre le fonctionnement d’Active Directory, la gestion des services et l’importance de la journalisation dans un environnement de domaine.

---

## 2. Script 1 – Liste et état des services AD
**Script : `services1.ps1`**  
Objectif : afficher les services essentiels d’Active Directory et vérifier leur état.

### 📸 Capture d’écran

![Wait](https://github.com/user-attachments/assets/707d0154-cac7-40b0-945a-17403ba108de)
  

---

## 3. Script 2 – Consultation des journaux AD
**Script : `services2.ps1`**  
Objectif : lire les événements du Directory Service et du service Netlogon pour analyser l’activité du domaine.

### 📸 Capture d’écran
 
![Wait](https://github.com/user-attachments/assets/4769cc58-5178-4127-a18c-57c55103a56a)
  

---

## 4. Script 3 – Exportation des événements AD
**Script : `services3.ps1`**  
Objectif : exporter les événements Active Directory dans un fichier CSV pour archivage ou analyse externe.

### 📸 Capture d’écran
 
![Wait](https://github.com/user-attachments/assets/2d91629f-9bdc-45fe-9a35-fd7f4dd8ee13)
  

---

## 5. Script 4 – Gestion d’un service AD
**Script : `services4.ps1`**  
Objectif : arrêter, vérifier et redémarrer le service DFSR afin d’observer son comportement.

### 📸 Capture d’écran
 
![Wait](https://github.com/user-attachments/assets/fe0e0543-389a-423a-a852-ac4df6d9ded0)

  

---

## 6. Conclusion
Ce travail a permis d’explorer plusieurs aspects essentiels de l’administration Windows Server.  
La gestion des services, la consultation des journaux et la manipulation des composants AD DS sont des compétences fondamentales pour assurer la stabilité d’un environnement Active Directory.  
Les différentes commandes PowerShell exécutées montrent l’importance de surveiller les services critiques et de comprendre leur impact sur le domaine.

---

## 7. Fichiers inclus dans ce TP
- `services1.ps1`  
- `services2.ps1`  
- `services3.ps1`  
- `services4.ps1`  
- `README.md`  

