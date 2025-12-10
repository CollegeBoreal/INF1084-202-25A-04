# utilisateurs1.ps1

$infos = @{
    "Karim BENZEMA" = "kbenzema,Stagiaires"
    "Nabil FEKIR" = "nfekir,Stagiaires"
    "Hakim ZIYECH" = "hziyech,Stagiaires"
    "Achraf HAKIMI" = "ahakimi,Stagiaires"
    "Yassine BOUNOU" = "ybounou,Stagiaires"
}

foreach ($nom in $infos.Keys) {
    $details = $infos[$nom].Split(",")
    Write-Host "$nom - Login: $($details[0]) - OU: $($details[1])"
}
