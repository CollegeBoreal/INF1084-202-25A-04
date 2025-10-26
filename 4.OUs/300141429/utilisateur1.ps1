# 1️⃣ Importer le module ActiveDirectory
Import-Module ActiveDirectory

# 2️⃣ Vérifier le domaine et les contrôleurs de domaine
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName
