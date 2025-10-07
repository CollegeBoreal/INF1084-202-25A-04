# :tanabata_tree: [Branch](https://git-scm.com/docs/git-branch)

Un branche sert à créer une section à part dans l'arbre du référentiel github.

Si on veut appeller notre branche `300098957` avec ton :id: Boreal par exemple `300098957`

:round_pushpin: Créer une branche 

```sh
git branch 300098957
```

:round_pushpin: Accéder à la branche

```sh
git checkout 300098957
```

:round_pushpin: Vérifier l'accès à la branche

```sh
git status
```
<details><div style="user-select: none;"><pre>
On branch 300098957
nothing to commit, working tree clean
</pre></div></details>

:round_pushpin: Soumettre les modifications de la branche

* avant de soumettre, rajouter le code à la branche `git add .`, mettre en scene `git commit -m "mon message"`

```
$ git push origin 300098957
```

<hr>
