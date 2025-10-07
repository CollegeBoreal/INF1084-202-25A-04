# utilisateurs3.ps1
if (-not $Users) {
    Write-Host "⚠️ Lance d’abord utilisateurs1.ps1"
    exit
}

"== Noms commençant par B =="
$Users | Where-Object { $_.Nom -like "B*" } | Format-Table Prenom,Nom,Login,OU

"== OU = Stagiaires =="
$Users | Where-Object { $_.OU -eq "Stagiaires" } | Format-Table Prenom,Nom,Login,OU

"== Prénoms contenant 'a' =="
$Users | Where-Object { $_.Prenom -match '(?i)a' } | Format-Table Prenom,Nom,Login,OU
