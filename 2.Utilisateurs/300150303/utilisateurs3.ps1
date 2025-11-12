# --- utilisateurs3.ps1 ---
. .\utilisateurs1.ps1

Write-Host "Utilisateurs dont le prénom contient 'a' (maj/min) :"
$Users | Where-Object { $_.Prenom -match "a" }
