# Script pour corriger la participation AD sur GitHub
# Auteur : Fetis Nadir
# Étudiant : 300150485

# -----------------------------
# 1️⃣ Définir les chemins
$studentID = "300150485"
$repoPath = "$env:USERPROFILE\Documents\GitHub\INF1084-202-25A-04"
$sourceReadme = Join-Path $repoPath "1.SSH\$studentID\README.md"
$targetFolder = Join-Path $repoPath "2.Utilisateurs\$studentID"
$targetReadme = Join-Path $targetFolder "README.md"

# -----------------------------
# 2️⃣ Créer le dossier étudiant si nécessaire
if (-not (Test-Path $targetFolder)) {
    New-Item -Path $targetFolder -ItemType Directory | Out-Null
    Write-Host "✅ Dossier $studentID créé dans 2.Utilisateurs"
} else {
    Write-Host "ℹ️ Dossier $studentID existe déjà dans 2.Utilisateurs"
}

# -----------------------------
# 3️⃣ Déplacer le README.md
if (Test-Path $sourceReadme) {
    Move-Item -Path $sourceReadme -Destination $targetReadme -Force
    Write-Host "✅ README.md déplacé dans 2.Utilisateurs/$studentID"
} else {
    Write-Host "⚠️ README.md source introuvable dans 1.SSH/$studentID"
    exit
}

# -----------------------------
# 4️⃣ Git add, commit et push
cd $repoPath

git add "2.Utilisateurs/$studentID/README.md"
git commit -m "Déplacement du README dans 2.Utilisateurs pour participation AD"
git push origin main

Write-Host "🚀 Participation soumise sur GitHub avec succès !"
