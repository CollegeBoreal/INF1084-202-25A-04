# =======================================================================
# trust2.ps1
# Create and verify trust from AD2 -> AD1
# =======================================================================

# Load bootstrap variables
. .\bootstrap.ps1

Write-Host "=== TRUST SCRIPT AD2 ===" -ForegroundColor Cyan

# -----------------------------
# 1. Connectivity test
# -----------------------------
Write-Host "`n[TEST] Connectivity AD2 -> AD1" -ForegroundColor Yellow
Test-Connection -ComputerName $DC1 -Count 2

# -----------------------------
# 2. Attempt trust creation
# -----------------------------
Write-Host "`n[TRUST] Creating trust AD2 -> AD1..." -ForegroundColor Yellow

netdom trust $domainName2 `
 /Domain:$domainName1 `
 /UserD:Administrator `
 /PasswordD:$plain1 `
 /UserO:Administrator `
 /PasswordO:$plain2 `
 /Add `
 /Twoway

# -----------------------------
# 3. Verify trust
# -----------------------------
Write-Host "`n[VERIFY] Trust verification AD2 -> AD1..." -ForegroundColor Yellow

netdom trust $domainName2 `
 /Domain:$domainName1 `
 /Verify `
 /UserO:Administrator `
 /PasswordO:$plain2

# -----------------------------
# 4. Query AD1 from AD2
# -----------------------------
Write-Host "`n[AD QUERY] Querying AD1 from AD2" -ForegroundColor Yellow

Get-ADDomain -Server $DC1 -Credential $cred1
Get-ADUser -Filter * -Server $DC1 -Credential $cred1 -ResultSetSize 5 |
    Select SamAccountName, Name

Write-Host "`n=== TRUST SCRIPT AD2 COMPLETED ===" -ForegroundColor Green
