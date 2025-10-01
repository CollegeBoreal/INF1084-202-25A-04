\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable = @(
    @{Nom='Durand'; Prenom='Emma'; Login='edurand'; OU='Stagiaires'},
    @{Nom='Moreau'; Prenom='Paul'; Login='pmoreau'; OU='Stagiaires'}
)
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable += @{Nom='Petit'; Prenom='Chloé'; Login='cpetit'; OU='Stagiaires'}
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable += @{Nom='Fournier'; Prenom='Antoine'; Login='afournier'; OU='Stagiaires'}
\System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable System.Collections.Hashtable | ForEach-Object { "\ \ - Login: \ - OU: \" }
