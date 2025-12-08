$SharedFolder = "C:\SharedResources"
$GroupName = "Students"
$Users = @("Etudiant1","Etudiant2")

New-Item -Path $SharedFolder -ItemType Directory -Force

New-ADGroup -Name $GroupName -GroupScope Global -Description "Accès au partage SMB + RDP"

foreach ($user in $Users) {
    New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity $GroupName -Members $user
}

New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

icacls C:\SharedResources /grant "Students:(OI)(CI)F" /T
