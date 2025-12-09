PS C:\Users\Administrator\Developer\INF1084-202-25A-04\7.DCs\300151042-300151608> New-PSDrive -Name AD2 `
>>             -PSProvider ActiveDirectory `
>>             -Root "DC=dc300151608,DC=local" `
>>             -Server "DC300151608.dc300151608.local" `
>>             -Credential $credAD2

Name           Used (GB)     Free (GB) Provider      Root                                                                                   CurrentLocation
----           ---------     --------- --------      ----                                                                                   ---------------
AD2                                    ActiveDire... //RootDSE/DC=dc300151608,DC=local


PS C:\Users\Administrator\Developer\INF1084-202-25A-04\7.DCs\300151042-300151608>
PS C:\Users\Administrator\Developer\INF1084-202-25A-04\7.DCs\300151042-300151608> # Se déplacer dans AD2
PS C:\Users\Administrator\Developer\INF1084-202-25A-04\7.DCs\300151042-300151608> Set-Location AD2:\
PS AD2:\>
PS AD2:\> # Lister les OU de AD2
PS AD2:\> Get-ChildItem

Name                 ObjectClass          DistinguishedName
----                 -----------          -----------------
Builtin              builtinDomain        CN=Builtin,DC=dc300151608,DC=local
Computers            container            CN=Computers,DC=dc300151608,DC=local
Domain Controllers   organizationalUnit   OU=Domain Controllers,DC=dc300151608,DC=local
ForeignSecurityPr... container            CN=ForeignSecurityPrincipals,DC=dc300151608,DC=local
Infrastructure       infrastructureUpdate CN=Infrastructure,DC=dc300151608,DC=local
Keys                 container            CN=Keys,DC=dc300151608,DC=local
LostAndFound         lostAndFound         CN=LostAndFound,DC=dc300151608,DC=local
Managed Service A... container            CN=Managed Service Accounts,DC=dc300151608,DC=local
NTDS Quotas          msDS-QuotaContainer  CN=NTDS Quotas,DC=dc300151608,DC=local
Program Data         container            CN=Program Data,DC=dc300151608,DC=local
Students             organizationalUnit   OU=Students,DC=dc300151608,DC=local
System               container            CN=System,DC=dc300151608,DC=local
TPM Devices          msTPM-Information... CN=TPM Devices,DC=dc300151608,DC=local
Users                container            CN=Users,DC=dc300151608,DC=local