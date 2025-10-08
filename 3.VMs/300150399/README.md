# 300150399


```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

<details>
  
```powershell
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...
```

</details>

```powershell
PS C:\Users\Administrator> Get-ADDomain
```
```powershell
PS C:\Users\Administrator> Get-ADForest
```

