# voici la commande de l’installations
Install-WindowsFeature AD-Domain-Services –IncludeManagementTools

<img width="797" height="228" alt="Vm2 png" src="https://github.com/user-attachments/assets/c6e8921c-4a98-4c61-bfea-202b43ad0f1f" />


--------------------------------

```powershell
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...
```

-----------------------
# verification de l'installations
<img width="1305" height="702" alt="Vm1 png" src="https://github.com/user-attachments/assets/cbf4589c-a49a-4c96-9275-80a27366af57" />

```
Get-ADDomain
Get-ADForest
```


