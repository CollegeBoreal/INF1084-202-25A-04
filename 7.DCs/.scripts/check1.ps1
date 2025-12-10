function Safe-DnsLookup {
    param(
        [string]$FQDN,
        [int]$TimeoutSec = 2
    )

    try {
        # Lancer nslookup et capturer la sortie
        $p = Start-Process -FilePath "nslookup.exe" -ArgumentList $FQDN -NoNewWindow -RedirectStandardOutput "stdout.txt" -PassThru

        # Attendre un timeout
        if ($p.WaitForExit($TimeoutSec * 1000)) {
            # Lire le résultat
            $out = Get-Content "stdout.txt" -Raw
            if ($out -match "Address:\s+(\d{1,3}(\.\d{1,3}){3})") {
                return $matches[1]
            }
        } else {
            # Timeout expiré
            $p.Kill()
        }
    } catch {}
    return $null
}

# Exemple
$FQDN = "netbios.raoufbr.me"
$ip = Safe-DnsLookup $FQDN 2
if ($ip) {
    Write-Host "A-record trouvé : $ip"
} else {
    Write-Host "Échec DNS ou timeout"
}
