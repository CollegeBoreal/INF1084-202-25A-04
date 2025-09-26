# =====================================================
# Hocine4.ps1 - Export et Import des utilisateurs
# =====================================================

. .\Hocine1.ps1

$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation -Encoding UTF8
Write-Output "✅ Utilisateurs exportés vers C:\Temp\UsersSimules.csv"

$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

$Groups = @{}
$Groups["ImportGroupe"] = @()
$Groups["ImportGroupe"] += $ImportedUsers

Write-Output "=== ImportGroupe ==="
$Groups["ImportGroupe"] | ForEach-Object {
    Write-Output "- $($.Prenom) $($.Nom) ($($_.Login))"
}

