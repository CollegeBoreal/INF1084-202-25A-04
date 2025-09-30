# :key: SSH

[:tada: Participation](.scripts/Participation.md)

## :a: Créer votre clé SSH

- [ ] [Générer votre clé SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)
- [ ] [Ajouter votre clé publique à votre compte github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

## :b: Configurer votre clé privée

- [ ] [Configurer git avec votre clé personnelle](https://github.com/CollegeBoreal/Tutoriels/tree/main/0.GIT#secret-configurer-git-clé-personnelle-documentation)

## :o: Changer l'URL du cours

1. **Changer l’URL du dépôt distant**

   ```sh
<<<<<<< HEAD
   git remote set-url origin git@github.com:CollegeBoreal/INF1084-202-25A-04.git
=======
   git remote set-url origin git@github.com:CollegeBoreal/INF1084-202-25A-03.git
>>>>>>> bfd96a15e0e759c85b338713c638dfac8a07f550
   ```

2. **Vérifier la nouvelle configuration du dépôt distant**

   ```sh
   git remote --verbose
   ```

   Ce qui affiche actuellement :

   ```lua
<<<<<<< HEAD
   origin  git@github-boreal.com:CollegeBoreal/INF1084-202-25A-04.git (fetch)
   origin  git@github-boreal.com:CollegeBoreal/INF1084-202-25A-04.git (push)
=======
   origin  git@github-boreal.com:CollegeBoreal/INF1084-202-25A-03.git (fetch)
   origin  git@github-boreal.com:CollegeBoreal/INF1084-202-25A-03.git (push)
>>>>>>> bfd96a15e0e759c85b338713c638dfac8a07f550
   ```

## :ab: Créer un fichier dans ce répertoire `(1.SSH)`:

- [ ] avec le nom de répertoire :id: (votre identifiant boreal)
- [ ] dans votre répertoire ajouter le fichier `README.md`
  - [ ] `nano `README.md
<<<<<<< HEAD
- [ ] envoyer vers le serveur `git`
  - [ ] `git add `:id:/README.md
  - [ ] `git commit -m "mon fichier ..."` :id:/README.md
=======
  - [ ] remonter au repertoire précédent
        `cd ..`
- [ ] envoyer vers le serveur `git`
  - [ ] `git add `:id:
  - [ ] `git commit -m "mon fichier ..."`
>>>>>>> bfd96a15e0e759c85b338713c638dfac8a07f550
  - [ ] `git push`
