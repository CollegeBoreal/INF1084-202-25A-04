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


```powershell

###############################################
# SCRIPT GPO + RDP (Complet, compatibilite totale)
###############################################

# Variables
$GPOName = "MapSharedFolder"
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"
$OU = "OU=Students,DC=DC300153747-00,DC=local"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

###############################################
# 1. CREATION OU REUTILISATION DE LA GPO
###############################################

# Verifier si la GPO existe deja
$existingGPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue

if (-not $existingGPO) {
    New-GPO -Name $GPOName
    Write-Host "GPO created: $GPOName"
} else {
    Write-Host "GPO already exists. Using existing one."
}

###############################################
# 2. LIER LA GPO A L OU STUDENTS
###############################################

try {
    New-GPLink -Name $GPOName -Target $OU -ErrorAction Stop
    Write-Host "GPO linked to OU Students."
}
catch {
    Write-Host "GPO already linked to this OU."
}

###############################################
# 3. CREER LE SCRIPT LOGON
###############################################

# Creer le dossier de script si besoin
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

# Contenu du script BAT
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Ajouter le script logon dans la GPO
Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath

Write-Host "Logon script configured."

###############################################
# 4. ACTIVER RDP
###############################################

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "RDP enabled."

###############################################
# 5. AJOUT DES DROITS RDP AU GROUPE STUDENTS
###############################################

secedit /export /cfg C:\secpol.cfg

Write-Host ""
Write-Host "IMPORTANT:"
Write-Host "Edit C:\secpol.cfg and add Students in the line:"
Write-Host "    SeRemoteInteractiveLogonRight = ..."
Write-Host "Then press Y when asked."
Write-Host ""

secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite

###############################################
# FIN DU SCRIPT
###############################################

Write-Host ""
Write-Host "Script completed successfully."
```
<details>
    PS C:\Users\Public\developper\INF1084-202-25A-04\6.Objects\300153747> .\utilisateurs2.ps1
GPO already exists. Using existing one.


GpoId       : cd2ffa6d-7efd-4d3b-bb6a-5b05d8a54ded
DisplayName : MapSharedFolder
Enabled     : True
Enforced    : False
Target      : OU=Students,DC=DC300153747-00,DC=local
Order       : 1

GPO linked to OU Students.

Id               : cd2ffa6d-7efd-4d3b-bb6a-5b05d8a54ded
DisplayName      : MapSharedFolder
Path             : cn={CD2FFA6D-7EFD-4D3B-BB6A-5B05D8A54DED},cn=policies,cn=system,DC=DC300153747-00,DC=local
Owner            : DC300153747-00\Domain Admins
DomainName       : DC300153747-00.local
CreationTime     : 11/18/2025 5:25:47 PM
ModificationTime : 11/18/2025 5:36:54 PM
User             : Microsoft.GroupPolicy.UserConfiguration
Computer         : Microsoft.GroupPolicy.ComputerConfiguration
GpoStatus        : AllSettingsEnabled
WmiFilter        :
Description      :

Logon script configured.
RDP enabled.

The task has completed successfully.
See log %windir%\security\logs\scesrv.log for detail info.

IMPORTANT:
Edit C:\secpol.cfg and add Students in the line:
    SeRemoteInteractiveLogonRight = ...
Then press Y when asked.

Configuring the current system with this template in the /overwrite mode will result in losing the existing security records in the database specified.Do you want to continue this operation ? [y/n] y
```
</details>
