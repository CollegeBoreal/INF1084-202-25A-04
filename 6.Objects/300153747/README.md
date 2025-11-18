#300153747
```powershell
Import-Module ActiveDirectory
# Chemin du dossier
$SharedFolder = "C:\SharedResources"

# Créer le dossier
New-Item -Path $SharedFolder -ItemType Directory -Force

# Créer un partage SMB pour le groupe Students
$GroupName = "Students"

# Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# Créer des utilisateurs AD et les ajouter au groupe
$Users = @("Etudiant1","Etudiant2")
foreach ($user in $Users) {
    New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity $GroupName -Members $user
}

# Partager le dossier avec le groupe
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

```
  <details>
```powershell
PS C:\Users\Public\developper\INF1084-202-25A-04\6.Objects\300153747> .\utilisateurs1.ps1


    Directory: C:\


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        11/18/2025   5:21 PM                SharedResources

AvailabilityType      : NonClustered
CachingMode           : Manual
CATimeout             : 0
CompressData          : False
ConcurrentUserLimit   : 0
ContinuouslyAvailable : False
CurrentUsers          : 0
Description           :
EncryptData           : False
FolderEnumerationMode : Unrestricted
IdentityRemoting      : False
Infrastructure        : False
LeasingMode           : Full
Name                  : SharedResources
Path                  : C:\SharedResources
Scoped                : False                                                                                           ScopeName             : *                                                                                               SecurityDescriptor    : O:SYG:SYD:(A;;FA;;;S-1-5-21-447135690-91861430-3213525697-1106)                                 ShadowCopy            : False                                                                                           ShareState            : Online                                                                                          ShareType             : FileSystemDirectory
SmbInstance           : Default
Special               : False
Temporary             : False
Volume                : \\?\Volume{d9f7716d-765c-4de2-bbd2-1c33f3e87e19}\
PSComputerName        :
PresetPathAcl         : System.Security.AccessControl.DirectorySecurity
```
</details>
