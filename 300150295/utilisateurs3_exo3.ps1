# utilisateurs3_exo3.ps1 - Exercice 3 : Requ�tes et filtres
System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable = @(
    @{Nom='Dupont'; Prenom='Alice'; Login='adupont'; OU='Stagiaires'},
    @{Nom='Lemoine'; Prenom='Sarah'; Login='slemoine'; OU='Stagiaires'},
    @{Nom='Benali'; Prenom='Karim'; Login='kbenali'; OU='Stagiaires'},
    @{Nom='Martin'; Prenom='Luc'; Login='lmartin'; OU='Stagiaires'},
    @{Nom='Nguyen'; Prenom='Linh'; Login='lnguyen'; OU='Stagiaires'},
    @{Nom='Durand'; Prenom='Emma'; Login='edurand'; OU='Stagiaires'},
    @{Nom='Moreau'; Prenom='Paul'; Login='pmoreau'; OU='Stagiaires'},
    @{Nom='Petit'; Prenom='Chlo�'; Login='cpetit'; OU='Stagiaires'},
    @{Nom='Fournier'; Prenom='Antoine'; Login='afournier'; OU='Stagiaires'},
    @{Nom='Gauthier'; Prenom='Nina'; Login='ngauthier'; OU='Stagiaires'},
    @{Nom='Rousseau'; Prenom='Thomas'; Login='trousseau'; OU='Stagiaires'},
    @{Nom='Marchand'; Prenom='L�a'; Login='lmarchand'; OU='Stagiaires'},
    @{Nom='Blanc'; Prenom='Victor'; Login='vblanc'; OU='Stagiaires'},
    @{Nom='Lefevre'; Prenom='Julien'; Login='jlefevre'; OU='Stagiaires'},
    @{Nom='Garcia'; Prenom='Sofia'; Login='sgarcia'; OU='Stagiaires'},
    @{Nom='Cl�ment'; Prenom='Maxime'; Login='mlement'; OU='Stagiaires'},
    @{Nom='Fernandez'; Prenom='Ana'; Login='afernandez'; OU='Stagiaires'}
)

# Filtrer tous les utilisateurs dont le pr�nom contient "a" (maj/min)
System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable | Where-Object { .Prenom -match "(?i)a" } | ForEach-Object { " " }
