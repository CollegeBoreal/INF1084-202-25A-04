# TP 7.DCs – Relation de confiance entre deux forêts Active Directory

Groupe : **300141570-300151233**  
Étudiants :  
- 300141570  
- 300151233  

## Objectif du TP

Mettre en place et vérifier une **relation de confiance (trust)** entre deux forêts Active Directory distinctes, uniquement avec des outils en ligne de commande (CLI) : PowerShell, netdom, nltest.

- Forêt locale : détectée via `Get-ADDomain` (par ex. `DC999999999-00.local`)
- Forêt distante (partenaire) : `CDC300151233-00.local`

## Scripts fournis

### `trust0.ps1` – Préparation et tests AD2

- Charge le module **ActiveDirectory**
- Récupère les informations du domaine local (`Get-ADDomain`)
- Définit la forêt distante :
  - DNSRoot : `CDC300151233-00.local`
  - NetBIOS : `CDC300151233-00`
- Demande des **identifiants administrateur** pour la forêt distante (`Get-Credential`)
- Teste la connectivité vers AD2 (`Test-Connection`)
- Récupère les informations du domaine distant (`Get-ADDomain -Server ...`)
- Affiche quelques utilisateurs d’AD2 (`Get-ADUser -Server ...`)
- Crée un **PSDrive AD2:** vers la forêt distante et liste son contenu

### `trust1.ps1` – Création du trust

- Charge le module **ActiveDirectory**
- Récupère le domaine local (`Get-ADDomain`)
- Initialise les variables :
  - Forêt locale (`localDnsRoot`)
  - Forêt distante (`remoteDnsRoot = CDC300151233-00.local`)
- Demande les mots de passe pour :
  - `Administrator@<domaine local>`
  - `Administrator@CDC300151233-00.local`
- Construit et exécute la commande :

```text
netdom trust <localDnsRoot> /domain:<remoteDnsRoot> /userD:<admin distant> /passwordD:<pwd distant> /userO:<admin local> /passwordO:<pwd local> /add /twoway /forest /force
