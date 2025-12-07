# README – Laboratoire : Partage de ressources et RDP via PowerShell

Ce document décrit étape par étape la création d’un dossier partagé, la configuration d’une GPO pour mapper un lecteur réseau, l’activation du RDP pour un groupe d’utilisateurs, puis les tests de validation.

#🧩 1. Vérification du groupe Students et de ses membres

Objectif : s’assurer que les utilisateurs autorisés appartiennent bien au groupe destiné au partage et aux accès réseau.

# Vérifier que le groupe existe
Get-ADGroup -Identity "Students"

# Vérifier les membres du groupe
Get-ADGroupMember -Identity "Students"

<img width="989" height="461" alt="1" src="https://github.com/user-attachments/assets/f2910fd9-2705-4bdc-892a-735465d383fb" />




 






