\# TP Services Active Directory - 300150296



\## 🎯 Objectif

Gérer et surveiller les services Active Directory avec PowerShell



\## 📊 Services AD critiques



| Service | Nom technique | Rôle |

|---------|---------------|------|

| Active Directory Domain Services | NTDS | Service principal du DC |

| Active Directory Web Services | ADWS | Interface PowerShell/API |

| DFS Replication | DFSR | Réplication SYSVOL |

| Kerberos KDC | kdc | Authentification Kerberos |

| Netlogon | Netlogon | Authentification réseau |



\## 📝 Scripts créés



\### services1.ps1

\- Liste tous les services Active Directory

\- Affiche leur état (Running/Stopped)

\- Vérifie les services principaux (NTDS, ADWS, DFSR)



\### services2.ps1

\- Affiche les événements du Directory Service

\- Consulte les logs Netlogon

\- Utilise Get-EventLog et Get-WinEvent



\### services3.ps1

\- Exporte les 50 derniers événements AD

\- Sauvegarde en format CSV

\- Créé le fichier : `C:\\Logs\\ADLogs\_300150296.csv`



\### services4.ps1

\- Arrêt contrôlé du service DFSR

\- Vérification de l'état

\- Redémarrage du service

\- Confirmation de l'opération



\## ⚠️ Avertissements



\- Ne jamais arrêter le service NTDS (DC devient indisponible)

\- DFSR est utilisé pour les tests car son impact est limité

\- Toujours vérifier l'état après une opération



\## ✅ Compétences acquises



\- Gestion des services Windows avec PowerShell

\- Consultation des journaux d'événements

\- Export de données en CSV

\- Contrôle des services critiques AD

\- Surveillance de l'infrastructure AD

