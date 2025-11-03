# :key: SSH

[:tada: Participation](.scripts/Participation.md)

## :a: Gestion de votre clé SSH

- [ ] [Générer votre clé SSH][SSH_KEY]
   ```sh
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
   - Éviter le 'pass phrase' en appuyant sur la touche `Enter`
   - renommer les fichiers par défaut qui se trouvent dans le répertoire `~/.ssh`

        - aller vers le répertoire `~/.ssh`
      ```sh
      cd ~/.ssh
      ```
        - renommer les fichiers
      ```sh
      mv id_ed25519 ma_cle.pk
      mv id_ed25519.pub ma_cle.pub
      ```

- [ ] [:secret: Configurer git avec votre clé personnelle][SSH_PRIVATE_KEY] [Documentation][SSH_GITHUB_ACCOUNT]

* le Fichier de configuration `SSH` ***~/.ssh/config***

:pushpin: Utilisation du port ssh par défaut :two::two:

- Éditer le fichier de configuration de `SSH`

   ```sh
   nano ~/.ssh/config
   ```

- Ajouter le contenu ci-dessous et ajuster le nom de fichier de votre clé privée (.pk).

   ```powershell
   Host github.com
       HostName github.com
       User git
       IdentityFile ~/.ssh/ma_cle.pk
   ```

- [ ] [Ajouter votre clé publique à votre compte github][SSH_KEY_ACCOUNT]


### :five: Changer l'URL du cours

1. **revenir au répertoire du cours**

   ```sh
   cd ~/Developer/INF1084-202-25A-04/1.SSH
   ```

2. **Changer l’URL du dépôt distant**

   ```sh
   git remote set-url origin git@github.com:CollegeBoreal/INF1084-202-25A-04.git
   ```

3. **Vérifier la nouvelle configuration du dépôt distant**

   ```sh
   git remote --verbose
   ```

   Ce qui affiche actuellement :

   ```lua
   origin  git@github.com:CollegeBoreal/INF1084-202-25A-04.git (fetch)
   origin  git@github.com:CollegeBoreal/INF1084-202-25A-04.git (push)
   ```

### :six: Créer un fichier dans ce répertoire `(1.SSH)`:

:checkered_flag: Finalement,

- [ ] avec le nom de répertoire :id: (votre identifiant boreal)
- [ ] dans votre répertoire ajouter le fichier `README.md`
  - [ ] `nano `README.md
- [ ] envoyer vers le serveur `git`
  - [ ] `git add `:id:/README.md
  - [ ] `git commit -m "mon fichier ..."` :id:/README.md
  - [ ] `git push`


# :books: References

## :bulb: [Tutoriel sur GIT](https://github.com/CollegeBoreal/Tutoriels/tree/main/0.GIT)


[SSH_KEY]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
[SSH_KEY_ACCOUNT]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account#adding-a-new-ssh-key-to-your-account
[SSH_PRIVATE_KEY]: https://github.com/CollegeBoreal/Tutoriels/tree/main/0.GIT#secret-configurer-git-clé-personnelle-documentation
[SSH_GITHUB_ACCOUNT]: https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account

