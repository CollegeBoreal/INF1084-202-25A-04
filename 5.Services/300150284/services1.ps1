# Auteur : 300150284
# TP Services 1
# Rechercher un service par nom

param(
    [Parameter(Mandatory=$true)]
    [string]$ServiceName
)

Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
