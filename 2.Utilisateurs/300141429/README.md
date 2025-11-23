# 📘 Simulation Active Directory – PowerShell

## 1️⃣ Création d’utilisateurs simulés
```powershell
Exercice 1 : Créer une liste d’utilisateurs et en ajouter 2 nouveaux
<details>

powershell
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Diallo"; Prenom="Moussa"; Login="mdiallo"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Linh"; Login="lnguyen"; OU="Stagiaires"}
)

$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

![Capture utilisateur](images/utilisateurs1.png)


</details>

2️⃣ Création de groupes simulés
powershell
Exercice 2 : Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans GroupeFormation
<details>

powershell
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object {
    $Groups["GroupeFormation"] += $_
}

$Groups["GroupeFormation"]
📸 Capture :

</details>

3️⃣ Requêtes et filtres
powershell
Exercice 3 : Lister tous les utilisateurs dont le prénom contient "a"
<details>

powershell
$Users | Where-Object {$_.Prenom -match "a"}
📸 Capture :

</details>

4️⃣ Export et import CSV
powershell
Exercice 4 : Exporter les utilisateurs simulés et créer un groupe ImportGroupe
<details>

powershell
# Export
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation

# Import
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Créer un groupe ImportGroupe
$Groups["ImportGroupe"] = $ImportedUsers

$Groups["ImportGroupe"]
📸 Captures :

Export CSV :

Import CSV :

Groupe ImportGroupe :

</details>

5️⃣ Mini‑projet complet
powershell
Créer 5 utilisateurs dans Promo2025, un groupe Etudiants2025 et exporter en CSV
<details>

powershell
# Créer 5 utilisateurs dans Promo2025
$UsersPromo2025 = @(
    @{Nom="Martin"; Prenom="Paul"; Login="pmartin"; OU="Promo2025"},
    @{Nom="Lopez"; Prenom="Maria"; Login="mlopez"; OU="Promo2025"},
    @{Nom="Kane"; Prenom="Awa"; Login="akane"; OU="Promo2025"},
    @{Nom="Traore"; Prenom="Ibrahim"; Login="itraore"; OU="Promo2025"},
    @{Nom="Benitez"; Prenom="Sofia"; Login="sbenitez"; OU="Promo2025"}
)

# Créer le groupe Etudiants2025
$Groups["Etudiants2025"] = $UsersPromo2025

# Exporter en CSV
$Groups["Etudiants2025"] | Export-Csv -Path "C:\Temp\Etudiants2025.csv" -NoTypeInformation

$Groups["Etudiants2025"]
📸 Captures :

Utilisateurs Promo2025 :

Groupe Etudiants2025 :

Export final CSV :

</details>


