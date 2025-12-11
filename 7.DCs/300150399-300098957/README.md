# Création d’un trust entre deux forêts Active Directory

## Contexte

Travail réalisé dans le cadre du cours **Administration Windows (INF1084)**.

- **Étudiant :** Chakib Rahmani (300150399)
- **Binôme :** Enseignant (300098957) - **VM**: 10.7.236.170
- **Objectif :** Mettre en place et documenter, en CLI uniquement, la création et la vérification d’un trust entre deux forêts Active Directory.

---

## Topologie des forêts

### Forêt locale (étudiant)
- Domaine : DC300150399-00.local
- Rôle : Contrôleur de domaine et serveur DNS
- Environnement : VM Windows Server

### Forêt distante (enseignant)
- Domaine : DC300098957-00.local
- Rôle : Forêt distante avec laquelle le trust doit être établi
- Type : Domaine interne de laboratoire (non résolu par les DNS publics)

---

## Étape 1 – Vérification DNS et connectivité

Les commandes suivantes ont été utilisées depuis le contrôleur de domaine local :

> Resolve-DnsName DC300098957-90.local
```lua
Name                                           Type   TTL   Section    IPAddress
----                                           ----   ---   -------    ---------
DC300098957-90.local                           A      0     Answer     10.7.236.170
```

Résultat :
- Succès de la résolution DNS

Conclusion :
:x: `à revoir` 
> La forêt locale ne peut pas résoudre la forêt distante. Un **conditional forwarder DNS** est requis avant toute création de trust.

---

## Étape 2 – Préparation du trust (script trusts1.ps1)

Le script `trusts1.ps1` permet :

- La définition des variables des deux forêts
- La vérification DNS et réseau
- La demande des identifiants administrateur de la forêt distante
- La documentation de la commande nécessaire à la création du forwarder DNS

La commande DNS prévue (non exécutée tant que l’IP n’est pas fournie) est :

Add-DnsServerConditionalForwarderZone  
-Name "DC300098957-90.local"  
-MasterServers <IP_DNS_PROF>  
-ReplicationScope Forest  

---

## Étape 3 – Création et vérification du trust (script trusts2.ps1)

Le script `trusts2.ps1` prépare la création d’un trust :

- Type : Forest trust
- Direction : Bidirectionnelle
- Transitivité : Forest transitive

Commandes utilisées dans le script :
- New-ADTrust
- Get-ADTrust
- API .NET : GetAllTrustRelationships()

Des commandes de test sont également prévues pour :
- Interroger le domaine distant
- Vérifier l’existence du trust
- Tester l’accès entre forêts

---

## Limitations actuelles

Le trust ne peut pas être créé tant que l’adresse IP du serveur DNS de la forêt distante n’est pas communiquée par l’enseignant.

Les scripts sont prêts et documentés pour être exécutés dès que cette information sera disponible.

---

## Conclusion

Ce travail démontre que :
- Le DNS est un prérequis obligatoire à tout trust Active Directory
- L’automatisation par PowerShell permet une configuration sécurisée et reproductible
- Les scripts fournis couvrent l’ensemble du processus : diagnostic, création et vérification

---
## trust reussit

<img src="Capture d’écran 2025-12-10 233537.png" alt="Girl in a jacket" width="900" height="700">


## Références
- Documentation Microsoft Active Directory
- Commandes PowerShell : New-ADTrust, Get-ADTrust, Add-DnsServerConditionalForwarderZone
