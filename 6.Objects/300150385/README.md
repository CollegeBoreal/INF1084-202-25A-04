# TP – Gestion des utilisateurs, GPO, RDP et partage SMB  
**Étudiant : Belkacem Medjkoune – #300150385**

---

## 1. Résumé du travail
Ce travail pratique consiste à automatiser, à l’aide de PowerShell, plusieurs tâches d’administration Active Directory.  
Les scripts développés permettent de créer un environnement fonctionnel incluant :

- un groupe AD (`Students`)
- des utilisateurs et leur appartenance au groupe
- un dossier partagé avec droits SMB
- une GPO pour mapper automatiquement le lecteur Z:
- l’activation du RDP pour les étudiants
- un script final de test pour valider la configuration

Ce TP reprend des opérations essentielles d’administration Windows Server et permet de comprendre comment déployer une configuration AD complète sans interface graphique.

---

## 2. Script 1 – Création du groupe, des utilisateurs et du partage  
📄 **Fichier : `utilisateurs1.ps1`**

Ce script crée un groupe AD, ajoute les utilisateurs nécessaires, et met en place un dossier partagé accessible via SMB.  
Il vérifie également l’existence des objets avant de les créer.

### 📸 Capture d’écran  



---

## 3. Script 2 – Mise en place de la GPO pour le lecteur Z:  
📄 **Fichier : `utilisateurs2.ps1`**

Ce script génère une GPO permettant de mapper automatiquement un lecteur réseau Z: pour tous les utilisateurs de l’OU Students.  
Un script `.bat` est créé dans `C:\Scripts` et assigné comme script de logon dans la GPO.

### 📸 Capture d’écran  


---

## 4. Script 3 – Activation du RDP pour le groupe Students  
📄 **Fichier : `utilisateurs3.ps1`**

Ce script active les connexions RDP, ouvre les règles du firewall nécessaires, et modifie les droits locaux afin que les membres du groupe Students puissent se connecter en bureau à distance.

### 📸 Capture d’écran  

---

## 5. Script 4 – Tests finaux de configuration  
📄 **Fichier : `utilisateurs4.ps1`**

Le dernier script effectue plusieurs vérifications :  
- présence des utilisateurs  
- appartenance au groupe Students  
- existence de la GPO  
- forçage des stratégies (`gpupdate /force`)

Il annonce ensuite les tests manuels à faire : RDP + présence du disque Z:.

### 📸 Capture d’écran  
 

---

## 6. Conclusion
Ce TP permet de mettre en place un environnement Active Directory complet en utilisant exclusivement PowerShell.  
La création d’objets, les stratégies de groupe, le partage SMB et la configuration de RDP ont été automatisées afin de faciliter la gestion du domaine.  
Les différents scripts démontrent une approche structurée pour administrer efficacement un serveur Windows dans un contexte professionnel.

---

## 7. Fichiers inclus dans ce TP
- `utilisateurs1.ps1`  
- `utilisateurs2.ps1`  
- `utilisateurs3.ps1`  
- `utilisateurs4.ps1`  
- `README.md`
