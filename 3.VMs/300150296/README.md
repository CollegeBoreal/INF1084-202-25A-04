\# TP Active Directory - 300150296



\## 🎯 Objectif

Installer et configurer un contrôleur de domaine Active Directory sur Windows Server 2022



\## 📊 Configuration



\### Informations du domaine

\- \*\*Nom du serveur\*\* : DC300150296-0

\- \*\*Nom du domaine\*\* : DC300150296-0.local

\- \*\*NetBIOS\*\* : DC300150296-0

\- \*\*Mot de passe DSRM\*\* : Password123!



\## 📸 Screenshots



\### 1. Installation du rôle AD DS

!\[Installation AD DS](screenshots/1-install-adds.png)



\### 2. Configuration du domaine

!\[Configuration domaine](screenshots/2-domain-config.png)



\### 3. Vérification Get-ADDomain

!\[Get-ADDomain](screenshots/3-get-addomain.png)



\### 4. Vérification Get-ADForest

!\[Get-ADForest](screenshots/4-get-adforest.png)



\## ✅ Étapes réalisées



1\. ✅ Renommage du serveur

2\. ✅ Installation du rôle AD-Domain-Services

3\. ✅ Création de la forêt et du domaine

4\. ✅ Configuration DNS

5\. ✅ Vérification de l'installation



\## 📝 Commandes utilisées

```powershell

\# 1. Renommer le serveur

Rename-Computer -NewName "DC300150296-0" -Restart



\# 2. Installer AD DS

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools



\# 3. Créer le domaine

Install-ADDSForest `

&nbsp;   -DomainName "DC300150296-0.local" `

&nbsp;   -DomainNetbiosName "DC300150296-0" `

&nbsp;   -InstallDns:$true `

&nbsp;   -SafeModeAdministratorPassword (ConvertTo-SecureString "Password123!" -AsPlainText -Force) `

&nbsp;   -Force



\# 4. Vérifications

Get-ADDomain

Get-ADForest

```



\## 🎓 Compétences acquises



\- Configuration d'un contrôleur de domaine

\- Gestion des services Active Directory

\- Compréhension de la structure AD (forêt, domaine, DNS)

\- Utilisation de PowerShell pour l'administration AD

