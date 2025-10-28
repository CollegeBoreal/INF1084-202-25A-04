# --- user3
$Users = @(
    @{Nom="Dupont";  Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim";  Login="kbenali";  OU="Stagiaires"},
    @{Nom="Martin";  Prenom="Nora";   Login="nmartin";  OU="Stagiaires"},
    @{Nom="Bernard"; Prenom="Amine";  Login="abernard"; OU="Stagiaires"}
)

# listing users that their names start with B 
"--- Nom commence par 'B' ---"
$Users | Where-Object {$_.Nom -like "B*"}

# list users where "Stagiaires" are
"--- OU = 'Stagiaires' ---"
$Users | Where-Object {$_.OU -eq "Stagiaires"}

# prénom contenantnames that contain  'a' (insensible à la casse)
"--- Prenom contient 'a' ---"
$Users | Where-Object {$_.Prenom -match 'a'}
