###############################
# utilisateurs2.ps1
# Création / modification utilisateur
###############################

Import-Module ActiveDirectory

# Bootstrap
$studentNumber = 300098957
$studentInstance = 40
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

###############
# 3️⃣ Création
###############

New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Credential $cred

###############
# 4️⃣ Modification
###############

Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Credential $cred

###############
# 5️⃣ Désactivation
###############

Disable-ADAccount -Identity "alice.dupont" -Credential $cred

###############
# 6️⃣ Réactivation
###############

Enable-ADAccount -Identity "alice.dupont" -Credential $cred

###############
# 7️⃣ Suppression
###############

# Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred
