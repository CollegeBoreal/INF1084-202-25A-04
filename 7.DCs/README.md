# 🎛️ DC Domain Controler

|:hash: | Fonctions                                          |
|-------|:---------------------------------------------------|
| :one: | [:tada: Participation](.scripts/Participation.md)  |

## :books: Travail à soumettre :

- [ ] Un répertoire a été créé avec ton  :id: et celui de ton partenaire (votre identifiant boreal) tu pourras voir la liste [ici :point_right:](.scripts/Participation.md)
  - [ ] `cd ` :id:-:id:
- [ ] dans le répertoire ajouter le fichier `README.md`
  - [ ] `touch README.md`
  - [ ] Créer un répertoire images
    - [ ] `mkdir images`
    - [ ] `touch images/.gitkeep`
- [ ] envoyer vers le serveur `git`
  - [ ] remonter au repertoire précédent
    - [ ] `cd ..`
  - [ ] `git add `:id:-:id:
  - [ ] `git commit -m "mon groupe ..."`
  - [ ] `git push`

## :o: **Projet : Création d’une relation de confiance entre deux forêts Active Directory** :busts_in_silhouette:

### **Objectifs**

* Comprendre la gestion des forêts et domaines dans Active Directory.
* Configurer une relation de confiance (trust) entre deux forêts AD distinctes.
* Automatiser la création et la vérification du trust via des commandes CLI (PowerShell ou équivalent).

---

### **Travail à faire**

1. **Préparer vos environnements**

   * Chaque étudiant utilise sa VM avec une forêt AD distincte.
   * Vérifier que chaque VM peut résoudre le nom DNS de l’autre forêt.

2. **Créer le trust via CLI**

   * Créer un trust **bidirectionnel** entre les deux forêts.
   * Le trust doit être **transitif** (ou non-transitif selon votre choix).
   * Utiliser uniquement des commandes CLI (PowerShell ou autre).
   * Tous les commandes doivent être scriptables pour automatisation.

3. **Vérifier le trust**

   * Confirmer la création du trust via CLI.
   * Tester l’accès entre utilisateurs et ressources des deux forêts.
  
### **a. Définir les informations d’accès à AD2**

```powershell
# Demander les identifiants d'un compte administrateur de la forêt AD2
$credAD2 = Get-Credential -Message "Entrez le compte administrateur de AD2"
```

---

### **b. Vérifier la connectivité au contrôleur de domaine AD2**

```powershell
Test-Connection -ComputerName dc01.ad2.local -Count 2
```

* Assurez-vous que le serveur est joignable et que le DNS est correct.

---

### **c. Interroger le domaine AD2**

```powershell
# Obtenir les informations générales du domaine AD2
Get-ADDomain -Server dc01.ad2.local -Credential $cred

# Lister tous les utilisateurs de AD2
Get-ADUser -Filter * -Server dc01.ad2.local -Credential $cred
```

---

### **d. Naviguer dans le PSDrive AD pour AD2**

```powershell
# Créer un PSDrive pour accéder à AD2
New-PSDrive -Name AD2 -PSProvider ActiveDirectory -Root dc01.ad2.local -Credential $cred

# Se déplacer dans AD2
Set-Location AD2:\DC=AD2,DC=LOCAL

# Lister les unités organisationnelles
Get-ChildItem
```

---

4. **Livrables**

   * **Script CLI** commenté pour créer et vérifier le trust.
   * **Rapport** court présentant :

     * Les étapes suivies
     * Les commandes utilisées
     * Les tests effectués

---

### **Contraintes**

* Aucune manipulation via l’interface graphique.
* Les scripts doivent être réutilisables et documentés.

# :books: References

- [ ] Assigner un DNS

* https://www.name.com/partner/github-students
* https://www.youtube.com/watch?v=YXqqfjjVXmo

