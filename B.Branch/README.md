# :tanabata_tree: [Branch](https://git-scm.com/docs/git-branch)

Une branche sert à créer une section à part dans l'arbre du référentiel github.

## :a: Créer ta branche

Si tu veux appeller ta branche `300098957` avec ton :id: Boreal par exemple `300098957`

:round_pushpin: Crée une branche 

```sh
git branch 300098957
```

:round_pushpin: Accède à ta branche

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

:round_pushpin: Soumettre les modifications de ta branche

* :bulb: avant de soumettre, rajouter le code à la branche `git add .`, mettre en scene `git commit -m "mon message"`

```sh
git push origin 300098957
```

<hr>

## :b: Gérer ta branche

Étant déjà dans ta branche (voir section précédente), tu peux dorénavant gérer ton code comme auparavant:

```bash
git add .
git commit -m ":star: mon message"
git push
```

## :ab: Pour mettre à jour l'énoncé provenant de la branche principale `main` et récupérer le modifications du cours:

```sh
git pull --no-edit
git merge --no-edit
```

