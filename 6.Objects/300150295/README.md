#  Travail 6 — Objects (Active Directory & PowerShell)

###  Étudiant : **300150295 — Lounes Allouti**  
###  Cours : **INF1084 — Administration Windows / Automatisation PowerShell**

---

##  **Sommaire**
1. [Création de la structure AD (OU)](#-1-création-de-la-structure-ad-ou)  
2. [Création des utilisateurs](#-2-création-des-utilisateurs-étudiants)  
3. [Groupe RDP + Partage SMB sécurisé](#️-3-création-du-groupe-rdp--partage-smb-sécurisé)  
4. [GPO : lecteur réseau Z](#-4-gpo--mappage-automatique-du-lecteur-réseau-z)  
5. [Restriction RDP](#-5-restriction-de-laccès-rdp-au-groupe-rdpstudents)  
6. [Tests](#-6-tests-réalisés)  
7. [Conclusion](#-7-conclusion)

---

##  **1. Création de la structure AD (OU)**

```powershell
New-ADOrganizationalUnit -Name "College" -ProtectedFromAccidentalDeletion $False
New-ADOrganizationalUnit -Name "Students" -Path "OU=College,DC=dc300150295,DC=local"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=College,DC=dc300150295,DC=local"
```

---

##  **2. Création des utilisateurs (Étudiants)**

```powershell
New-ADUser -Name "student1" -SamAccountName student1 `
-Path "OU=Students,OU=College,DC=dc300150295,DC=local" `
-AccountPassword (Read-Host -AsSecureString) -Enabled $True

New-ADUser -Name "student2" -SamAccountName student2 `
-Path "OU=Students,OU=College,DC=dc300150295,DC=local" `
-AccountPassword (Read-Host -AsSecureString) -Enabled $True
```

---

##  **3. Création du groupe RDP + partage SMB sécurisé**

###  Création du groupe

```powershell
New-ADGroup -Name "RDPStudents" -GroupScope Global `
-Path "OU=Groups,OU=College,DC=dc300150295,DC=local"

Add-ADGroupMember -Identity "RDPStudents" -Members student1, student2
```

###  Partage SMB sécurisé

```powershell
New-Item -Path "C:\Share" -ItemType Directory
New-SmbShare -Name "Share" -Path "C:\Share" -FullAccess "RDPStudents"
icacls C:\Share /grant "RDPStudents:(OI)(CI)M"
```

---

##  **4. GPO — Mappage automatique du lecteur réseau Z:**

> **Console GPMC :**  
`User Configuration → Preferences → Windows Settings → Drive Maps`

- **Lettre :** Z  
- **Chemin :** `\\SRV-DC\Share`  
- **Filtrage :** Groupe **RDPStudents**

---

##  **5. Restriction de l'accès RDP au groupe RDPStudents**

```powershell
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
-Name "fDenyTSConnections" -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

net localgroup "Remote Desktop Users" /add "dc300150295\RDPStudents"
```

---

##  **6. Tests réalisés**
<img width="960" height="540" alt="image" src="https://github.com/user-attachments/assets/fa501d88-cf10-49fb-8b8d-bb176ddbf212" />

vous pouvez tester la connectivité maintenant.
###  Membre du groupe **RDPStudents**
- RDP : **OK**  
- Lecteur réseau Z : **mappé automatiquement**  
- SMB : **accès autorisé**

###  Hors du groupe
- RDP : **refusé**  
- Lecteur Z : **non mappé**  
- SMB : **refusé**

---



Ce travail démontre une bonne compréhension de l’administration Windows Server et de l'automatisation PowerShell.
