# README – Laboratoire : Partage de ressources et RDP via PowerShell

Ce document décrit étape par étape la création d’un dossier partagé, la configuration d’une GPO pour mapper un lecteur réseau, l’activation du RDP pour un groupe d’utilisateurs, puis les tests de validation.

#🧩 1. Vérification du groupe Students et de ses membres

Objectif : s’assurer que les utilisateurs autorisés appartiennent bien au groupe destiné au partage et aux accès réseau.

# Vérifier que le groupe existe
Get-ADGroup -Identity "Students"

# Vérifier les membres du groupe
Get-ADGroupMember -Identity "Students"

<img width="989" height="461" alt="1" src="https://github.com/user-attachments/assets/f2910fd9-2705-4bdc-892a-735465d383fb" />

🗂️ 2. Vérification du partage SMB – SharedResources

Objectif : confirmer que le partage réseau est bien créé et que les permissions sont correctement appliquées.
# Vérifier l’existence du partage
Get-SmbShare -Name "SharedResources"

# Vérifier les permissions du partage
Get-SmbShareAccess -Name "SharedResources"

<img width="852" height="213" alt="2" src="https://github.com/user-attachments/assets/68599e87-12d7-46f1-a535-77d003c9f1a6" />

🧭 3. Vérification de la GPO – Mappage du lecteur réseau

Objectif : garantir que la GPO responsable du lecteur Z est bien créée et liée à l’OU des étudiants.
# Vérifier que la GPO existe
Get-GPO -Name "MapSharedFolder"

<img width="660" height="246" alt="3" src="https://github.com/user-attachments/assets/433e4226-61c3-4522-a07f-b37ca28a4209" />






 







