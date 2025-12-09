## 🧭 TP Active Directory – 6.Objects

## 👤 Informations Étudiant
- **Nom :** Bouraoui Akrem  
- **Numéro étudiant :** 300150527  
- **Instance :** 00  
- **Nom de domaine :** DC300150527-00.local  
- **Nom NetBIOS :** DC300150527-00  

----------------------------------------------------

## 🌟 Introduction

Dans le cadre du laboratoire 6.Objects du cours INF1084 – Services Réseau Windows, j’ai réalisé une série complète d’opérations liées à la gestion d’un environnement Active Directory.

L’objectif principal était de créer, configurer et tester plusieurs objets dans un domaine Windows Server 2022, incluant :

- la création de groupes et d’utilisateurs Active Directory ;
- la mise en place d’un dossier partagé sécurisé ;
- la configuration d'une GPO pour mapper automatiquement un lecteur réseau ;
- l’activation et la sécurisation de l’accès RDP ;
- la vérification fonctionnelle via une connexion distante.

Ce travail m’a permis de comprendre le fonctionnement global d’un domaine Windows, de manipuler des objets AD à l’aide de PowerShell, et de tester une configuration complète du côté client.

-----------------------------


## 📌 1. Création du dossier du laboratoire

Dans le répertoire 6.Objects, création du dossier principal :

- Création d’un fichier README.md vide du dossier images :

<img width="857" height="502" alt="1" src="https://github.com/user-attachments/assets/e04ca023-627f-4260-8873-84c0ffc0c48a" />

- Création du fichier .gitkeep (permet d’ajouter un dossier vide dans Git) :

<img width="858" height="503" alt="2" src="https://github.com/user-attachments/assets/ba607792-cae6-49e4-b02b-de81d375fd1d" />

-------------------------------------------

## 📌 2. Synchronisation avec GitHub

<img width="870" height="500" alt="3" src="https://github.com/user-attachments/assets/3511b4bc-d2df-4e46-bdcc-22a18b503819" />

-----------------------------------------

## 📌 3. Import des modules AD et GPO

```powershell
Import-Module ActiveDirectory**
Import-Module GroupPolicy**
```

- Chargement des variables via bootstrap :

```powershell
. "C:\Users\Administrator\Developer\INF1084-202-25A-04\4.OUs\300150527\bootstrap.ps1"
```

<img width="971" height="508" alt="4" src="https://github.com/user-attachments/assets/2a1fc9eb-2f6b-4d0f-a2a0-a42d33a93eb2" />

---------------------------------------------------------

## 📌 4. Création des objets Active Directory

## 📁 Création du dossier partagé

```powershell
$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force
```

## 👥 Création du groupe AD

```powershell
$GroupName = "Students"
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
```

## 👨‍🎓 Création des utilisateurs

```powershell
$Users = @("Etudiant1","Etudiant2")
foreach ($user in $Users) {
    New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity $GroupName -Members $user
}
```

## 🔗 Partage SMB

```powershell
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
```

## 🔍 Vérifications

```powershell
Get-ADUser -Identity Etudiant1
Get-ADUser -Identity Etudiant2
```

<img width="890" height="499" alt="5-1" src="https://github.com/user-attachments/assets/dcbb16b0-5c66-465a-904d-48dc7c05cbe5" />

<img width="832" height="500" alt="5-2-1" src="https://github.com/user-attachments/assets/f0b6374d-bc06-487d-9449-d250d4e5b34f" />

-----

```powershell
Get-ADGroupMember -Identity "Students"*
```

<img width="1105" height="501" alt="5-2-2" src="https://github.com/user-attachments/assets/49f7605a-bad4-4e7e-a85d-c001880f724d" />

------

```powershell
Get-SmbShare -Name "SharedResources"
Get-SmbShareAccess -Name "SharedResources"
```

<img width="864" height="494" alt="5-3" src="https://github.com/user-attachments/assets/0b833cc0-54bc-49b8-963c-ddc15b6fe24f" />


-----------------------------------------------------

## 📌 5. Création de la GPO : Map du lecteur réseau (Z:)

**Création de la GPO**

```powershell
$GPOName = "MapSharedFolder"
New-GPO -Name $GPOName
```
<img width="921" height="472" alt="6-1" src="https://github.com/user-attachments/assets/f0789ada-b3f9-4040-92a7-4f4e718abedf" />

-----

**Lier la GPO à l’OU Students**

```powershell
$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU
```

<img width="906" height="473" alt="6-2" src="https://github.com/user-attachments/assets/01851658-f955-4527-9306-f629433394be" />

----

**Création du script de connexion**

```powershell
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder }
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent
```

<img width="932" height="480" alt="6-3" src="https://github.com/user-attachments/assets/34a74b6a-c9f4-4ce7-805a-6da4f9953941" />

----

**Associer le script à la GPO**

```powershell
Set-GPRegistryValue -Name $GPOName `
  -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
  -ValueName "LogonScript" `
  -Type String `
  -Value $ScriptPath
```

<img width="906" height="447" alt="6-4" src="https://github.com/user-attachments/assets/19452782-7eb0-4504-bc57-335d85072490" />


-------------------------------------------

## 📌 6. Activation RDP pour le groupe Students

**Activer RDP, le pare-feu et donner le droit logon via RDP au groupe Students**

```powershell
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

secedit /export /cfg C:\secpol.cfg
```

<img width="919" height="473" alt="6-5" src="https://github.com/user-attachments/assets/9359bfea-91c6-420b-a78a-52494dcc47d8" />

-----

**Modifier le fichier pour inclure Students dans "SeRemoteInteractiveLogonRight", puis réimporter**

```powershell
secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite
```

<img width="922" height="466" alt="6-6" src="https://github.com/user-attachments/assets/8a4e797c-a13f-411e-94dc-930c70241ca4" />

<img width="918" height="472" alt="6-7" src="https://github.com/user-attachments/assets/799e7c17-0650-4f0e-9dcf-7f7a5967aa4c" />

--------------------------------------------
##  TEST 01 :
<img width="1366" height="725" alt="test1" src="https://github.com/user-attachments/assets/c5af2f4a-c671-41c6-89a6-df75c1959921" />

----------------------------------------------
## Test 02 :
<img width="1366" height="727" alt="test2" src="https://github.com/user-attachments/assets/8fc43030-0104-4b4c-bd20-8579a29e97e3" />

-------------------------------------------

## 📘 Ce que j’ai appris dans ce laboratoire

Au cours de ce devoir, j’ai appris à :

✔️ 1. Manipuler Active Directory via PowerShell

- Créer des utilisateurs, groupes, OU
- Gérer les permissions et déplacer des objets
- Vérifier les objets AD existants

✔️ 2. Configurer un dossier partagé sécurisé

- Créer un partage SMB
- Accorder les droits à un groupe AD spécifique
- Vérifier l’accès et les permissions

✔️ 3. Configurer une GPO (Group Policy Object)

- Créer une GPO
- La lier à une OU
- Automatiser le mappage d’un lecteur réseau
- Gérer les scripts de logon

✔️ 4. Activer et sécuriser l’accès RDP

- Modifier les stratégies pour autoriser la connexion
- Donner les droits nécessaires au groupe Students
- Vérifier qu’un utilisateur non autorisé est bloqué

------------------------------------

## 🏁 Conclusion

Ce laboratoire m’a offert une expérience pratique très complète sur la gestion d’un environnement Active Directory.

J’ai pu comprendre, étape par étape, comment un administrateur système crée et contrôle des objets AD, sécurise l’accès aux ressources, et automatise des configurations via GPO et scripts.

Grâce à ce travail, je maîtrise désormais :

- la création d’utilisateurs et de groupes.
- la gestion des permissions sur un partage réseau.
- la mise en place d’une GPO fonctionnelle.
- la configuration et la sécurisation du Remote Desktop.
- l’utilisation systématique de PowerShell pour administrer un domaine Windows.

C’est un laboratoire essentiel qui simule le travail réel d’un administrateur réseau dans une entreprise moderne.


