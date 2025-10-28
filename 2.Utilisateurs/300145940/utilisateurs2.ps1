# group users creation
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}
# users list
$Users = @(
    @{ Nom = "Alice Dupont"; OU = "Stagiaires" },
    @{ Nom = "Bob Martin"; OU = "Professeurs" },
    @{ Nom = "Chloé Tremblay"; OU = "Stagiaires" },
    @{ Nom = "David Roy"; OU = "Direction" }
)

#creating users where stagiars ar "GroupeFormation"
foreach ($user in $Users) {
    if ($user.OU -eq "Stagiaires") {
        $Groups["GroupeFormation"] += $user
    }
}
# show the content "GroupeFormation"
$Groups["GroupeFormation"]
