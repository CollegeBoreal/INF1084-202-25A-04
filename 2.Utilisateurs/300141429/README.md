# 📘 Simulation Active Directory – PowerShell

## 1️⃣ Création d’utilisateurs simulés
```powershell
Exercice 1 : Créer une liste d’utilisateurs et en ajouter 2 nouveaux
```
<details>
```powershell
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Diallo"; Prenom="Moussa"; Login="mdiallo"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Linh"; Login="lnguyen"; OU="Stagiaires"}
)

$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
```
</details>

2️⃣ Création de groupes simulés
```powershell
Exercice 2 : Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans GroupeFormation
```
<details>
```powershell
--- Script utilisateurs2.ps1 : Groupes et ajout d'utilisateurs ---

Membres du GroupeFormation :
Alice Dupont - Login: adupont
Sarah Lemoine - Login: slemoine
Karim Benali - Login: kbenali
Moussa Diallo - Login: mdiallo
Linh Nguyen - Login: lnguyen
```
</details>

3️⃣ Requêtes et filtres
```powershell
Exercice 3 : Lister tous les utilisateurs dont le prénom contient "a"
```
<details>

```powershell
--- Script utilisateurs2.ps1 : Groupes et ajout d'utilisateurs ---

Membres du GroupeFormation :
Alice Dupont - Login: adupont
Sarah Lemoine - Login: slemoine
Karim Benali - Login: kbenali
Moussa Diallo - Login: mdiallo
Linh Nguyen - Login: lnguyen
```
</details>

4️⃣ Export et import CSV
```powershell
Exercice 4 : Exporter les utilisateurs simulés et créer un groupe ImportGroupe
```
<details>

```powershell
Membres du groupe ImportGroupe :
Alice Dupont - Login: adupont - OU: Stagiaires
Sarah Lemoine - Login: slemoine - OU: Stagiaires
Karim Benali - Login: kbenali - OU: Stagiaires
Moussa Diallo - Login: mdiallo - OU: Stagiaires
Linh Nguyen - Login: lnguyen - OU: Stagiaires
```
</details>




