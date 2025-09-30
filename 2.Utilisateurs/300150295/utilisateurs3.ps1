\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable = @(
    @{Nom='Gauthier'; Prenom='Nina'; Login='ngauthier'; OU='Stagiaires'},
    @{Nom='Rousseau'; Prenom='Thomas'; Login='trousseau'; OU='Stagiaires'}
)
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable += @{Nom='Marchand'; Prenom='Léa'; Login='lmarchand'; OU='Stagiaires'}
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable += @{Nom='Blanc'; Prenom='Victor'; Login='vblanc'; OU='Stagiaires'}
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable | ForEach-Object { "\ \ - Login: \ - OU: \" }
