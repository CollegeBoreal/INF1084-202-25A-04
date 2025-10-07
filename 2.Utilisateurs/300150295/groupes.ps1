\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable = @(
    @{Nom='Dupont'; Prenom='Alice'; Login='adupont'; OU='Stagiaires'},
    @{Nom='Lemoine'; Prenom='Sarah'; Login='slemoine'; OU='Stagiaires'},
    @{Nom='Benali'; Prenom='Karim'; Login='kbenali'; OU='Stagiaires'},
    @{Nom='Martin'; Prenom='Luc'; Login='lmartin'; OU='Stagiaires'},
    @{Nom='Nguyen'; Prenom='Linh'; Login='lnguyen'; OU='Stagiaires'}
)

\ = @{
    'GroupeFormation' = @()
    'ProfesseursAD' = @()
}

\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable | Where-Object { \.OU -eq 'Stagiaires' } | ForEach-Object { \['GroupeFormation'] += \ }

\['GroupeFormation'] | ForEach-Object { "\ \ - Login: \" }
