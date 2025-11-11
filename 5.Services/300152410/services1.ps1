# TP Services AD - Boudeuf Imad 300152410
# Vérification de l’état des services Active Directory

Get-Service -Name ADWS, NTDS, DNS, DFSR | Select-Object Name, Status, StartType
