# Importer le module Active Directory
Import-Module ActiveDirectory

# Définir l’unité d’organisation cible
$OUPath = "OU=Students,DC=DC300152410-00,DC=local"

# Définir le mot de passe par défaut
$Password = ConvertTo-SecureString "Pwd@2025" -AsPlainText -Force

# Importer le fichier CSV et créer les utilisateurs
Import-Csv ".\etudiants.csv" | ForEach-Object {
    New-ADUser `
        -GivenName $_.GivenName `
        -Surname $_.Surname `
        -Name "$($_.GivenName) $($_.Surname)" `
        -SamAccountName $_.SamAccountName `
        -UserPrincipalName "$($_.SamAccountName)@DC300152410-00.local" `
        -Path $OUPath `
        -AccountPassword $Password `
        -Enabled $true `
        -ChangePasswordAtLogon $false `
        -Description $_.Description
}

# Vérifier les utilisateurs créés
Get-ADUser -Filter * -SearchBase $OUPath | Select-Object Name,SamAccountName,Description
