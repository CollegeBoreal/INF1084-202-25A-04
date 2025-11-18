# 🎛️ DC Domain Controler

## :books: Travail à soumettre :

- [ ] Créer un répertoire avec ton  :id: (votre identifiant boreal)
  - [ ] `mkdir ` :id:
  - [ ] `cd ` :id:
- [ ] dans le répertoire ajouter le fichier `README.md`
  - [ ] `touch README.md`
  - [ ] Créer un répertoire images
    - [ ] `mkdir images`
    - [ ] `touch images/.gitkeep`
- [ ] envoyer vers le serveur `git`
  - [ ] remonter au repertoire précédent
    - [ ] `cd ..`
  - [ ] `git add `:id:
  - [ ] `git commit -m "mon fichier ..."`
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


