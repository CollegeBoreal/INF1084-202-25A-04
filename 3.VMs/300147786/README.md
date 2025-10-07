# 300147786
# Voici la commande: Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

<details>

'''powershell
DisplayName                      Name               InstallState
-----------                      ----               ------------
Active Directory Domain Services AD-Domain-Services    Installed
'''
</details>

# vérification 
<details>
'''powershell


ApplicationPartitions : {DC=DomainDnsZones,DC=DC999999999-00,DC=local, DC=ForestDnsZones,DC=DC999999999-00,DC=local}    CrossForestReferences : {}                                                                                              DomainNamingMaster    : DC300147786.DC999999999-00.local                                                                Domains               : {DC999999999-00.local}                                                                          ForestMode            : Windows2016Forest                                                                               GlobalCatalogs        : {DC300147786.DC999999999-00.local}
Name                  : DC999999999-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC999999999-00,DC=local
RootDomain            : DC999999999-00.local
SchemaMaster          : DC300147786.DC999999999-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}                                                                                              UPNSuffixes           : {} 
</details>
