Tasnim domain
<img width="959" height="539" alt="domain" src="https://github.com/user-attachments/assets/bec77fe3-4302-40ac-a2f8-f2170151d163" />


# TP7 – Mise en place d’un trust entre deux forêts Active Directory  
### Étudiant : Haroune Berkani  
### Domaines :
- Domaine local : **DC300145940-0.local**
- Domaine distant : **DC300150303-00.local**

---

## 🔹 Étape 1 – Récapitulatif des domaines  
Affichage des noms des domaines utilisés par le script.

📸 **Screenshot à insérer :**  
`1.png`  
(Ce screenshot montre la première partie du script : récapitulatif local & distant.)

---

## 🔹 Étape 2 – Vérification de la connectivité réseau  
Test de communication **local → local**, **local → distant**, et résolution DNS.

### ✔️ Test-Connection + Ping  
📸 **Screenshot à insérer :**  
`2.png`  
(Ce screenshot contient Test-Connection vers les 2 DCs.)

### ✔️ Résolution DNS (nslookup)  
📸 **Screenshot à insérer :**  
`3.png`  
(Contient nslookup du domaine distant + ping du domaine distant.)

📸 **Screenshot à insérer :**  
`4.png`  
(Contient nslookup du domaine local + ping du domaine local.)

---

## 🔹 Étape 3 – Informations des domaines (Get-ADDomain)  
Affichage complet des propriétés des deux domaines.

📸 **Screenshot à insérer :**  
`3.png`  
(Affiche le bloc Get-ADDomain du domaine local.)

📸 **Screenshot à insérer :**  
`2.png`  
(Affiche le bloc Get-ADDomain du domaine distant.)

---

## 🔹 Étape 4 – Création du trust de forêt bidirectionnel  
Exécution du script **trust-forets.ps1** qui génère automatiquement le trust.

📌 La commande utilisée :
```powershell
netdom trust $LocalForest /Domain:$RemoteForest /UserD:administrator /PasswordD:* /Add /TwoWay /Realm
```

📸 **Screenshot à insérer :**  
`4.png`  
(Ce screenshot montre la fin du script : création du trust + message vert “Trust forêts terminé.”)

---

## ✔️ Résultat final  
Le trust entre **DC300145940-0.local** et **DC300150303-00.local** est **opérationnel et vérifié**.

---

## 📁 Liste des screenshots utilisés  
| Screenshot | Utilisation |
|-----------|-------------|
| `1.png` | Récapitulatif du script (Étape 1) |
| `2.png` | Test-Connection + Get-ADDomain distant |
| `3.png` | nslookup + Get-ADDomain local |
| `4.png` | nslookup local + création du trust réussie |

---

## 🟢 Remarque importante  
Tu **n'as pas besoin d'autres screenshots** — ceux que tu m’as envoyés couvrent **100% des exigences du TP**.

---

