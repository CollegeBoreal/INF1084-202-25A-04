\# 🗂️ TP 4 — Active Directory : Gestion des Unités d’Organisation (OUs)  

\*\*Étudiant : Youba Bouanani — 300150296\*\*



---



\## 🎯 Objectif du TP

Créer et gérer les unités d’organisation (OUs) dans Active Directory, manipuler les utilisateurs et automatiser les actions avec PowerShell.



---



\## ⚙️ Configuration du domaine



| Élément | Valeur |

|--------|--------|

| Numéro étudiant | 300150296 |

| Instance | 00 |

| Domaine (DNS) | DC300150296-00.local |

| NetBIOS | DC300150296-00 |

| Mot de passe | Infra@2024 |



---



\## 🔧 1. bootstrap.ps1 (initialisation du domaine)



```powershell

$studentNumber = 300150296

$studentInstance = 0



$domainName = "DC$studentNumber-$studentInstance.local"

$netbiosName = "DC$studentNumber-$studentInstance"



$plain = "Infra@2024"

$secure = ConvertTo-SecureString $plain -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)



