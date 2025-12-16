# ========================================
# bootstrap.ps1 - Amine Kahil (300151292)
# ========================================

#  Infos étudiant
$studentNumber   = 300151292
$studentInstance = "00"

#  Noms de domaine
$domainName  = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

#  Identifiants Administrateur du domaine
$plain  = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred   = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

#  Affichage de contrôle
write-host "Étudiant  : $studentNumber"
write-host "Instance  : $studentInstance"
write-host "Domaine   : $domainName"
write-host "NetBIOS   : $netbiosName"
"  Mot de passe sécurisé chargé."
