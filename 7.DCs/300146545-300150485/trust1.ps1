# Script : trust1.ps1
# Domaine local : DC300150485.local
# Domaine distant : DC300146545.local
# Auteur : 300150485

Write-Host "Création du trust depuis DC300150485.local..." -ForegroundColor Cyan

netdom trust DC300150485.local 
/Domain:DC300146545.local 
/add 
/twoWay 
/forest 
/UserD:DC300146545\Administrateur 
/PasswordD:* 
/UserO:DC300150485\Administrateur 
/PasswordO:*

Write-Host "Trust créé avec succès !" -ForegroundColor Green
