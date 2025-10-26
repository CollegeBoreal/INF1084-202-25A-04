# ========================================
# TP Active Directory - Partie 2
# Création et Modification d'utilisateurs
# ========================================

# ÉTAPE 3 : Créer un nouvel utilisateur si inexistant
if (-not (Get-ADUser -Filter {SamAccountName -eq "alice.dupont"} -Server $domainName)) {

    New-ADUser -Name "Alice Dupont" `
        -GivenName "Alice" `
        -Surname "Dupont" `
        -SamAccountName "alice.dupont" `
        -UserPrincipalName "alice.dupont@$domainName" `
        -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
        -Enabled $true `
        -Path "CN=Users,DC=$netbiosName,DC=local" `
        -Server $domainName

    Write-Host "Utilisateur 'Alice Dupont' créé avec succès."
}
else {
    Write-Host "⚠️ L'utilisateur 'Alice Dupont' existe déjà. Aucune création effectuée."
}

# ÉTAPE 4 : Modifier l'utilisateur
Set-ADUser -Identity "alice.dupont" `
    -Server $domainName `
    -EmailAddress "alice.dupont@exemple.com" `
    -GivenName "Alice-Marie"

Write-Host "✅ Informations de 'Alice Dupont' mises à jour."

