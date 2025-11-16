🖥️ TP Active Directory – Gestion des Services
👨‍🎓 Massinissa Mameri — #300151841
Ce TP couvre la gestion, la surveillance et l’administration des services Active Directory (AD DS) à l’aide de PowerShell.
Les scripts permettent de vérifier l’état des services, consulter les logs, exporter des événements et gérer des services critiques.
________________________________________
📄 Objectifs du laboratoire
•	Lister les services AD et vérifier leur état
•	Afficher les événements spécifiques à Active Directory
•	Exporter les événements dans un fichier CSV
•	Arrêter et redémarrer un service Active Directory
________________________________________
🚀 Étape 1 — Lister les services Active Directory
📌 Fichier : services1.ps1
# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l’état d’un service spécifique
Get-Service -Name NTDS, ADWS, DFSR
✔️ Explication
•	NTDS : service principal AD DS
•	ADWS : gestion AD via PowerShell
•	DFSR : réplication SYSVOL
•	KDC : authentification Kerberos
•	Netlogon : localisation des DC + authentification
•	IsmServ : réplication inter-sites
![wait](https://github.com/user-attachments/assets/dda2ceec-65c8-4adf-bba7-6cc5138f1ac5)

 
________________________________________
🚀 Étape 2 — Afficher les événements Active Directory
📌 Fichier : services2.ps1
# Afficher les 20 derniers événements liés à NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Afficher les logs du système liés à Netlogon
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Afficher les logs via le journal moderne (Event Viewer v2)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
✔️ Explication
•	Get-EventLog : ancienne méthode
•	Get-WinEvent : méthode moderne plus complète
•	Directory Service : journal contenant les événements AD DS
![wait](https://github.com/user-attachments/assets/0becf390-39c6-4fa4-b46b-942c6d470729)

________________________________________
🚀 Étape 3 — Exporter les événements dans un fichier CSV
📌 Fichier : services3.ps1
# Créer le dossier C:\Logs si nécessaire
if (-Not (Test-Path "C:\Logs")) {
    New-Item -Path "C:\Logs" -ItemType Directory -Force
}

# Exporter les événements Directory Service
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
✔️ Explication
•	Le dossier C:\Logs est créé automatiquement
•	Les 50 derniers événements Directory Service sont enregistrés
•	Format CSV compatible Excel, Power BI, etc.
![wait](https://github.com/user-attachments/assets/16848cfe-88b8-4032-a41a-0d871b862920)

________________________________________
🚀 Étape 4 — Arrêter et redémarrer un service AD
📌 Fichier : services4.ps1
# Arrêter le service DFSR
Stop-Service -Name DFSR

# Vérifier l’état du service
(Get-Service -Name DFSR).Status

# Redémarrer le service
Start-Service -Name DFSR
⚠️ Attention
•	Ne jamais arrêter NTDS, KDC, ADWS ou Netlogon
•	DFSR est utilisé car son arrêt temporaire n’impacte pas l’authentification
![wait](https://github.com/user-attachments/assets/ff7282f0-a1a6-49d9-aef5-1e150b09fd62)

________________________________________
📊 Résumé des services AD critiques
Service	Nom technique	Rôle
Active Directory Domain Services	NTDS	Base AD, comptes, GPO
AD Web Services	ADWS	Gestion AD via PowerShell
DFS Replication	DFSR	Réplication SYSVOL
Kerberos KDC	kdc	Authentification Kerberos
Netlogon	Netlogon	Authentification + DC Locator
Intersite Messaging	IsmServ	Réplication inter-sites
________________________________________
🏁 TP terminé !
Ton travail inclut :
✔️ Les 4 scripts PowerShell
✔️ Les sorties de commandes
✔️ Les captures d’écran exigées
✔️ Les explications techniques
✔️ Format identique au modèle du professeur

