# ============================================
# TP Active Directory - Gestion des utilisateurs
# Étudiant : 300150295
# Domaine : DC300150295-0.local
# ============================================

# 1️⃣ Variables
$studentNumber = 300150295
$studentInstance = 0
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# 2️⃣ Import du module Active Directory
Import-Module ActiveDirectory

# 3️⃣ Vérification du domaine
Write-Host "🔍 Vérification du domaine : $domainName"
Get-ADDomain -Server $domainName

# 4️⃣ Connexion administrateur
$cred = Get-Credential -Message "Entrez les identifiants de l’administrateur du domaine $domainName"

# 5️⃣ Création d’un utilisateur test
New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Credential $cred

# 6️⃣ Création de l’OU Students si absente
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    Write-Host "🧩 Création de l’OU Students..."
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
}

# 7️⃣ Déplacement de l’utilisateur vers l’OU
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Credential $cred

# 8️⃣ Afficher la position de l’utilisateur
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName

Write-Host "✅ TP terminé avec succès pour $domainName"
