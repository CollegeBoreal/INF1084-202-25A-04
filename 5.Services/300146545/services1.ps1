 Lister tous les services liés à AD:
PS C:\Users\Administrator\Developer\INF1084-202-25A-04\5.Services\300146545> Get-Service | Where-Object {
>>    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
>> } | Sort-Object DisplayName

Status   Name               DisplayName
------   ----               -----------
Running  NTDS               Active Directory Domain Services
Running  ADWS               Active Directory Web Services
Running  DFSR               DFS Replication
Running  IsmServ            Intersite Messaging
Running  Kdc                Kerberos Key Distribution Center
Running  Netlogon           Netlogon


# Vérifier l’état d’un service spécifique:
PS C:\Users\Administrator\Developer\INF1084-202-25A-04\5.Services\300146545> Get-Service -Name NTDS, ADWS, DFSR

Status   Name               DisplayName
------   ----               -----------
Running  ADWS               Active Directory Web Services
Running  DFSR               DFS Replication
Running  NTDS               Active Directory Domain Services
