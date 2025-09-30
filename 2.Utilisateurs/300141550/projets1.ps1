$Users = @(
@{Nom = "Santu"; Prenom = "Emeraude"; Login = "EmerauS"; OU = "Promo2025"},
@{Nom = "Kanu"; Prenom = "Martin"; Login = "MarKanu"; OU = "Promo2025"},
@{Nom = "kapi"; Prenom = "jose"; Login = "KapJoe"; OU = "Promo2025"},
@{Nom = "kiena"; Prenom = "Rubis"; Login = "KienR"; OU = "Promo2025"},
@{Nom = "Paul"; Prenom = "Winner"; Login = "WinKna"; OU = "Promo2025"}

) 

$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
