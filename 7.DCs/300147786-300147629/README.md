# TP : Trust entre deux forêts AD

## 🖥️ 1. Préparation des environnements

* Chaque étudiant utilise sa **VM avec une forêt AD distincte**.
* Vérification de la **résolution DNS entre les deux forêts** :

```powershell
# Vérifier le DNS du domaine local
nslookup DC300147786-00.local

# Vérifier le DNS du domaine distant
nslookup DC300147629-00.local
```
https://github.com/CollegeBoreal/INF1084-202-25A-04/blob/main/7.DCs/300147786-300147629/images/image1.png
---

## 🔐 2. Création du trust via CLI

Création d’un **trust bidirectionnel transitif** entre les deux forêts :

```powershell
netdom trust DC300147629-00.local /Domain:DC300147786-00.local /UserO:Administrator /PasswordO:* /UserD:Administrator /PasswordD:* /Forest /Twoway
```

### ✅ Vérification que le trust a été créé

```powershell
nltest /domain_trusts
```

---

## 🧪 3. Vérification du trust et tests d’accès

### 🌐 a. Vérification de la résolution DNS depuis la VM locale

```powershell
Resolve-DnsName DC300147629-00.local
```

### 📡 b. Vérification de la connectivité au contrôleur de domaine AD2

```powershell
Test-Connection -ComputerName dc01.ad2.local -Count 2
```

### 📁 c. Accès aux ressources partagées du domaine distant

```powershell
# Monter le partage distant avec un utilisateur du domaine local
net use \\10.7.236.225\SharedResources /user:DC300147786-00.local\Administrator *
```

### 📂 d. Vérification du contenu du partage distant

```powershell
# Lister le contenu du partage distant
Get-ChildItem \\10.7.236.225\SharedResources
```

### 👥 e. Vérification des utilisateurs du serveur local depuis le domaine distant

```powershell
# Liste des utilisateurs du domaine local
Get-ADUser -Filter * -Server DC300147786-00.local
```

---

## 🔄 4. Informations sur la relation de confiance

* Le domaine **DC300147786-00.local** possède une **relation de confiance de type Realm non transitive** avec le domaine **DC300147629-00.local**, en entrée comme en sortie.
* L’utilisateur **Administrator** est actuellement connecté en session RDP sur le serveur local, visualisable avec :

```powershell
quser
```

---

## 💡 Notes importantes

* Toutes les commandes et scripts doivent être exécutés avec **des droits administrateur**.
* Les adresses IP et noms de serveurs doivent correspondre à votre **topologie réseau VM**.
* Pour chaque étape, **vérifier la réussite** avant de passer à la suivante.


