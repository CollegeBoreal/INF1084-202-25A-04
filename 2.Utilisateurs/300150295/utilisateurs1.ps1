\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable = @(
    @{Nom='Dupont'; Prenom='Alice'; Login='adupont'; OU='Stagiaires'},
    @{Nom='Lemoine'; Prenom='Sarah'; Login='slemoine'; OU='Stagiaires'},
    @{Nom='Benali'; Prenom='Karim'; Login='kbenali'; OU='Stagiaires'}
)
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable += @{Nom='Martin'; Prenom='Luc'; Login='lmartin'; OU='Stagiaires'}
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable += @{Nom='Nguyen'; Prenom='Linh'; Login='lnguyen'; OU='Stagiaires'}
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable | ForEach-Object { "\ \ - Login: \ - OU: \" }
