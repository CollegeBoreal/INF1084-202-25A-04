# TP Active Directory - GPO mappage lecteur Z:
# Etudiant : Abdelatif Nemous (300150417)

# Nom de la GPO
$GPOName  = "MapSharedFolder-300150417"

# Domaine (d'apres ton AD)
$DomainDN = "DC=DC300150417-00,DC=local"
$OUPath   = "OU=Students,$DomainDN"

# 1) Creer l'OU Students si elle n'existe pas
if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=Students)" -SearchBase $DomainDN -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path $DomainDN -ProtectedFromAccidentalDeletion $false
}

# 2) Creer la GPO si elle n'existe pas
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName | Out-Null
}

# 3) Lier la GPO a l'OU Students
New-GPLink -Name $GPOName -Target $OUPath


# 4) Creer le script de logon pour mapper Z:
$ScriptFolder = "C:\Scripts"
$ScriptPath   = Join-Path $ScriptFolder "MapDrive-Z.bat"

if (-not (Test-Path $ScriptFolder)) {
    New-Item -Path $ScriptFolder -ItemType Directory | Out-Null
}

"net use Z: \\DC300150417-00\SharedResources /persistent:no" |
    Set-Content -Path $ScriptPath -Encoding ASCII

# 5) Enregistrer le chemin du script dans la GPO (methode simplifiee du TP)
Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptPath
