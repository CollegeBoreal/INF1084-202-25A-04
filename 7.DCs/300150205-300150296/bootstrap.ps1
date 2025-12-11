# =======================================================================
# bootstrap.ps1
# =======================================================================

Write-Host "[BOOTSTRAP] Loading configuration..." -ForegroundColor Cyan

# -----------------------------
# AD1 information
# -----------------------------
$studentNumber1   = "300150205"
$studentInstance1 = "00"

$domainName1  = "DC$studentNumber1-$studentInstance1.local"
$netbiosName1 = "DC$studentNumber1-$studentInstance1"

# Credentials for AD1
$plain1  = "Infra@2024"
$secure1 = ConvertTo-SecureString $plain1 -AsPlainText -Force
$cred1   = New-Object System.Management.Automation.PSCredential("Administrator@$domainName1", $secure1)

# -----------------------------
# AD2 information (partner)
# -----------------------------
$studentNumber2   = "300150296"
$studentInstance2 = "00"

$domainName2  = "DC$studentNumber2-$studentInstance2.local"
$netbiosName2 = "DC$studentNumber2-$studentInstance2"

# Credentials for AD2
$plain2  = "Infra@2024"
$secure2 = ConvertTo-SecureString $plain2 -AsPlainText -Force
$cred2   = New-Object System.Management.Automation.PSCredential("Administrator@$domainName2", $secure2)

# -----------------------------
# Domain controllers (FQDN autodetect)
# -----------------------------
$DC1 = [System.Net.Dns]::GetHostByName($env:COMPUTERNAME).HostName
$DC2 = "$($netbiosName2).$($domainName2)"

Write-Host "[BOOTSTRAP] domainName1 = $domainName1"
Write-Host "[BOOTSTRAP] domainName2 = $domainName2"
Write-Host "[BOOTSTRAP] DC1 = $DC1"
Write-Host "[BOOTSTRAP] DC2 = $DC2"
