#!/usr/bin/env pwsh
# Run participation.ps1 and redirect output to Participation.md, discard errors

pwsh .scripts/participation.ps1 > .scripts/Participation.md 2>$null

