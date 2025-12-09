# ========================================
# TP Active Directory - Partie 4
# Gestion des OU
# ========================================

. .\bootstrap.ps1   # Dot sourcing du bootstrap

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Verifier si l'OU existe
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -Server $domainName -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=$netbiosName,DC=local" -Server $domainName
}

# Verifier si l'utilisateur existe
$user = Get-ADUser -Filter {SamAccountName -eq "alice.dupont"} -Server $domainName -ErrorAction SilentlyContinue

if ($null -eq $user) {
    Write-Host "`nERREUR : L'utilisateur 'alice.dupont' n'existe pas." -ForegroundColor Red
    Write-Host "   Il a ete SUPPRIME a l'ETAPE 7 dans utilisateurs3.ps1" -ForegroundColor Yellow
    Write-Host "  Executez d'abord : .\utilisateurs2.ps1 pour le recreer`n" -ForegroundColor Cyan
} else {
    # Deplacer l'utilisateur depuis CN=Users
    Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=$netbiosName,DC=local" `
                  -TargetPath "OU=Students,DC=$netbiosName,DC=local" `
                  -Server $domainName
    
    # Verifier le deplacement
    Get-ADUser -Identity "alice.dupont" -Server $domainName | Select-Object Name, DistinguishedName
}