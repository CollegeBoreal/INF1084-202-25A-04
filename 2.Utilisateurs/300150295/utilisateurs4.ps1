\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable = @(
    @{Nom='Lefevre'; Prenom='Julien'; Login='jlefevre'; OU='Stagiaires'},
    @{Nom='Garcia'; Prenom='Sofia'; Login='sgarcia'; OU='Stagiaires'}
)
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable += @{Nom='Clément'; Prenom='Maxime'; Login='mlement'; OU='Stagiaires'}
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable += @{Nom='Fernandez'; Prenom='Ana'; Login='afernandez'; OU='Stagiaires'}
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable | ForEach-Object { "\ \ - Login: \ - OU: \" }
