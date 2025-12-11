# trust2.ps1
# Création et vérification de la relation de confiance entre les deux domaines

Write-Host "=== Création du trust bidirectionnel entre les deux forêts ===" -ForegroundColor Green

netdom trust DC300152410-00.local `
/Domain:DC300151354-00.local `
/UserO:Administrator `
/PasswordO:* `
/UserD:Administrator `
/PasswordD:* `
/Forest `
/Twoway

Write-Host "=== Vérification de la relation de confiance ===" -ForegroundColor Green
nltest /domain_trusts

Write-Host "=== Vérification terminée ===" -ForegroundColor Green
