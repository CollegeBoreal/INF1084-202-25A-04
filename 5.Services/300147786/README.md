# Gestion des Services Active Directory avec PowerShell

Ce projet permet de **lister, surveiller, exporter et contrôler les services Active Directory (AD)** à l'aide de scripts PowerShell.  
Chaque script correspond à une tâche spécifique dans l’administration des services AD et la gestion des journaux.


###Services1.ps1 – Liste des services AD

Ce script permet de lister tous les services liés à Active Directory et de vérifier l’état des services clés comme **NTDS, ADWS et DFSR**.



<img width="799" height="254" alt="s1" src="https://github.com/user-attachments/assets/4a228a64-7277-4ade-a2f7-1d5332f6a0e2" />

###Services2.ps1
Ce script permet de consulter les 20 derniers événements du service annuaire et du service Netlogon.
Il utilise à la fois Get-EventLog (ancienne méthode) et Get-WinEvent (nouvelle méthode) pour obtenir les logs les plus récents.

<img width="1012" height="391" alt="s2" src="https://github.com/user-attachments/assets/35d0369a-11f6-4bd5-8c26-ebde52d07bbe" />

###Services3.ps1
Ce script exporte les 50 derniers événements AD dans un fichier CSV pour une analyse ultérieure.

<img width="772" height="85" alt="s3" src="https://github.com/user-attachments/assets/df00c8bf-ff7c-4711-9845-899e83d4280c" />

###Services4.ps1
Ce script permet d’arrêter et de redémarrer le service DFSR, et de vérifier son état avant et après l’opération.

<img width="858" height="100" alt="s4" src="https://github.com/user-attachments/assets/f79e959e-6158-4b54-a00d-acb025c61dd6" />

