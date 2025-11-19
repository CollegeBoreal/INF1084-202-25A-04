
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



---

## 📌 2. Vérification du domaine Active Directory

Commandes utilisées :

```powershell
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
```


---

## 📌 3. Liste des utilisateurs actifs

```powershell
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
```


---

## 📌 4. Création de l’utilisateur "Alice Dupont"

Commande utilisée :

```powershell
New-ADUser -Name "Alice Dupont" ...
```

---

## 📌 5. Modification de l’utilisateur

```powershell
Set-ADUser -Identity "alice.dupont" -EmailAddress "alice.dupont@exemple.com" -GivenName "Alice-Marie"
```


## 📌 6. Désactivation et activation de l’utilisateur

```powershell
Disable-ADAccount -Identity "alice.dupont"
Enable-ADAccount -Identity "alice.dupont"
```

---

## 📌 7. Déplacement dans l’OU Students

```powershell
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=DC300150268-00,DC=local" `
              -TargetPath "OU=Students,DC=DC300150268-00,DC=local"
```

## 📌 8. Export CSV des utilisateurs

```powershell
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
```

Fichier généré : **TP_AD_Users.csv**

---

## 📁 Dossier images
Toutes les captures d’écran du TP sont placées dans le dossier :

images/
![wait](https://github.com/user-attachments/assets/a8bcac3f-c316-4478-97d6-5c7dc5c63ed2)
![wait](https://github.com/user-attachments/assets/0c0b8f3d-7e90-4958-9813-7ba084c901f0)
![wait](https://github.com/user-attachments/assets/16cdfaad-b0ca-47e6-900c-8691d2168a6b)
![wait](https://github.com/user-attachments/assets/8b249169-ddba-4a82-8d8c-3ad58008995b)
![wait](https://github.com/user-attachments/assets/cfd10073-0712-484d-8f05-51c9e3cb8543)
![wait](https://github.com/user-attachments/assets/12ebed01-dbea-4b23-9ba9-d47e28a63bf2)
![wait](https://github.com/user-attachments/assets/b94d8860-55df-4bbb-82f6-0f8079e93e25)
![wait](https://github.com/user-attachments/assets/a71b6431-865f-4354-bb9f-2eb50809ff76)
![wait](https://github.com/user-attachments/assets/f2b78e0b-d8a7-4a3b-bc0f-50dcd7f409d3)
![wait](https://github.com/user-attachments/assets/0e04cfbd-d00a-4639-82a1-2af20d68a1b7)





---

## ✔️ Travail terminé
Le TP a été exécuté et vérifié avec succès sur la machine virtuelle Windows Server 2022.
