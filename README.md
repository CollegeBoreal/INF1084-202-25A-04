#  Laboratoire Active Directory Domain Services (AD DS)

**Auteur :** 300150385  
**Système :** Windows Server 2022  
**Objectif :** Installer et configurer un contrôleur de domaine Active Directory avec DNS intégré.

---

##  Installation du contrôleur de domaine

```powershell
Install-ADDSForest `
    -DomainName "DC300150385-00.local" `
    -DomainNetbiosName "DC300150385-00" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "Infra@2024" -AsPlainText -Force) `
    -Force
