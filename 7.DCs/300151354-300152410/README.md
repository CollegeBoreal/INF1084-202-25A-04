# Projet Fin Session – Relation de Confiance Active Directory

## Membres du groupe
- 300152410 — imad boudeuf 
- 300151354 — Masinissa

## 🎯 Objectif
Créer une relation de confiance (FOREST TRUST) entre deux forêts Active Directory configurées sur deux VM distinctes.

## 📌 Étapes réalisées
1. Installation du rôle AD DS sur les deux serveurs.
2. Configuration des domaines :
   - DC300152410-00.local
   - DC300151354-00.local
3. Vérification DNS avec `check-domains.ps1`
4. Test de connectivité (ping des DC)
5. Création du trust via PowerShell (`trust-setup.ps1`)
6. Vérification du trust avec :
   ```powershell
   Get-ADTrust -Filter *
