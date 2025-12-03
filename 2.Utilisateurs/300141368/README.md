\# 300141368



DANIELLA DIWA



\## Exercice :one:



utilisateurs.ps1





$Users = @(

    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},

    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},

    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},

    @{Nom="Daniella"; Prenom="Kembo"; Login="kdaniella"; OU="Stagiaires"},

    @{Nom="Maisha"; Prenom="Diwa"; Login="dmaisha"; OU="Stagiaires"}

)





utilisateurs2.ps1





\# Exercice 2 : Ajouter les utilisateurs "Stagiaires" dans "GroupeFormation"



\#  Import des utilisateurs

. .\\utilisateurs1.ps1



\# Création des groupes

$Groups = @{

&nbsp;   "GroupeFormation" = @()

&nbsp;   "ProfesseursAD" = @()

}



\# Ajouter tous les utilisateurs de l'OU "Stagiaires" dans GroupeFormation

$Groups\["GroupeFormation"] += $Users | Where-Object { $\_.OU -eq "Stagiaires" }



\# Affichage du groupe

Write-Host "`n👥 Membres de GroupeFormation :"

$Groups\["GroupeFormation"] | ForEach-Object {

&nbsp;   "$($\_.Prenom) $($\_.Nom)"

}





utilisateurs3.ps1 



\# utilisateurs3.ps1





\#  Import des utilisateurs

. .\\utilisateurs1.ps1



\# Lister tous les utilisateurs dont le nom commence par "B"

$Users | Where-Object {$\_.Nom -like "B\*"}



\# Lister tous les utilisateurs dans l'OU "Stagiaires"

$Users | Where-Object {$\_.OU -eq "Stagiaires"}





utilisateurs4.ps1 



\# utilisateurs4.ps1

\#  Exercice 4 : Export CSV, import, et création d'un groupe avec les utilisateurs importés



\#  Import des utilisateurs

. .\\utilisateurs1.ps1



\# Exporter les utilisateurs simulés

$Users | Export-Csv -Path "C:\\Temp\\UsersSimules.csv" -NoTypeInformation



\# Importer depuis CSV

$ImportedUsers = Import-Csv -Path "C:\\Temp\\UsersSimules.csv"

$ImportedUsers

