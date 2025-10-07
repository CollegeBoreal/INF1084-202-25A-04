🧠 TP Active Directory – INF1084
Étudiant : Massinissa Mameri
Matricule : 300151841
Domaine : DC300151841-00.local
⚙️ Objectif du TP

Mettre en place un contrôleur de domaine Active Directory sous Windows Server 2022 à l’aide de PowerShell, comprenant :

Le renommage du serveur

L’installation du rôle AD DS

La création d’un domaine local avec DNS intégré

La vérification de la configuration du domaine et de la forêt

🪜 Étapes réalisées
🧩 1. Renommage du serveur

Commande PowerShell :

Rename-Computer -NewName "DC300151841" -Restart

📸 Capture : serveur renommé et redémarré avec succès

🧩 2. Installation du rôle AD DS

Commande PowerShell :

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools


✅ Résultat : Success : True
📸 Capture : installation du rôle AD DS terminée avec succès

🧩 3. Création du domaine et installation DNS

Commande PowerShell :

Install-ADDSForest `
  -DomainName "DC300151841-00.local" `
  -DomainNetbiosName "DC300151841-00" `
  -InstallDns:$true `
  -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
  -Force


✅ Résultat : le serveur est devenu contrôleur de domaine
📸 Captures : étapes de la création du domaine et redémarrage automatique

🧩 4. Vérification du domaine et de la forêt

Commandes PowerShell :

Get-ADDomain
Get-ADForest


✅ Résultat :

Domaine actif → DC300151841-00.local

Forêt créée → DC300151841-00.local

Serveur → DC300151841
📸 Captures : résultats des commandes Get-ADDomain et Get-ADForest

🌐 Informations système

Depuis Server Manager → Local Server :

Computer Name : DC300151841

Domain : DC300151841-00.local

Firewall : Domain: On

Remote Desktop : Enabled
📸 Capture : propriétés du serveur local après promotion en DC

🧩 5. (Optionnel) Tests supplémentaires

Création d’une OU et d’un utilisateur pour vérification :

New-ADOrganizationalUnit -Name "Etudiants2025" -ProtectedFromAccidentalDeletion $true
$pwd = ConvertTo-SecureString "Password123!" -AsPlainText -Force
New-ADUser -Name "test1" -SamAccountName "test1" -AccountPassword $pwd -Enabled $true


📸 Capture possible : OU et utilisateur créés dans “Active Directory Users and Computers”

✅ Résumé du TP
Étape	Description	Statut
1	Renommage du serveur	✅
2	Installation AD DS	✅
3	Création du domaine + DNS	✅
4	Vérification du domaine	✅
5	(Optionnel) Création OU + utilisateur	✅
💬 Conclusion

Ce TP m’a permis de :

Découvrir la configuration complète d’un contrôleur de domaine Active Directory sous Windows Server 2022.

Utiliser uniquement PowerShell pour automatiser l’installation.

Vérifier la bonne intégration du service DNS et du domaine local.

🎯 Tout fonctionne correctement sur le domaine DC300151841-00.local.

