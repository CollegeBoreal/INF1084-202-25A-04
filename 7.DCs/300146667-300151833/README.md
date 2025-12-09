# Projet : Relation de confiance entre deux forêts Active Directory

## Objectif
Créer via CLI une relation de confiance (trust) entre deux forêts AD distinctes, automatiser les tests et valider la communication entre domaines.

## Membres du groupe
- Raouf Bouras (300151833)
- Djaber (300146667)

## Étapes effectuées

### 1. Préparation DNS
- Vérification des IP des deux contrôleurs de domaine.
- Mise en place de la résolution croisée entre les forêts.
- Tests avec `nslookup` entre les deux domaines (`DC300151833.local` et `DC300146667-00.local`) → OK.

### 2. Tests réseau automatisés
Depuis le script PowerShell :
- `Test-Connection` vers le DC distant.
- `Resolve-DnsName` sur le domaine distant.

### 3. Vérification AD distante
Depuis le script PowerShell :
- `Get-ADDomain -Server ...` pour récupérer les infos du domaine distant.
- `Get-ADUser -Server ...` pour lister des utilisateurs de la forêt distante.

### 4. Tentative de création de trust (CLI)
Commande théorique attendue (non fonctionnelle dans notre environnement) :

```powershell
netdom trust DC300151833.local /Domain:DC300146667-00.local /Add /Twoway /UserO:Administrator /PasswordO:XXX /UserD:Administrator /PasswordD:XXX
