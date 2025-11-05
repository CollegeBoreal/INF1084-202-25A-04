# Laboratoire : Services Windows et Active Directory (AD DS)
**Étudiant :** Ismail Trache  
**ID :** 300150395  

---

## Objectifs
- Identifier et vérifier les services Active Directory.  
- Consulter et exporter les journaux d'événements AD.  
- Arrêter et redémarrer un service AD critique (DFSR).  

---

## Scripts PowerShell

| Script | Fonction |
|:--|:--|
| `services1.ps1` | Lister les services AD et vérifier leur état |
| `services2.ps1` | Afficher les journaux Directory Service et Netlogon |
| `services3.ps1` | Exporter les logs Directory Service dans `C:\Logs\ADLogs.csv` |
| `services4.ps1` | Arrêter et redémarrer le service DFSR |

---

## Captures d’écran

1. Liste et état des services AD  
2. Journaux Directory Service (Event Viewer / PowerShell)  
3. Export des logs CSV dans `C:\Logs`  
4. Arrêt et redémarrage du service DFSR  

---

## Observations

- Tous les services AD essentiels (`NTDS`, `ADWS`, `DFSR`, `KDC`, `Netlogon`, `IsmServ`) sont **en cours d’exécution**.  
- Les événements du journal `Directory Service` montrent des opérations de **défragmentation réussies (Event ID 3027, 700, 701)**, signe d’un service AD DS fonctionnel.  
- L’arrêt/redémarrage du service DFSR s’effectue **sans erreur**, prouvant la bonne configuration du domaine.  

---

## Conclusion
Ce laboratoire a permis de comprendre le rôle et la dépendance des principaux services d’Active Directory, ainsi que leur gestion via **PowerShell et l’Event Viewer**.
