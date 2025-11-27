Import-Module ActiveDirectory

$SharedFolder = "C:\SharedResources"

New-Item -Path $SharedFolder -ItemType Directory -Force

$GroupName = "Students"

New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access" -ErrorAction SilentlyContinue

$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    Add-ADGroupMember -Identity $GroupName -Members $user
}

New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
