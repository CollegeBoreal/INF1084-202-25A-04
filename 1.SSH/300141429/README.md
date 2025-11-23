Génération de la clé SSH
ssh-keygen -t ed25519 -C "300141429@monboreal.ca"

Renommage des fichiers
cd ~/.ssh
mv id_ed25519 ma_cle.pk
mv id_ed25519.pub ma_cle.pub

Configuration SSH
Éditer le fichier ~/.ssh/config :
nano ~/.ssh/config

Ajouter :
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/ma_cle.pk

Ajout de la clé publique sur GitHub
- Aller dans Settings > SSH and GPG keys.
- Ajouter le contenu du fichier ma_cle.pub.

Modification de l’URL du dépôt
git remote set-url origin git@github.com:CollegeBoreal/INF1084-202-25A-04.git
git remote --verbose

Création et envoi du fichier README.md
mkdir 300141429
cd 300141429
nano README.md
git add 300141429/README.md
git commit -m "Ajout de mon fichier README.md"
git push

---
Configuration finale
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/ma_cle.pk



