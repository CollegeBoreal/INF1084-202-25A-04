# ============================
# utilisateurs4.ps1
# Créer OU Students + déplacer utilisateur (Sara Benali)
# ============================

. "$PSScriptRoot\bootstrap.ps1"

Write-Host "`n=== 8) Vérification / création de l'OU Students ===`n"

$ou = Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -Server $domainName -ErrorAction SilentlyContinue

if (-not $ou) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local" -Credential $cred
    Write-Host "OU 'Students' créée."
} else {
    Write-Host "OU 'Students' existe déjà."
}

Write-Host "`n=== 9) Déplacement de Sara Benali vers l'OU Students ===`n"

$SaraDN = "CN=Sara Benali,CN=Users,DC=$netbiosName,DC=local"
$targetOU = "OU=Students,DC=$netbiosName,DC=local"

Move-ADObject -Identity $SaraDN -TargetPath $targetOU -Credential $cred

Write-Host "Sara Benali déplacée dans l'OU Students."

Write-Host "`n=== 10) Vérification du DN ===`n"
Get-ADUser -Identity "sara.benali" | Select-Object Name, DistinguishedName

