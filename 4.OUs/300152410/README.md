# 🚀 TP – Gestion des utilisateurs Active Directory avec PowerShell

## 👨‍💻 Informations sur l’étudiant
| Champ | Détails |
|--------|----------|
| 🧑‍🎓 **Nom complet** | Imad Boudeuf |
| 🆔 **Numéro étudiant** | 300152410 |
| 🧩 **Instance** | 0 |
| 🖥️ **Domaine** | DC300152410-0.local |
| 🏫 **Cours** | INF1084 – Administration des systèmes Windows Server |
| 🏛️ **Établissement** | Collège Boréal |

---

## 🎯 Objectif du TP
L’objectif de ce travail pratique est d’apprendre à **gérer les comptes utilisateurs, les unités organisationnelles (OU) et les groupes de sécurité** dans **Active Directory**, à l’aide de **PowerShell**.

À la fin du TP, tu seras capable de :
- Créer, modifier, activer, désactiver et supprimer des utilisateurs.  
- Créer et organiser les OU.  
- Déplacer des utilisateurs entre les conteneurs.  
- Appliquer le principe du moindre privilège.  
- Exporter la liste des utilisateurs du domaine.

---

## ⚙️ Étapes principales du script PowerShell

### 1️⃣ Configuration du domaine
```powershell
# Définir les variables de ton environnement
$studentNumber = 300152410
$studentInstance = 0

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Importer le module Active Directory
Import-Module ActiveDirectory

# Vérifier le domaine et le contrôleur
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
