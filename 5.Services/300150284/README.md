# TP – Gestion des Services Windows avec PowerShell  
##  Étudiant : **Aroua Mohand Tahar (300150284)**  
Cours : INF1084 – Administration Windows  
Date : 2025  

---

## 🎯 Objectifs du TP

Ce laboratoire avait pour objectif :

- Manipuler les services Windows via PowerShell  
- Vérifier l’état d’un service  
- Démarrer et arrêter un service  
- Filtrer les services selon leur état  
- Exporter la liste des services dans un fichier CSV  

Les scripts réalisés permettent d’automatiser la gestion des services sur un serveur Windows.

---

# 📁 Scripts réalisés

Le dossier contient **4 scripts PowerShell**, chacun avec une fonction précise :

| Script | Description |
|--------|-------------|
| `services1.ps1` | Recherche et affiche l’état d’un service spécifique |
| `services2.ps1` | Démarre ou arrête un service selon l’action choisie |
| `services3.ps1` | Affiche les services Running ou Stopped selon le filtre |
| `services4.ps1` | Exporte tous les services Windows dans un fichier CSV |

---

# 🧪 1️⃣ Script : `services1.ps1`

### ✔ Objectif  
Rechercher un service par son nom et afficher son état (Running / Stopped).

### ✔ Paramètre utilisé  
`-ServiceName`

### ✔ Exemple d’utilisation
```powershell
.\services1.ps1 -ServiceName "W32Time"
✔ Résultat attendu
Affichage du service :

sql
Copier le code
Status   Name       DisplayName
Running  W32Time    Windows Time
 ![wait](https://github.com/user-attachments/assets/e2bc1c43-e429-4460-9a10-7e392b747905)


 

🧪 2️⃣ Script : services2.ps1
✔ Objectif
Démarrer ou arrêter un service en choisissant l’action.

✔ Paramètres
-Action : start ou stop

-ServiceName : nom du service à gérer

✔ Exemple : arrêter un service
powershell
Copier le code
.\services2.ps1 -Action stop -ServiceName "W32Time"
✔ Exemple : démarrer un service
powershell
Copier le code
.\services2.ps1 -Action start -ServiceName "W32Time"
🧪 3️⃣ Script : services3.ps1
✔ Objectif
Lister uniquement les services qui sont :

Running

Stopped

✔ Paramètre
-State

✔ Exemple : services Running
powershell
Copier le code
.\services3.ps1 -State Running
✔ Exemple : services Stopped
powershell
Copier le code
.\services3.ps1 -State Stopped
✔ Résultat attendu
Liste filtrée des services selon leur état.

🧪 4️⃣ Script : services4.ps1
✔ Objectif
Exporter la liste de tous les services Windows dans un fichier CSV
(utile pour un rapport ou diagnostic système).

✔ Fonctionnement
Récupère tous les services

Sélectionne Name, Status, DisplayName

Génère un fichier : services_300150284.csv

✔ Exemple d’exécution
powershell
Copier le code
.\services4.ps1
✔ Résultat
Un fichier est créé :

Copier le code
services_300150284.csv
📚 Compétences acquises
Grâce à ce TP, j’ai appris à :

Utiliser PowerShell pour gérer les services Windows

Automatiser des actions administratives

Contrôler l’état d’un service système

Exporter des données pour analyse

Comprendre la structure et le fonctionnement des services Windows

✔ Validation
Tous les scripts ont été testés avec succès dans Windows Server 2022.
