<<<<<<< HEAD
#  Laboratoire Active Directory Domain Services (AD DS)

**Auteur :** 300150385  
**Système :** Windows Server 2022  
**Objectif :** Installer et configurer un contrôleur de domaine Active Directory avec DNS intégré.

---

##  Installation du contrôleur de domaine

```powershell
Install-ADDSForest `
    -DomainName "DC300150385-00.local" `
    -DomainNetbiosName "DC300150385-00" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "Infra@2024" -AsPlainText -Force) `
    -Force
=======
# INF1084-202-25A-04
INF1084 (202) - Introduction à l'administration des systèmes

## :date: [Épreuves](.epreuves)

## :one: [Devoirs](Devoirs)

|:hash:   | Date  | Participations                                                   | Verifications                      |
|---------|-------|:-----------------------------------------------------------------|:-----------------------------------|
| :one:   |08-sept| [0.PlanDeCours](0.PlanDeCours/.scripts/Participation.md)         |
| :two:   |15-sept| [0.Tutoriel sur GIT](.scripts/Participation.md)                  |
| :three: |22-sept| [1.SSH](1.SSH/.scripts/Participation.md)                         |
| :four:  |29-sept| [2.Utilisateurs](2.Utilisateurs/.scripts/Participation.md)       |
| :five:  |06-oct | [3.VMs](3.VMs/.scripts/Participation.md)                         | [3.VMs](3.VMs/.scripts/Check.md)
| :six:   |13-oct | [4.OUs](4.OUs/.scripts/Participation.md)                         |


# :books: References

- [ ] Comment vérifier que le `commit` a été fait par le `CLI`
      
`git log --format=fuller -- `:id:`.md`
>>>>>>> 20ab7105c523042867af0f1b82ce577585d6ab05
