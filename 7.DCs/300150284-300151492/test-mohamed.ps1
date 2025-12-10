$domaineMohamed = "DC300150284-00.local"
$ipMohamed = "10.7.236.228"

Write-Host "=== Test d'accès au domaine de Mohamed ===" -ForegroundColor Cyan

$credMohamed = Get-Credential -Message "Credentials Admin de Mohamed"

Write-Host "`nTest connexion..." -ForegroundColor Yellow
try {
    $domain = Get-ADDomain -Server $ipMohamed -Credential $credMohamed -ErrorAction Stop
    Write-Host "✅ Connexion réussie !" -ForegroundColor Green
    Write-Host "   Domaine: $($domain.Name)" -ForegroundColor Gray
    Write-Host "   Forêt: $($domain.Forest)" -ForegroundColor Gray
} catch {
    Write-Host "❌ Erreur: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`nListe des utilisateurs de Mohamed:" -ForegroundColor Yellow
try {
    $users = Get-ADUser -Filter * -Server $ipMohamed -Credential $credMohamed -ErrorAction Stop
    $users | Select-Object Name, SamAccountName | Format-Table -AutoSize
    Write-Host "✅ Accès aux utilisateurs réussi ! ($($users.Count) utilisateurs)" -ForegroundColor Green
} catch {
    Write-Host "❌ Erreur: $($_.Exception.Message)" -ForegroundColor Red
}