# Exercice 4 - Export et import CSV

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenon="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Tahar"; Prenom="Aroua"; Login="atahar"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Julie"; Login="jmartin"; OU="Stagiaires"}
)

$Path = "C:\Temp\UsersSimules.csv"
$Users | Export-Csv -Path $Path -NoTypeInformation

$Imported = Import-Csv -Path $Path

$Groups = @{
    ImportGroupe = @()
}

foreach ($u in $Imported) {
    $Groups["ImportGroupe"] += $u
}

Write-Output "ImportGroupe :"
$Groups["ImportGroupe"]
