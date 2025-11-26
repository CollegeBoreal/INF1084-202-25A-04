<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>README TP AD</title>
</head>
<body>

<h1>TP Active Directory – Vérifications Inter-Domaines</h1>
<h3>Étudiant : Ismail Trache (300150395)</h3>
<h3>Cours : INF1084 – Administration Windows Server</h3>

<h2>1. Vérifier la connectivité</h2>
<p>Test Ping et résolution DNS :</p>
<img src="0.png" width="600"><br>
<img src="1.png" width="600"><br>
<img src="2.png" width="600"><br>

<h2>2. Vérification du domaine distant</h2>
<img src="3.png" width="600"><br>

<h2>3. Navigation dans l’AD du domaine distant</h2>
<img src="4.png" width="600"><br>
<img src="5.png" width="600"><br>

<h2>4. Script PowerShell d’automatisation</h2>
<pre>
param(
    [string]$RemoteDomainFqdn = "DC300150295-00.local",
    [string]$RemoteDC = "DC300150295-00"
)

Write-Host "=== 1) Vérifier la connectivité ==="
Test-Connection -ComputerName $RemoteDC -Count 2

Write-Host "`n=== 2) Infos domaine distant ==="
$credAD2 = Get-Credential -Message "Admin du domaine distant"
Get-ADDomain -Server $RemoteDomainFqdn -Credential $credAD2

Write-Host "`n=== 3) Navigation dans l'AD distant (PSDrive AD2:\) ==="
New-PSDrive `
    -Name AD2 `
    -PSProvider ActiveDirectory `
    -Root "DC=$($RemoteDomainFqdn.Split('.')[0]),DC=local" `
    -Server $RemoteDC `
    -Credential $credAD2 `
    -ErrorAction Stop

Set-Location AD2:\
Get-ChildItem

Set-Location C:\

Write-Host "`n=== Fin du script de vérification ==="
</pre>

</body>
</html>
