# =======================================================================
# trust1.ps1
# Create and verify trust from AD1 -> AD2
# =======================================================================

# Load bootstrap variables
. .\bootstrap.ps1

Write-Host "=== TRUST SCRIPT AD1 ===" -ForegroundColor Cyan

# -----------------------------
# 1. Connectivity test
# -----------------------------
Write-Host "`n[TEST] Connectivity AD1 -> AD2" -ForegroundColor Yellow
Test-Connection -ComputerName $DC2 -Count 2

# -----------------------------
# 2. Attempt trust creation
# -----------------------------
Write-Host "`n[TRUST] Creating trust AD1 -> AD2..." -ForegroundColor Yellow

netdom trust $domainName1 `
 /Domain:$domainName2 `
 /UserD:Administrator `
 /PasswordD:$plain2 `
 /UserO:Administrator `
 /PasswordO:$plain1 `
 /Add `
 /Twoway

# -----------------------------
# 3. Verify trust
# -----------------------------
Write-Host "`n[VERIFY] Trust verification AD1 -> AD2..." -ForegroundColor Yellow

netdom trust $domainName1 `
 /Domain:$domainName2 `
 /Verify `
 /UserO:Administrator `
 /PasswordO:$plain1

# -----------------------------
# 4. Query AD2 from AD1
# -----------------------------
Write-Host "`n[AD QUERY] Querying AD2 from AD1" -ForegroundColor Yellow

Get-ADDomain -Server $DC2 -Credential $cred2
Get-ADUser -Filter * -Server $DC2 -Credential $cred2 -ResultSetSize 5 |
    Select SamAccountName, Name

Write-Host "`n=== TRUST SCRIPT AD1 COMPLETED ===" -ForegroundColor Green
