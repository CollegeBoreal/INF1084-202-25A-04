# 🖥️ TP 3 — Machines Virtuelles : Installation d’un Contrôleur de Domaine Active Directory  
**Étudiant : Youba Bouanani — 300150296**  
**Cours : INF1084 – Administration Windows**  
**Session : Automne 2025**

---

## 🎯 Objectif du laboratoire
Mettre en place un contrôleur de domaine Active Directory dans une machine virtuelle Windows Server 2022, puis valider son installation via PowerShell.  
Ce TP permet de comprendre les fondements d’un environnement Windows d’entreprise : domaine, DNS, NetBIOS, forêt et rôle AD DS.

---

## ⚙️ Configuration utilisée

| Élément | Valeur |
|--------|--------|
| **Nom du serveur** | `DC300150296-0` |
| **Nom du domaine (DNS)** | `DC300150296-0.local` |
| **Nom NetBIOS** | `DC300150296` |
| **Mot de passe DSRM** | `Password123!` |
| **Version OS** | Windows Server 2022 |
| **Rôle installé** | AD DS + DNS |

---

## 🚀 Étapes d’installation (PowerShell)

### 1️⃣ Renommage du serveur
```powershell
Rename-Computer -NewName "DC300150296-0" -Restart
