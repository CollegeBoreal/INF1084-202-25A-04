# TP2 - Simulation Active Directory avec PowerShell

**Étudiant :** Syphax  
**ID :** 300151233  
**Cours :** INF1084-202-25A-04  
**Collège :** Collège Boréal

## 📋 Description

Ce travail pratique simule la gestion d'Active Directory en utilisant PowerShell. Il permet de comprendre la structure AD (utilisateurs, groupes, OU) et de s'entraîner aux cmdlets PowerShell pour la création, la recherche et la manipulation d'objets.

## 📁 Contenu du dossier

- `utilisateurs1.ps1` - Création d'objets utilisateurs simulés
- `utilisateurs2.ps1` - Création de groupes simulés et ajout d'utilisateurs
- `utilisateurs3.ps1` - Requêtes et filtres sur les utilisateurs
- `utilisateurs4.ps1` - Export et import CSV

## 🎯 Objectifs réalisés

### Exercice 1 : Création d'utilisateurs
✅ Ajout de 2 nouveaux utilisateurs à la liste (Lucas Martin et Emma Bernard)

### Exercice 2 : Groupes simulés
✅ Ajout de tous les utilisateurs avec OU="Stagiaires" dans "GroupeFormation"

### Exercice 3 : Filtres
✅ Liste de tous les utilisateurs dont le prénom contient "a" (insensible à la casse)

### Exercice 4 : Import/Export CSV
✅ Import du fichier CSV et création du groupe "ImportGroupe" avec tous les utilisateurs

## 🚀 Exécution des scripts

Pour exécuter un script :
```powershell
.\utilisateurs1.ps1
```

Ou avec dot-sourcing pour conserver les variables :
```powershell
. .\utilisateurs1.ps1
```

## 👥 Utilisateurs créés

| Nom | Prénom | Login | OU |
|-----|--------|-------|-----|
| Dupont | Alice | adupont | Stagiaires |
| Lemoine | Sarah | slemoine | Stagiaires |
| Benali | Karim | kbenali | Stagiaires |
| Martin | Lucas | lmartin | Stagiaires |
| Bernard | Emma | ebernard | Stagiaires |

## 📚 Concepts PowerShell utilisés

- Tables de hachage (`@{}`)
- Tableaux (`@()`)
- Boucles `ForEach-Object`
- Filtres `Where-Object`
- Opérateurs `-like`, `-eq`
- Export/Import CSV
- Gestion de groupes

## 📝 Notes

Ce TP simule les opérations AD sans nécessiter un environnement Active Directory réel, ce qui permet de s'entraîner aux cmdlets PowerShell de manière sécurisée.

---

**Date de réalisation :** Novembre 2025