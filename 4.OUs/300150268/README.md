
# TP – Gestion des utilisateurs Active Directory avec PowerShell

## Étudiant
- **Nom :** Mohand Said Kemiche
- **Numéro étudiant :** 300150268
- **Domaine Active Directory :** DC300150268-00.local

---

## 📌 1. Chargement du script bootstrap.ps1
Le script initialise les variables :
- `$studentNumber = 300150268`
- `$studentInstance = "00"`
- `$domainName = DC300150268-00.local`
- `$netbiosName = DC300150268-00`

**Capture :** `images/bootstrap.png`

---

## 📌 2. Vérification du domaine Active Directory

Commandes utilisées :

```powershell
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
```

**Capture :** `images/domain-check.png`  
**Capture :** `images/dc-check.png`

---

## 📌 3. Liste des utilisateurs actifs

```powershell
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
```

**Capture :** `images/user-list.png`

---

## 📌 4. Création de l’utilisateur "Alice Dupont"

Commande utilisée :

```powershell
New-ADUser -Name "Alice Dupont" ...
```

**Capture :** `images/create-alice.png`

---

## 📌 5. Modification de l’utilisateur

```powershell
Set-ADUser -Identity "alice.dupont" -EmailAddress "alice.dupont@exemple.com" -GivenName "Alice-Marie"
```

**Capture :** `images/edit-alice.png`

---

## 📌 6. Désactivation et activation de l’utilisateur

```powershell
Disable-ADAccount -Identity "alice.dupont"
Enable-ADAccount -Identity "alice.dupont"
```

**Captures :**  
- `images/disable-alice.png`  
- `images/enable-alice.png`

---

## 📌 7. Déplacement dans l’OU Students

```powershell
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=DC300150268-00,DC=local" `
              -TargetPath "OU=Students,DC=DC300150268-00,DC=local"
```

**Capture :** `images/move-students.png`

---

## 📌 8. Export CSV des utilisateurs

```powershell
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
```

Fichier généré : **TP_AD_Users.csv**

---

## 📁 Dossier images
Toutes les captures d’écran du TP sont placées dans le dossier :

```
images/
```

---

## ✔️ Travail terminé
Le TP a été exécuté et vérifié avec succès sur la machine virtuelle Windows Server 2022.
