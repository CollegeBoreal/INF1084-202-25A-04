## 📘 LABO 5 – Services Active Directory (AD)
- 👤 Étudiant : Akrem Bouraoui - 300150527
- 📚 Cours : INF1084 – Administration Windows / Active Directory
- 🖥️ Projet : Gestion des Services Windows & Active Directory

-----------------------------------------------

## 🧰 1️⃣ Phase de Préparation

Avant de commencer les scripts PowerShell, j’ai d’abord effectué une configuration complète de mon environnement :

✔️ 1. Récupération du projet depuis GitHub

```powershell
git pull
```

- Cette étape garantit que j’ai la dernière version du dépôt partagé avant d’ajouter mon travail.

✔️ 2. Création de mon dossier personnel

- Dans le répertoire 5.Services : 5.Services/300150527/

✔️ 3. Création du dossier pour les captures d’écran

- 5.Services/300150527/images/

🔧 Cette structure permet d’organiser clairement mon travail, comme demandé par le professeur.


<img width="860" height="507" alt="1" src="https://github.com/user-attachments/assets/951b705e-1147-4180-8238-69703c5588e6" />

-----------------------------------------

## 🎯 2️⃣ Objectifs du Laboratoire

L’objectif principal était d’utiliser PowerShell pour analyser et manipuler plusieurs services critiques d’Active Directory :

- Lister les services AD et vérifier leur état
- Analyser les journaux d’événements
- Exporter les logs AD dans un fichier CSV
- Arrêter et redémarrer un service Windows
- Documenter chaque étape avec captures d’écran

----------------------------------------------

## 🛠️ 3️⃣ Script : services1.ps1 — Lister et Vérifier les Services AD

✔️ Fonctionnalités :

- Lister tous les services liés à AD

```powershell
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName
```

- Vérifier l’état d’un service spécifique

```powershell
Get-Service -Name NTDS, ADWS, DFSR
```

<img width="1093" height="543" alt="2" src="https://github.com/user-attachments/assets/82c701a4-ac34-41ab-bcb5-0d1405b7843c" />

----------------------------------------

## 🛠️ 4️⃣ Script : services2.ps1 — Analyse des Événements AD

✔️ Fonctionnalités :

- Afficher les 20 derniers événements liés à NTDS

```powershell
Get-EventLog -LogName "Directory Service" -Newest 20
```

<img width="1080" height="492" alt="3-1" src="https://github.com/user-attachments/assets/1bbe8135-5b66-4c05-80d3-51c607748f78" />

- Afficher les logs du système

```powershell
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}
```

- Afficher les logs via le journal moderne (Event Viewer v2)

```powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
```

<img width="1108" height="540" alt="3-2" src="https://github.com/user-attachments/assets/088fe6ad-9124-4d1d-afb4-93487ae9b338" />


-----------------------------------------------------------------------


## 🛠️ 5️⃣ Script : services3.ps1 — Exportation des Logs AD

✔️ Fonctionnalités :

- Vérifie si le dossier C:\Logs existe, Le crée automatiquement si nécessaire, Exporte les événements AD dans ADLogs.csv :

- Créer le dossier C:\Logs s'il n'existe pas

```powershell
if (!(Test-Path -Path "C:\Logs")) {
    New-Item -ItemType Directory -Path "C:\Logs" | Out-Null
}
```

- Exporter les événements Directory Service vers CSV

```powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
```

- Vérifier que le dossier existe

```powershell 
Test-Path C:\Logs
```

- Lister le contenu (pour confirmer la présence de ADLogs.csv)

```powershell  
Get-ChildItem C:\Logs
```

📁 Vérifications effectuées :

- Test-Path C:\Logs → True, Fichier généré : C:\Logs\ADLogs.csv

<img width="1114" height="542" alt="4" src="https://github.com/user-attachments/assets/dce6a0f2-da66-4878-bfb6-cb1472ad841d" />

--------------------------------------------------

## 🛠️ 6️⃣ Script : services4.ps1 — Gestion du Service DFSR

✔️ Fonctionnalités :

- Vérifier l'état initial du service

```powershell  
Get-Service -Name DFSR
```

- Arrêter le service DFSR
  
```powershell
Stop-Service -Name DFSR
```

- Vérifier l'état après arrêt

```powershell
(Get-Service -Name DFSR).Status
```

- Démarrer le service DFSR
  
```powershell
Start-Service -Name DFSR
```

- Vérifier l'état final
  
```powershell
(Get-Service -Name DFSR).Status
```

<img width="1113" height="540" alt="5" src="https://github.com/user-attachments/assets/4a85ed4c-2e3f-4f99-b276-2e660d84ea5a" />

---------------------------------------------

## 🧠 7️⃣ Ce que j'ai appris

Grâce à ce laboratoire, j’ai pu développer les compétences suivantes :

🔹 Administration PowerShell :

Lister, filtrer et manipuler des services Windows

Lire et exporter des journaux d’événements

🔹 Compréhension des services AD :

NTDS : Active Directory Domain Services

DFSR : Réplication SYSVOL

KDC : Kerberos Authentication

Netlogon : Authentification réseau


---------------------------------------------------------


## 🏁 8️⃣ Conclusion

Ce laboratoire m’a permis d’approfondir mes compétences en administration Windows Server, en particulier dans la gestion des services Active Directory et l’utilisation de PowerShell.
Ces compétences sont essentielles pour diagnostiquer des problèmes, automatiser des tâches administratives et gérer un environnement professionnel AD DS.




