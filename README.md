<<<<<<< HEAD
#300146545  saoudi alaoua 

PS C:\Users\Administrator> GET-ADDomain                                                  

AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300146545-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300146545-00,DC=local
DistinguishedName                  : DC=DC300146545-00,DC=local
DNSRoot                            : DC300146545-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300146545-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300146545-00,DC=l
                                     ocal
Forest                             : DC300146545-00.local
InfrastructureMaster               : DC30014645.DC300146545-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Polic
                                     ies,CN=System,DC=DC300146545-00,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300146545-00,DC=local
ManagedBy                          :
Name                               : DC300146545-00
NetBIOSName                        : DC300146545-00
ObjectClass                        : domainDNS
ObjectGUID                         : ed49e65b-738d-4394-854e-1b8fa9ee7ae4
ParentDomain                       :
PDCEmulator                        : DC30014645.DC300146545-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300146545-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC30014645.DC300146545-00.local}
RIDMaster                          : DC30014645.DC300146545-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300146545-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300146545-00,DC=local,
                                     CN=Configuration,DC=DC300146545-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300146545-00,DC=local
UsersContainer                     : CN=Users,DC=DC300146545-00,DC=local
=======
<<<<<<< HEAD
# TP : Simulation Active Directory avec PowerShell

[:tada: Participation](.scripts/Participation.md) 

## Objectifs

* Comprendre la structure AD (utilisateurs, groupes, OU).
* S’entraîner aux cmdlets PowerShell pour la création, la recherche et la manipulation d’objets.
* Se préparer aux scripts AD réels.

:bookmark: Nommez vos scripts Powershell selon le format suivant `utilisateurs`[1-4]`.ps1`

---

## 1️⃣ Création d’objets utilisateurs simulés

```powershell
# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
```

**Exercice 1** : Ajouter 2 nouveaux utilisateurs à la liste et vérifier qu’ils s’affichent correctement.

---

## 2️⃣ Création de groupes simulés

```powershell
# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter un utilisateur à un groupe
$Groups["GroupeFormation"] += $Users[0]   # Alice Dupont
```

**Exercice 2** : Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans "GroupeFormation".

---

## 3️⃣ Requêtes et filtres

```powershell
# Lister tous les utilisateurs dont le nom commence par "B"
$Users | Where-Object {$_.Nom -like "B*"}

# Lister tous les utilisateurs dans l'OU "Stagiaires"
$Users | Where-Object {$_.OU -eq "Stagiaires"}
```

**Exercice 3** : Lister tous les utilisateurs dont le prénom contient "a" (majuscule/minuscule).

---

## 4️⃣ Export et import CSV

```powershell
# Exporter les utilisateurs simulés
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"
$ImportedUsers
```

**Exercice 4** : Importer le fichier CSV et créer un groupe "ImportGroupe" en ajoutant tous les utilisateurs importés.

---

## 5️⃣ Mini-projet : script complet de simulation

1. Créer 5 utilisateurs simulés dans l’OU "Promo2025".
2. Créer un groupe "Etudiants2025".
3. Ajouter tous les utilisateurs de "Promo2025" dans le groupe.
4. Exporter la liste finale du groupe en CSV.
=======
# INF1084-202-25A-04
INF1084 (202) - Introduction à l'administration des systèmes

## :date: [Épreuves](.epreuves)

## :one: [Devoirs](Devoirs)

|:hash: | Date   | Cours                      | Intitulé                            |  Pratique                                                     |
|-------|--------|:---------------------------|:------------------------------------|:--------------------------------------------------------------|
| :one:   |01-sept| [0.PlanDeCours](0.PlanDeCours/.scripts/Participation.md)       | â Noter :x: |
| :two:   |08-sept| [0.Tutoriel sur GIT](.scripts/Participation.md)       | â Noter :x: |
| :three: |15-sept| [1.SSH](1.SSH/.scripts/Participation.md)       | â Noter :x: |
| :four:  |22-sept| [2.Utilisateurs](2.Utilisateurs/.scripts/Participation.md)       | â Noter :x: |

# :books: References

- [ ] Comment vérifier que le `commit` a été fait par le `CLI`
      
`git log --format=fuller -- `:id:`.md`
>>>>>>> e7ca14532d1dfd370d8e3994b5211a6e8e0899a2
>>>>>>> be6360123ecbad7987d6b214377b449d5b24d20d
