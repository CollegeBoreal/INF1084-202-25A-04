
#300153747
:star: c'est moi madjou

##exercice :one:
# j'ai fais la commande suivante Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
## pour modifier ma politique d'execution



utilisateurs1.ps1
```powershell
# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Bah"; Prenom="Madjou"; Login="BMadjou"; OU="Etudiant"},
    @{Nom="Diallo"; Prenom="Hakin"; Login="Hdiallo"; OU="Menusier"} 
)

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
```
<details>
  ```powershell
  PS C:\Users\thier\Developer\INF1084-202-25A-04\2.Utilisateurs\300153747> .\utilisateurs1.ps1
Alice Dupont - Login: adupont - OU: Stagiaires
Sarah Lemoine - Login: slemoine - OU: Stagiaires
Karim Benali - Login: kbenali - OU: Stagiaires
Madjou Bah - Login: BMadjou - OU: Etudiant
Hakin Diallo - Login: Hdiallo - OU: Menusier
  ```
</details>


utilisateurs2.ps1
```powershell
# Simuler une liste d'utilisateurs avec leurs informations (nom + OU)
$Users = @(
    @{ Name = "Alice Dupont"; OU = "Stagiaires" }
    @{ Name = "Jean Martin"; OU = "Professeurs" }
    @{ Name = "Claire Bernard"; OU = "Stagiaires" }
    @{ Name = "Marc Petit"; OU = "Administratif" }
)

# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter les utilisateurs dont l'OU est "Stagiaires" dans GroupeFormation
foreach ($user in $Users) {
    if ($user.OU -eq "Stagiaires") {
        $Groups["GroupeFormation"] += $user.Name
    }
}

# Afficher les membres du groupe GroupeFormation
Write-Host "Membres du groupe GroupeFormation :
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "- $_"
}
```
<details>
  
```powershell
PS C:\Users\thier\Developer\INF1084-202-25A-04\2.Utilisateurs\300153747> .\utilisateurs2.ps1
Membres du groupe GroupeFormation :
- Alice Dupont
- Claire Bernard

```
</details>

utilisateurs3.ps1
```powershell
# Lister tous les utilisateurs dont le nom commence par "B"
$Users | Where-Object {$_.Nom -like "B*"}

# Lister tous les utilisateurs dans l'OU "Stagiaires"
$Users | Where-Object {$_.OU -eq "Stagiaires"}
```

utilisateur4.ps1
```powershell
# Définir des utilisateurs comme objets
$Users = @(
    [PSCustomObject]@{ Nom="Dupont"; Prenom="Alice"; OU="Stagiaires" }
    [PSCustomObject]@{ Nom="Diallo"; Prenom="Ibrahima"; OU="Professeurs" }
    [PSCustomObject]@{ Nom="Bah"; Prenom="Thierno"; OU="Stagiaires" }
)

# Créer le dossier C:\Temp s'il n'existe pas
if (-not (Test-Path -Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp" | Out-Null
}

# Exporter les utilisateurs
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation -Encoding UTF8

# Importer les utilisateurs
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Afficher les utilisateurs importés
Write-Host "Utilisateurs importés depuis le CSV :" -ForegroundColor Cyan
$ImportedUsers | Format-Table -AutoSize
```
<detailS>
  ```powershell
  PS C:\Users\thier\Developer\INF1084-202-25A-04\2.Utilisateurs\300153747> .\utilisateurs4.ps1
Utilisateurs importÃ©s depuis le CSV :

Nom    Prenom   OU
---    ------   --
Dupont Alice    Stagiaires
Diallo Ibrahima Professeurs
Bah    Thierno  Stagiaires
```
</detailS>


