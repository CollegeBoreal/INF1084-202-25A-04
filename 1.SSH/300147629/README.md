Génération de la clé SSH
ssh-keygen -t ed25519 -C "300147629@monboreal.ca"

Renommage des fichiers
cd ~/.ssh
mv id_ed25519 ma_cle.pk
mv id_ed25519.pub ma_cle.pub

Configuration SSH
nano ~/.ssh/config
```powershell Ajouter:Host github.com HostName github.com User git IdentyFile ~/.ssh/ma_cle.pk
Ajoute de la cle public sur github
Modification de l’URL du dépôt git remote set-url origin git@github.com:CollegeBoreal/INF1084-202-25A-04.git git remote --verbose
</detail>
Création et envoi du fichier README.md
```powershell
mkdir 300147629
cd 300147629
nano README.md
git add 300147629/README.md
git commit -m "Ajout de mon fichier README.md"
git push
#Configuration final SSH
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/ma_cle.pk
