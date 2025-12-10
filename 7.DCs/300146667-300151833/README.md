# Projet : Relation de confiance entre deux forêts Active Directory

## Objectif
Créer via CLI une relation de confiance (trust) entre deux forêts AD distinctes, automatiser les tests et valider la communication entre domaines.

## Membres du groupe
- Raouf Bouras (300151833)
- Djaber (300146667)
1. Préparation DNS
- Vérification des IP des deux contrôleurs de domaine.
- Mise en place de la résolution croisée entre les forêts.
- Tests avec `nslookup` entre les deux domaines (`DC300151833.local` et `DC300146667-00.local`) → OK.

#✅ Photo 1 — Commande Get-ADDomain
<img width="1920" height="1080" alt="01" src="https://github.com/user-attachments/assets/ac107ac5-7fbf-4f37-a972-7e601218f253" />
Cette capture montre l’exécution de la commande Get-ADDomain depuis mon contrôleur de domaine DC300151833.local.
Elle confirme que :

Le domaine DC300151833.local est correctement configuré

Les conteneurs AD (Computers, Users, System…) sont présents

Les rôles essentiels (RID Master, PDC, Infrastructure) sont bien assignés

Le domaine fonctionne normalement et n’a aucune erreur interne

👉 Conclusion : Mon domaine AD fonctionne parfaitement.

✅ Photo 2 — Commande Get-ADForest
<img width="1920" height="1080" alt="02" src="https://github.com/user-attachments/assets/2481889b-800d-4b3a-adb9-865f383d6919" />

Cette capture affiche les informations de la forêt Active Directory via Get-ADForest.

On voit que :

La forêt contient bien le domaine DC300151833.local

Tous les rôles FSMO de forêt (Schema Master, Domain Naming Master) sont opérationnels

Les partitions AD et configurations globales sont valides

👉 Conclusion : La forêt AD de mon domaine est fonctionnelle et proprement configurée.

✅ Photo 3 — Commande Get-ADDomainController
<img width="1920" height="1080" alt="03" src="https://github.com/user-attachments/assets/ed1c3d6f-0591-4ddc-b852-1f24955053d7" />

Cette capture montre les détails du contrôleur de domaine via Get-ADDomainController.

Les points importants :

Le serveur AD répond correctement

Il possède les rôles FSMO (SchemaMaster, DomainNamingMaster, RIDMaster, PDCEmulator, InfrastructureMaster)

L’adresse IP locale du DC (10.7.236.244) est correcte

Le service AD DS fonctionne sans erreur

👉 Conclusion : Mon contrôleur de domaine est opérationnel et prêt pour établir un trust.

✅ Photo 4 — Test-Connection vers dc01.ad2.local (Échec)
<img width="1920" height="1080" alt="04" src="https://github.com/user-attachments/assets/153bbc22-52d9-4550-b2cb-dcd2b067709d" />

Ici, le test de connexion Test-Connection dc01.ad2.local échoue.

❌ Erreur : “No such host is known”

Cela signifie :

Le nom de domaine dc01.ad2.local n’est pas résolu en adresse IP

Le DNS de Djaber ne répond pas

Impossible de communiquer avec son DC

👉 Conclusion : On ne peut pas établir de trust tant que son DNS ne fonctionne pas.

✅ Photo 5 — nslookup dc01.ad2.local (Échec DNS)
<img width="933" height="194" alt="05" src="https://github.com/user-attachments/assets/b56d2736-2887-4586-9ab1-f39e0be31e3f" />

La commande nslookup dc01.ad2.local renvoie :

❌ “Non-existent domain”

Cela confirme que :

Le domaine ad2.local n’existe pas dans le DNS

Le contrôleur de domaine de Djaber n’est pas accessible

Le forwarding DNS entre nos deux machines ne marche pas

👉 Conclusion : La résolution DNS de Djaber est complètement absente → Trust impossible.

✅ Photo 6 — Get-ADTrust (Trust détecté côté Raouf)
<img width="933" height="194" alt="06" src="https://github.com/user-attachments/assets/205b5d03-5d65-4b44-bbeb-1e79c7064c96" />

Cette capture montre un objet de relation d’approbation via Get-ADTrust.

On voit :

Un trust enregistré avec DC300146667-00.local

Direction : Bidirectional (2-way)

TrustType : MIT, ce qui indique une trust créée mais non validée

👉 Conclusion : Le trust existe dans mon domaine, mais il n’est pas valide car l’autre domaine ne répond pas.

✅ Photo 7 — Get-ADTrust -Identity ad2.local (Erreur)
<img width="838" height="568" alt="07" src="https://github.com/user-attachments/assets/be880e42-da4e-4101-9836-1f582058b600" />

Cette commande renvoie :

❌ “Cannot find an object with identity 'ad2.local’”

Cela confirme :

Le domaine ad2.local (Djaber) n’est pas visible depuis mon Active Directory

Aucune relation d’approbation fonctionnelle n’existe réellement

Le trust ne peut pas être vérifié ni établi

👉 Conclusion : Côté Raouf, le trust ne peut pas être finalisé car le domaine de Djaber est introuvable.

📌 Résumé global (à mettre à la fin du README)

✔️ Mon domaine (DC300151833.local) fonctionne parfaitement
✔️ Mon contrôleur de domaine répond au ping, DNS OK, AD OK

❌ Le domaine de Djaber (ad2.local ou DC300146667-00.local) ne répond pas
❌ Ping impossible
❌ DNS ne résout pas son domaine
❌ Impossible de valider le trust
<img width="1440" height="187" alt="08" src="https://github.com/user-attachments/assets/7be62768-6272-470c-bbf8-94c1feab48ab" />


➡️ Conclusion finale :
Le problème ne vient pas de ma configuration.
Le trust échoue uniquement parce que le domaine de Djaber n’est pas accessible ni résolvable via DNS
