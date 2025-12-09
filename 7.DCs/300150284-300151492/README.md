# Projet Trust Active Directory

**Étudiants :** 
- Hacen (300151492)
- Mohamed (300150284)

**Date :** 9 décembre 2024

**Forêts :** DC300151492-00.local ↔️ DC300150284-00.local

---

## 1. Configuration Initiale

### 1.1 Domaine de Hacen (300151492)
- **Nom de domaine :** `DC300151492-00.local`
- **Contrôleur :** `DC300151492.DC300151492-00.local`
- **Adresse IP :** `10.7.236.242`
- **Responsable :** Hacen

### 1.2 Domaine de Mohamed (300150284)
- **Nom de domaine :** `DC300150284-00.local`
- **Contrôleur :** `DC9999999990.DC300150284-00.local`
- **Adresse IP :** `10.7.236.228` (à configurer)
- **Responsable :** Mohamed

---

## 2. Configuration DNS

### 2.1 Configuration par Hacen
```powershell
Add-DnsServerConditionalForwarderZone -Name "DC300150284-00.local" -MasterServers 10.7.236.228
```

**Statut :** ⏳ En attente (IP de Mohamed à configurer)

### 2.2 Configuration par Mohamed
```powershell
Add-DnsServerConditionalForwarderZone -Name "DC300151492-00.local" -MasterServers 10.7.236.242
```

**Statut :** ⏳ À faire par Mohamed

---

## 3. Création du Trust

**Exécuté par :** Hacen

**Commande :**
```powershell
.\creer-trust.ps1
```

**Statut :** ⏳ À faire (après configuration DNS)

---

## 4. Scripts Créés

| Script | Auteur | Description | Statut |
|--------|--------|-------------|---------|
| `creer-trust.ps1` | Hacen | Création du trust forest bidirectionnel | ✅ Créé |
| `verifier-trust.ps1` | À créer | Vérification du trust | ⏳ |
| `tester-acces.ps1` | À créer | Tests d'accès inter-forêts | ⏳ |

---

## 5. Problèmes Rencontrés

### Problème 1 : IP APIPA de Mohamed
**Description :** Mohamed a une IP auto-configurée (169.254.45.188) au lieu de l'IP réseau (10.7.236.228)

**Solution :** Mohamed doit configurer son IP statique avec :
```powershell
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 10.7.236.228 -PrefixLength 24 -DefaultGateway 10.7.236.1
```

**Statut :** ⏳ En attente

---

## 6. Prochaines Étapes

- [ ] Mohamed configure son IP réseau (10.7.236.228)
- [ ] Configuration DNS des deux côtés
- [ ] Test de connectivité (ping entre domaines)
- [ ] Création du Trust par Hacen
- [ ] Vérification du Trust
- [ ] Tests d'accès inter-forêts
- [ ] Documentation finale avec captures d'écran

---

## 7. Notes

- Mot de passe du trust : `TrustP@ss2024!`
- Mot de passe Admin par défaut : `Infra@2024`