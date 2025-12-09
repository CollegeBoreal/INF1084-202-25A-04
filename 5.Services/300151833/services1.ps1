# Auteur : 300151833

############################
# Étape 1 : Services liés à Active Directory
############################

# Motifs utilisés pour identifier les services AD
$adPatterns = @(
    'Directory',
    'NTDS',
    'ADWS',
    'DFSR',
    'kdc',
    'Netlogon',
    'IsmServ'
)

# Récupère tous les services via CIM et filtre ceux qui matchent un des motifs
Get-CimInstance -ClassName Win32_Service |
    Where-Object {
        $isMatch = $false
        foreach ($p in $adPatterns) {
            if ($_.Name -like "*$p*" -or $_.DisplayName -like "*$p*") {
                $isMatch = $true
                break
            }
        }
        $isMatch
    } |
    Sort-Object -Property DisplayName |
    Select-Object Name, DisplayName, State, StartMode


############################
# Étape 2 : Vérifier certains services AD critiques
############################

$criticalAdServices = @('NTDS', 'ADWS', 'DFSR')

$criticalAdServices |
    ForEach-Object {
        Get-Service -Name $_ -ErrorAction SilentlyContinue |
            Select-Object Name, Status, StartType
    }
# Auteur : raouf bouras

# Phase 1 : Afficher les services en lien avec Active Directory
Get-Service | Where-Object {
    ($_.DisplayName -like "*Directory*") -or 
    ($_.Name -match "ADWS|NTDS|DFSR|Netlogon|kdc|IsmServ")
} | Sort-Object -Property Name

# Phase 2 : Contrôle de l’état des services AD critiques
$adCoreServices = "NTDS","ADWS","DFSR"
Get-Service -Name $adCoreServices
