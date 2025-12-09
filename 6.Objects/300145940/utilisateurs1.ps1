# 300145940 Tasnim Marzougui

# Dossier et partage à créer
$shareRoot   = 'C:\SharedResources'
$shareName   = 'SharedResources'
$adGroupName = 'Students'

# 1. Création du dossier si nécessaire
if (-not (Test-Path -Path $shareRoot -PathType Container)) {
    New-Item -Path $shareRoot -ItemType Directory | Out-Null
}

# 2. Création du groupe AD si absent
$existingGroup = Get-ADGroup -LDAPFilter "(cn=$adGroupName)" -ErrorAction SilentlyContinue
if (-not $existingGroup) {
    New-ADGroup -Name $adGroupName `
                -GroupScope Global `
                -Description 'Users allowed RDP and shared folder access' | Out-Null
}

# 3. Création des utilisateurs et ajout au groupe
$userList = @('Etudiant1','Etudiant2')
$securePwd = ConvertTo-SecureString 'Pass123!' -AsPlainText -Force

foreach ($u in $userList) {
    $adUser = Get-ADUser -Filter "SamAccountName -eq '$u'" -ErrorAction SilentlyContinue
    if (-not $adUser) {
        $userParams = @{
            Name            = $u
            SamAccountName  = $u
            AccountPassword = $securePwd
            Enabled         = $true
        }
        New-ADUser @userParams
        Add-ADGroupMember -Identity $adGroupName -Members $u
    }
}

# 4. Création du partage SMB si inexistant
$share = Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue
if (-not $share) {
    New-SmbShare -Name $shareName -Path $shareRoot -FullAccess $adGroupName | Out-Null
}

