\#300141368



0️⃣ bootstrap.ps1

```powershell

\# vos informations

$studentNumber = 300141368

$studentInstance = "00"



\# les noms respectifs

$domainName = "DC$studentNumber-$studentInstance.local"

$netbiosName = "DC$studentNumber-$studentInstance"



\# les informations de sécurité

$plain = 'Infra@2024'

$secure = ConvertTo-SecureString $plain -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)

```



<details>



&nbsp; ```powershell









```



</details>



0️⃣ utilidateurs1.ps1

```powershell

O

\# Importer le module Active Directory

Import-Module ActiveDirectory



\# Définir le nom de domaine

. .\\bootstrap.ps1



\# Vérifier le domaine

Get-ADDomain -Server $domainName



\# Lister les contrôleurs de domaine

Get-ADDomainController -Filter \* -Server $domainName     



&nbsp;# Lister les utilisateurs activés sauf comptes système

Get-ADUser -Filter \* -Server $domainName -Properties Name, SamAccountName, Enabled |

Where-Object { $\_.Enabled -eq $true -and $\_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |

Select-Object Name, SamAccountName"



0️⃣ utilidateurs2.ps1

```powershell

\# Définir le domaine

. .\\bootstrap.ps1



\# Créer un nouvel utilisateur

New-ADUser `

&nbsp;   -Name "Alice Dupont" `

&nbsp;   -GivenName "Alice" `

&nbsp;   -Surname "Dupont" `

&nbsp;   -SamAccountName "alice.dupont" `

&nbsp;   -UserPrincipalName "alice.dupont@$domainName" `

&nbsp;   -Path "CN=Users,DC=DC300141368-00,DC=local" `

&nbsp;   -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `

&nbsp;   -Enabled $true



\# Modifier une propriété

Set-ADUser -Identity "alice.dupont" -Description "Utilisateur de test"



\# Désactiver le compte

Disable-ADAccount -Identity "alice.dupont"



\# Réactiver le compte

Enable-ADAccount -Identity "alice.dupont"



\# Supprimer le compte

Remove-ADUser -Identity "alice.dupont" -Confirm:$false

```



<details>



&nbsp; ```powershell









<img src="images/tay.png" alt="Girl in a jacket" width="500" height="600">









```



</details>





0️⃣ utilisateurs3.ps1

```powershell

\# --- Script 1 : Recherche et export des utilisateurs AD ---

param(

&nbsp;   \[string]$domain = "DC300141368-00.local"

)



$cred = Get-Credential -Message "Entrez vos identifiants AD"



Write-Host "Recherche des utilisateurs dont le prénom commence par 'A'..."



Get-ADUser -Filter "GivenName -like 'A\*'" -Properties Name, SamAccountName -Server $domain -Credential $cred |

Select-Object Name, SamAccountName |

Format-Table -AutoSize



Write-Host "Exportation de tous les utilisateurs vers TP\_AD\_Users.csv..."



Get-ADUser -Filter \* -Server $domain -Credential $cred -Properties Name, SamAccountName, EmailAddress, Enabled |

Where-Object { $\_.SamAccountName -notin @('Administrator','Guest','krbtgt') } |

Select-Object Name, SamAccountName, EmailAddress, Enabled |

Export-Csv -Path "TP\_AD\_Users.csv" -NoTypeInformation -Encoding UTF8



Write-Host "Export terminé : fichier 'TP\_AD\_Users.csv' créé."

```



<details>



&nbsp; ```powershell





PS C:\\Users\\Administrator\\Developer\\INF1084-202-25A-04\\4.OUs\\300141368> .\\utilisateurs3.ps1

Recherche des utilisateurs dont le prÃ©nom commence par 'A'...

Exportation de tous les utilisateurs vers TP\_AD\_Users.csv...

Export terminÃ© : fichier 'TP\_AD\_Users.csv' crÃ©Ã©.

PS C:\\Users\\Administrator\\Developer\\INF1084-202-25A-04\\4.OUs\\300141368>





















```



</details>





0️⃣ utilisateurs4.ps1

```powershell

\# Définir le nom de domaine

. .\\bootstrap.ps1

param(

&nbsp;   \[string]$domainDN = "DC=DC300141368-00,DC=local"  # Domaine complet sous forme DN

)



\# Demande des identifiants administratifs

$cred = Get-Credential -Message "Entrez vos identifiants AD"



Write-Host "Vérification de l'existence de l'OU 'Students'..." -ForegroundColor Cyan



\# Vérifie si l’OU existe déjà

$ouExist = Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -ErrorAction SilentlyContinue



if (-not $ouExist) {

&nbsp;   New-ADOrganizationalUnit -Name "Students" -Path $domainDN -Credential $cred

&nbsp;   Write-Host "OU 'Students' créée avec succès." -ForegroundColor Green

} else {

&nbsp;   Write-Host "L'OU 'Students' existe déjà." -ForegroundColor Yellow

}



\# Déplacement de l'utilisateur

Write-Host "Déplacement de l'utilisateur 'Alice Dupont' vers l'OU 'Students'..." -ForegroundColor Cyan



$sourcePath = "CN=Alice Dupont,CN=Users,$domainDN"

$targetPath = "OU=Students,$domainDN"



\# Vérifie si l’utilisateur existe avant le déplacement

$user = Get-ADUser -Filter "SamAccountName -eq 'alice.dupont'" -ErrorAction SilentlyContinue

if ($user) {

&nbsp;   Move-ADObject -Identity $sourcePath -TargetPath $targetPath -Credential $cred

&nbsp;   Write-Host "L'utilisateur 'Alice Dupont' a été déplacé vers 'Students'." -ForegroundColor Green

} else {

&nbsp;   Write-Host "L'utilisateur 'alice.dupont' n'existe pas dans le domaine." -ForegroundColor Red

}



\# Vérification du déplacement

Write-Host "Vérification du déplacement..." -ForegroundColor Cyan

Get-ADUser -Identity "alice.dupont" -Properties DistinguishedName |

Select-Object Name, DistinguishedName

```



<details>



&nbsp; ```powershell



PS C:\\Users\\Administrator\\Developer\\INF1084-202-25A-04\\4.OUs\\300141368> .\\utilisateurs4.ps1

VÃ©rification de l'existence de l'OU 'Students'...

L'OU 'Students' existe dÃ©jÃ .

DÃ©placement de l'utilisateur 'Alice Dupont' vers l'OU 'Students'...

L'utilisateur 'alice.dupont' n'existe pas dans le domaine.

VÃ©rification du dÃ©placement...





```



</details>

