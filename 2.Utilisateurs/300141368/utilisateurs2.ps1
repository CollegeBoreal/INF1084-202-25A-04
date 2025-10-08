$Groups = @{
     "GroupeFormation" = @()
     "ProfesseursAD" = @()
}


foreach ($user in $Users) {
     $Groups["GroupeFormation"] += $user
}
