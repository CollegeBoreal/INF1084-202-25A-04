# === Vos informations et sécurité ===
# Remplace le mot de passe ci-dessous par celui de 'Administrator' si différent
   = 300151608
 = 0

  = "DC-.local"   # DC300151608-0.local
 = "DC-"         # DC300151608-0

# Mot de passe admin (exemple) - remplace si besoin
  = 'Infra@2024'
 = ConvertTo-SecureString  -AsPlainText -Force
   = New-Object System.Management.Automation.PSCredential("Administrator@", )
