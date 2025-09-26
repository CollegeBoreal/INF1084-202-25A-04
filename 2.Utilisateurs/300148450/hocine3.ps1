# hocine3.ps1
# Script PowerShell pour créer un dossier et un fichier à l'intérieur

# Création d'un dossier "TestHocine"
New-Item -Path "C:\Users\Laptop\TestHocine" -ItemType Directory -Force

# Création d'un fichier texte dans ce dossier
New-Item -Path "C:\Users\Laptop\TestHocine\fichier3.txt" -ItemType File -Force

# Ajout d'un texte dans le fichier
Set-Content -Path "C:\Users\Laptop\TestHocine\fichier3.txt" -Value "Ceci est le script hocine3.ps1"

