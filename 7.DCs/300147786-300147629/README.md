## 1. Préparation des environnements

- Chaque étudiant utilise sa VM avec une forêt AD distincte.
- Vérification de la résolution DNS entre les deux forêts :

```powershell
nslookup DC300147786-00.local
nslookup DC300147629-0.local

#2. Création du trust via CLI

Création d’un trust bidirectionnel transitif entre les deux forêts :
netdom trust DC300147629-0.local /Domain:DC300147786-00.local /UserO:Administrator /PasswordO:* /UserD:Administrator /PasswordD:* /Forest /Twoway

#Vérification que le trust a été créé :
nltest /domain_trusts
#3. Vérification du trust et tests d’accès
a. Définition des informations d’accès au domaine distant

$credAD2 = Get-Credential -Message "Entrez le compte administrateur de AD2"

b. Vérification de la connectivité au contrôleur de domaine AD2
Test-Connection -ComputerName dc01.ad2.local -Count 2

e. Accès aux ressources partagées du domaine distant
net use \\10.7.236.225\SharedResources /user:DC300147786-00.local\Administrator *

# Vérification avec klist ou net use que le partage est accessible.



