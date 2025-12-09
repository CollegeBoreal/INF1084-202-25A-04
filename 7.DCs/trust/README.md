# Récapitulatif de l'Exercice sur l'Approbation (Trust)

## Contexte de l'Exercice

Vous avez créé une **relation d'approbation (trust)** entre deux domaines/réalmes :

- **Domaine local :** `DC300098957-90.local` (domaine Active Directory Windows)
- **Domaine approuvé :** `DC300098957-40.local` (réalme Kerberos MIT)

## Configuration de l'Approbaation Créée

### Propriétés de l'Approbaation :
- **Type d'approbation :** REALM (approbation Kerberos)
- **Direction :** BIDIRECTIONNELLE (Two-way)
- **Chiffrement :** AES non supporté par le domaine distant
- **Transitivité :** Non transitive (par défaut pour les réalmes)

### Signification de la Configuration :
- **Bidirectionnelle :** Les utilisateurs des deux domaines peuvent s'authentifier mutuellement
- **Réalme :** Connexion entre un domaine Windows et un environnement Kerberos non-Windows
- **Non transitive :** L'approbation est limitée aux deux domaines directement impliqués

## Commandes de Vérification Utilisées

### 1. Vérification basique :
```cmd
nltest /trusted_domains
```
**Résultat obtenu :**
```
0: DC300098957-40.local (MIT) (Direct Outbound) (Direct Inbound)
```
→ **Preuve que l'approbation fonctionne**

### 2. Commandes de Test Supplémentaires :

**Test de résolution :**
```cmd
nltest /server:DC300098957-90.local /trusted_domains
```

**Test d'authentification :**
```cmd
net use \\SERVEUR_LOCAL\Partage /user:DC300098957-40.local\utilisateur *
```

**Test Kerberos :**
```cmd
klist
```

## Commandes de Création de l'Approbaation

### Méthode Recommandée (NETDOM) :
```cmd
netdom trust DC300098957-90.local /Domain:DC300098957-40.local /UserD:administrator /PasswordD:* /Add /Realm /TwoWay
```

## Outils Graphiques Alternatifs

### Console de Gération :
```cmd
domain.msc  # Active Directory Domains and Trusts
```

### Autres consoles utiles :
- `dsa.msc` : Utilisateurs et Ordinateurs AD
- `dssite.msc` : Sites et Services AD
- `gpmc.msc` : Gestion des Stratégies de Groupe

## État Final

✅ **L'approbation est opérationnelle** :
- Configuration correctement appliquée
- Communication établie entre les domaines
- Prête pour l'authentification croisée des utilisateurs
- Permet le partage de ressources entre les environnements

L'approbation bidirectionnelle permet maintenant aux utilisateurs des deux domaines d'accéder aux ressources de l'autre domaine en utilisant leur identité native.

# :books: References

- [ ] [NetDom examples](https://homeworks.it/Pdf/NetDom%20Examples.pdf)
