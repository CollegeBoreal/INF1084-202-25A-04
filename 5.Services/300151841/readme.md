# 🧮 Laboratoire – Services Windows et AD DS

## 🎯 Objectifs
- Lister les services AD et leur état  
- Afficher les événements d’un service AD  
- Exporter les événements dans un fichier CSV  
- Arrêter et redémarrer un service AD  

---

## 🧩 Scripts inclus
| Fichier | Description |
|----------|--------------|
| services1.ps1 | Lister les services AD et vérifier leur état |
| services2.ps1 | Afficher les événements récents des services AD |
| services3.ps1 | Exporter les événements AD vers un fichier CSV |
| services4.ps1 | Arrêter et redémarrer le service DFSR |

---

## 💡 Commandes PowerShell utiles
```powershell
Get-Service -Name NTDS, ADWS, DFSR, KDC, Netlogon, IsmServ
Get-EventLog -LogName "Directory Service" -Newest 20
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
