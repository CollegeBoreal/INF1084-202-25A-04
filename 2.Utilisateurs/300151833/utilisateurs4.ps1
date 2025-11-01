$Users = @(   
    [PSCustomObject]@{ Nom="Dupont"; Prenom="Alice"; OU="Stagiaires" }  
    [PSCustomObject]@{ Nom="Diaks"; Prenom="rahima"; OU="Professeurs" } 
    [PSCustomObject]@{ Nom="malembe"; Prenom="driss"; OU="Stagiaires" }
)

if (-not (Test-Path -Path "C:\Temp")) { 
   New-Item -ItemType Directory -Path "C:\Temp" | Out-Null
}

$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation -Encoding UTF8

$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

Write-Host "Utilisateurs importés depuis le CSV :" -ForegroundColor Cyan

$ImportedUsers | Format-Table -AutoSize
