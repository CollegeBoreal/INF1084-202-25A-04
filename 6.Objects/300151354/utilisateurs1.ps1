# ==============================
# utilisateurs1.ps1
# Creation du dossier partage + groupe Students + utilisateurs
# ==============================

. "$PSScriptRoot\bootstrap.ps1"

Write-Host "`n=== Creation du dossier partage ===`n"

$SharedFolder = "C:\SharedResources"

if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force
    Write-Host "Dossier cree : $SharedFolder"
} else {
    Write-Host "Dossier deja existant : $SharedFolder"
}

# ==============================
# Groupe Students
# ==============================

Write-Host "`n=== Verification / creation du groupe Students ===`n"

$GroupName = "Students"
$group = Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue

if ($group) {
    Write-Host "Le groupe '$GroupName' existe deja."
} else {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access" -Credential $cred
    Write-Host "Groupe '$GroupName' cree."
}

# ==============================
# Creation des utilisateurs
# ==============================

Write-Host "`n=== Creation des utilisateurs AD ===`n"

$Users = @("Etudiant1", "Etudiant2")

foreach ($user in $Users) {

    # Verifier si l'utilisateur existe
    $u = Get-ADUser -Filter "SamAccountName -eq '$user'" -ErrorAction SilentlyContinue

    if ($u) {
        Write-Host "Utilisateur deja existant : $user"
    } else {
        New-ADUser -Name $user `
                   -SamAccountName $user `
                   -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
                   -Enabled $true `
                   -Credential $cred

        Write-Host "Utilisateur cree : $user"
    }

    # Ajouter au groupe si pas membre
    $isMember = Get-ADGroupMember -Identity $GroupName | Where-Object { $_.SamAccountName -eq $user }

    if (-not $isMember) {
        Add-ADGroupMember -Identity $GroupName -Members $user -Credential $cred
        Write-Host "Utilisateur ajoute au groupe : $user"
    } else {
        Write-Host "Utilisateur deja dans le groupe : $user"
    }
}

# ==============================
# Partage SMB
# ==============================

Write-Host "`n=== Creation du partage SMB ===`n"

$shareExists = Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue

if ($shareExists) {
    Write-Host "Le partage SMB existe deja."
} else {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
    Write-Host "Partage SMB cree : \\$netbiosName\SharedResources"
}

Write-Host "`n=== Script termine sans erreur ===`n"

