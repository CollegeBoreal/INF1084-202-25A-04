# ========================================
# TP Active Directory - Partie 3
# Gestion des comptes
# ========================================

# Configuration des variables
$studentNumber = 300151492
$studentInstance = "0"

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# ÉTAPE 5 : Désactiver un utilisateur
Disable-ADAccount -Identity "alice.dupont" -Server $domainName

# ÉTAPE 6 : Réactiver un utilisateur
Enable-ADAccount -Identity "alice.dupont" -Server $domainName

# ÉTAPE 8 : Rechercher des utilisateurs avec un filtre
Get-ADUser -Filter "Name -like 'A*'" -Server $domainName -Properties Name, SamAccountName |
Select-Object Name, SamAccountName

# ÉTAPE 9 : Exporter les utilisateurs dans un CSV
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
