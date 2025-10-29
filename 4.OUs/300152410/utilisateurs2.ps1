# ===========================
# utilisateurs2.ps1
# Création & Modification
# ===========================

$studentNumber   = 300152410
$studentInstance = 0
$netbiosName     = "DC$studentNumber-$studentInstance"
$domainFqdn      = "$netbiosName.local"
$domainDN        = "DC=$netbiosName,DC=local"

Import-Module ActiveDirectory

# Compte de test : Alice Dupont (SamAccount: adupont)
$sam   = "adupont"
$upn   = "$sam@$domainFqdn"
$pwd   = ConvertTo-SecureString "Pwd@2025" -AsPlainText -Force
$path  = "CN=Users,$domainDN"

# 1) Créer si n'existe pas
if (-not (Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue)) {
    New-ADUser -Name "Alice Dupont" `
               -GivenName "Alice" `
               -Surname "Dupont" `
               -SamAccountName $sam `
               -UserPrincipalName $upn `
               -AccountPassword $pwd `
               -Enabled $true `
               -ChangePasswordAtLogon $false `
               -Description "Étudiante du domaine $domainFqdn" `
               -Path $path
}

# 2) Petites modifications d'attributs
Set-ADUser -Identity $sam -EmailAddress "alice.dupont@$domainFqdn" -Description "Étudiante du domaine $domain
