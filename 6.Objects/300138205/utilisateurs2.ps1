Import-Module GroupPolicy

$OUName = "Students"
$domainDN = (Get-ADDomain).DistinguishedName
$TargetOU = "OU=Students,$domainDN"   # <- DN exact

# Vérifier OU
if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=$OUName)" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $OUName -Path $domainDN
    Write-Host "OU '$OUName' créée."
} else {
    Write-Host "OU '$OUName' existe déjà."
}

$GPOName = "MapSharedFolder"

# Créer GPO si elle n'existe pas
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName | Out-Null
    Write-Host "GPO '$GPOName' créée."
} else {
    Write-Host "GPO '$GPOName' déjà existante."
}

# Vérifier si la GPO est déjà liée
$ExistingLinks = (Get-GPInheritance -Target $TargetOU).GpoLinks
$AlreadyLinked = $ExistingLinks | Where-Object { $_.DisplayName -eq $GPOName }

if ($AlreadyLinked) {
    Write-Host "GPO '$GPOName' déjà liée à l'OU '$TargetOU'."
} else {
    New-GPLink -Name $GPOName -Target $TargetOU
    Write-Host "GPO '$GPOName' liée à l'OU '$TargetOU'."
}


