# =========================================================
# Script : utilisateurs4.ps1
# Exercice 4 : Importer le CSV et créer le groupe ImportGroupe
# =========================================================

# 1) Importer les utilisateurs depuis le CSV
$importedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# 2) Créer la table de groupes
$Groups = @{ "ImportGroupe" = @() }

# 3) Ajouter tous les utilisateurs importés dans ImportGroupe
$Groups["ImportGroupe"] += $importedUsers

# 4) Afficher les membres du groupe ImportGroupe
"`nMembres du groupe ImportGroupe :"
$Groups["ImportGroupe"] | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

@"
Nom,Prenom,Login,OU
Dupont,Alice,adupont,Stagiaires
Lemoine,Sarah,slemoine,Stagiaires
Benali,Karim,kbenali,Stagiaires
Saoudi,Allaoua,asaoudi,Stagiaires
Boukacouma,Mahmoud,mboukacouma,Stagiaires
"@ | Out-File -FilePath "C:\Temp\UsersSimules.csv" -Encoding UTF8

