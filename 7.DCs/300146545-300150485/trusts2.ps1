# Script : trust2.ps1
# Domaine local : DC300146545.local
# Domaine distant : DC300150485.local
# Auteur : 300146545

Write-Host "Vérification du trust depuis DC300146545.local..." -ForegroundColor Cyan

netdom trust DC300146545.local `
/Domain:DC300150485.local `
/verify

Write-Host "Vérification terminée !" -ForegroundColor Green
