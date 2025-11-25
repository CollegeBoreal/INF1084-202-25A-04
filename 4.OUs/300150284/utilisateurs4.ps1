###############################
# utilisateurs4.ps1
# Gestion des OU + Move
###############################

Import-Module ActiveDirectory

$studentNumber = 300098957
$studentInstance = 40
$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

###############
# 🔟 Création de l’OU Students si manquante
###############

if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local"
}

###############
# Déplacement d’Alice Dupont
###############

Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
              -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
              -Credential $cred

###############
# Vérification
###############

Get-ADUser -Identity "alice.dupont" |
Select-Object Name, DistinguishedName
