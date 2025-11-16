# ---------------------------------------
# TP Active Directory - bootstrap.ps1
# Étudiant : 300150268
# Nom : Mohand Said KEMICHE
# Domaine : DC300150268-00.local
# ---------------------------------------

# Informations réelles
$domainName = "DC300150268-00.local"
$netbiosName = "DC300150268-00"

# Nom réel du contrôleur de domaine
$dcServer = "DC30015026800.DC300150268-00.local"

# Informations de sécurité
$plain = 'Infra@2024'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

# Import Module
Import-Module ActiveDirectory

Write-Host "Bootstrap chargé pour le domaine $domainName" -ForegroundColor Cyan
