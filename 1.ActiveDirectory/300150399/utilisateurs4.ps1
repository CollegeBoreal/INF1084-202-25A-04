# utilisateurs4.ps1
if (-not $Users) {
  $Users = @(
    @{Nom="Dupont"; Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine";Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim";  Login="kbenali";  OU="Stagiaires"},
    @{Nom="Boucher";Prenom="Amine";  Login="aboucher"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Nadia";  Login="nmartin";  OU="Stagiaires"}
  )
}
$csvPath = "C:\Temp\UsersSimules.csv"
$null = New-Item -ItemType Directory -Path (Split-Path $csvPath) -Force
$Users | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
$ImportedUsers = Import-Csv -Path $csvPath
$Groups = @{}; $Groups["ImportGroupe"] = @(); $Groups["ImportGroupe"] += $ImportedUsers
"== ImportGroupe =="; $Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom) [$($_.Login)]" }
