# 300141550

- [ ] Créer le script pour Utilsateur1

```sh
nano utilisateurs1.ps1
```
>
```powershell
Alice Dupont - Login: adupont - OU: Stagiaires
Sarah Lemoine - Login: slemoine - OU: Stagiaires
Karim Benali - Login: kbenali - OU: Stagiaires
Emeraude Santu - Login: santueme - OU: Stagiares
Martin Kanu - Login: kanumar - OU: Stagiares
```
- [ ] Exécuter le script pour Utilsateur1

```sh
.\utilisateurs1.ps1
```



- [ ] Créer le script pour Utilsateur2

```sh
nano utilisateurs2.ps1
```
>

```powershell
Name                           Value
----                           -----
OU                             Stagiaires
Nom                            Dupont
Login                          adupont
Prenom                         Alice
OU                             Stagiaires
Nom                            Lemoine
Login                          slemoine
Prenom                         Sarah
OU                             Stagiaires
Nom                            Benali
Login                          kbenali
Prenom                         Karim
OU                             Stagiaires
Nom                            Santu
Login                          santueme
Prenom                         Emeraude
OU                             Stagiaires
Nom                            Martin
Login                          markanu
Prenom                         Kanu
```
- [ ] Exécuter le script pour Utilsateur2

```sh
.\utilisateurs2.ps1
```



- [ ] Créer le script pour Utilsateur3

```sh
nano utilisateurs3.ps1
```
>

```powershell
Name                           Value
----                           -----
OU                             Stagiaires
Nom                            Dupont
Login                          adupont
Prenom                         Alice
OU                             Stagiaires
Nom                            Lemoine
Login                          slemoine
Prenom                         Sarah
OU                             Stagiaires
Nom                            Benali
Login                          kbenali
Prenom                         Karim
OU                             Stagiaires
Nom                            Santu
Login                          santueme
Prenom                         Emeraude
OU                             Stagiaires
Nom                            Martin
Login                          markanu
Prenom                         Kanu
```
- [ ] Exécuter le script pour Utilsateur3

```sh
.\utilisateurs3.ps1
```





- [ ] Créer le script pour Utilsateur4 

```sh
nano utilisateurs4.ps1
```
>

```powershell

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        2025-09-25   5:38 PM                Temp

IsReadOnly     : False
IsFixedSize    : False
IsSynchronized : False
Keys           : System.Collections.Hashtable+KeyCollection
Values         : System.Collections.Hashtable+ValueCollection
SyncRoot       : System.Object
Count          : 4


IsReadOnly     : False
IsFixedSize    : False
IsSynchronized : False
Keys           : System.Collections.Hashtable+KeyCollection
Values         : System.Collections.Hashtable+ValueCollection
SyncRoot       : System.Object
Count          : 4


IsReadOnly     : False
IsFixedSize    : False
IsSynchronized : False
Keys           : System.Collections.Hashtable+KeyCollection
Values         : System.Collections.Hashtable+ValueCollection
SyncRoot       : System.Object
Count          : 4


IsReadOnly     : False
IsFixedSize    : False
IsSynchronized : False
Keys           : System.Collections.Hashtable+KeyCollection
Values         : System.Collections.Hashtable+ValueCollection
SyncRoot       : System.Object
Count          : 4


IsReadOnly     : False
IsFixedSize    : False
IsSynchronized : False
Keys           : System.Collections.Hashtable+KeyCollection
Values         : System.Collections.Hashtable+ValueCollection
SyncRoot       : System.Object
Count          : 4


IsReadOnly     : False
IsFixedSize    : False
IsSynchronized : False
Keys           : System.Collections.Hashtable+KeyCollection
Values         : System.Collections.Hashtable+ValueCollection
SyncRoot       : System.Object
Count          : 4


IsReadOnly     : False
IsFixedSize    : False
IsSynchronized : False
Keys           : System.Collections.Hashtable+KeyCollection
Values         : System.Collections.Hashtable+ValueCollection
SyncRoot       : System.Object
Count          : 4


IsReadOnly     : False
IsFixedSize    : False
IsSynchronized : False
Keys           : System.Collections.Hashtable+KeyCollection
Values         : System.Collections.Hashtable+ValueCollection
SyncRoot       : System.Object
Count          : 4


IsReadOnly     : False
IsFixedSize    : False
IsSynchronized : False
Keys           : System.Collections.Hashtable+KeyCollection
Values         : System.Collections.Hashtable+ValueCollection
SyncRoot       : System.Object
Count          : 4


IsReadOnly     : False
IsFixedSize    : False
IsSynchronized : False
Keys           : System.Collections.Hashtable+KeyCollection
Values         : System.Collections.Hashtable+ValueCollection
SyncRoot       : System.Object
Count          : 4

```

- [ ] j'ai du faire quelques modification du code entre autre :
   1. la creation du dossier c:\Temp : New-Item -ItemType Directory -Path "C:\Temp" -Force
      suivi de : $Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation
   2. l'importation du ficher : $ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"
$ImportedUsers
   3. importation normale du code : $ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"
$ImportedUsers
   4. creation du groupe et ajout des utilisateurs : $Groups = @{
    "ImportGroupe" = @()
}

$Groups["ImportGroupe"] += $ImportedUsers
$Groups["ImportGroupe"]

- [ ] Exécuter le script pour Utilsateur3

```sh
.\utilisateurs3.ps1
```






- [ ] Créer le script pour projet1

```sh
nano projets1.ps1
```
>
```powershell
Emeraude Santu - Login: EmerauS - OU: Promo2025
Martin Kanu - Login: MarKanu - OU: Promo2025
jose kapi - Login: KapJoe - OU: Promo2025
Rubis kiena - Login: KienR - OU: Promo2025
Winner Paul - Login: WinKna - OU: Promo2025
```
- [ ] Exécuter le script pour projet1

```sh
.\projets1.ps1
```

- [ ] Créer le script pour Projets2
- [ ] note ***
le projet 3 combine la question 2 et 3 

```sh
nano projets2.ps1
```
>

```powershell

Name                           Value
----                           -----
OU                             Promo2025
Nom                            Santu
Login                          EmerauS
Prenom                         Emeraude
OU                             Promo2025
Nom                            Kanu
Login                          MarKanu
Prenom                         Martin
OU                             Promo2025
Nom                            kapi
Login                          KapJoe
Prenom                         jose
OU                             Promo2025
Nom                            kiena
Login                          KienR
Prenom                         Rubis
OU                             Promo2025
Nom                            Paul
Login                          WinKna
Prenom                         Winner
```
- [ ] Exécuter le script pour Projets2
- [ ] notes *** :
      le projets2 combien la resolution de la question 2 et 3

```sh
.\projets2.ps1
```
- [ ] ajustement du code :
      . .\projets1.ps1     #appel au ficher projets1                                                                                                                                                                                                      $Groups = @{                                                                                                                                                                                                                                             "Etudiants2025" = @()                                                                                                             }                                                                                                                                                                                                                                                    # Ajouter tous les utilisateurs de l’OU "Promo2025" dans le groupe                                                           $Groups["Etudiants2025"] += $Users | Where-Object { $_.OU -eq "Promo2025" }                                                                                                                                                                               # Vérifier que le groupe contient bien les bons utilisateurs                                                                         $Groups["Etudiants2025"]   



- [ ] Créer le script pour projets3
- [ ] notes ***** :
  le projet3 est la resolution de la question 4 ( "Exporter la liste finale du groupe en CSV." )

```sh
nano projets3.ps1
```
>
```powershell
Exportation finie : C:\Temp\Etudiants2025.csv
```
- [ ] Exécuter le script pour projets3

```sh
.\projets3.ps1
```
