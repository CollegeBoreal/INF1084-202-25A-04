# ============================================
# 1. CRÉATION DE LA STRUCTURE DES OUs
# Étudiant: Lounas Allouti
# ID: 300150295
# ============================================
. "$PSScriptRoot\bootstrap.ps1"

Write-Host "=== Création des OUs ===" -ForegroundColor Cyan

$rootOU = "OU=300150295,DC=DC300150295-00,DC=local"

New-ADOrganizationalUnit -Name "300150295" -Path "DC=DC300150295-00,DC=local" -ErrorAction SilentlyContinue
New-ADOrganizationalUnit -Name "Employes" -Path $rootOU -ErrorAction SilentlyContinue
New-ADOrganizationalUnit -Name "Ordinateurs" -Path $rootOU -ErrorAction SilentlyContinue
New-ADOrganizationalUnit -Name "Groupes" -Path $rootOU -ErrorAction SilentlyContinue

Get-ADOrganizationalUnit -Filter "Name -like '*300150295*'" | Format-Table Name,DistinguishedName
