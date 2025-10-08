# utilisateurs3.ps1
# Charger les utilisateurs depuis le CSV
$UsersObj = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# 1️⃣ Nom commence par "B"
Write-Host "`n--- Utilisateurs dont le nom commence par 'B' ---"
$UsersObj | Where-Object { $_.Nom -like "B*" } | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# 2️⃣ OU = Promo2025
Write-Host "`n--- Utilisateurs dans l'OU 'Promo2025' ---"
$UsersObj | Where-Object { $_.OU -eq "Promo2025" } | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# 3️⃣ Prénom contient "a"
Write-Host "`n--- Utilisateurs dont le prénom contient 'a' ---"
$UsersObj | Where-Object { $_.Prenom -match "(?i)a" } | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

