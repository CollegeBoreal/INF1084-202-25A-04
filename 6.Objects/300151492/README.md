# Laboratoire: Partage de ressources et RDP
**Étudiant:** 300151492

## Description
Ce laboratoire configure automatiquement:
- Un dossier partagé sur le réseau
- Des utilisateurs Active Directory
- Une GPO pour mapper un lecteur réseau
- L'accès RDP pour le groupe Students

## Scripts créés
1. `bootstrap.ps1` - Configuration de base
2. `utilisateurs1.ps1` - Création des utilisateurs et partage
3. `utilisateurs2.ps1` - Configuration de la GPO
4. `rdp-config.ps1` - Activation de RDP

## Résultats
- ✅ Groupe "Students" créé
- ✅ Utilisateurs Etudiant1 et Etudiant2 créés
- ✅ Partage réseau: \\DC300151492-00\SharedResources
- ✅ GPO "MapSharedFolder" créée
- ✅ RDP activé pour le groupe Students