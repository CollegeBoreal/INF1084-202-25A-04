Automate branch protection using the **GitHub CLI** (`gh`). This way, you don’t need to manually set rules in the web UI.

---

## 1. Install GitHub CLI

If you don’t have it:

```bash
# macOS / Linux
brew install gh

# Ubuntu/Debian
sudo apt install gh

# Windows
winget install --id GitHub.cli
```

Then authenticate:

```bash
gh auth login
```

---

## 2. Protect `main` (block students, only TAs/instructors can push)

```bash
gh api \
  -X PUT \
  repos/<OWNER>/<REPO>/branches/main/protection \
  -F required_status_checks.strict=true \
  -F enforce_admins=true \
  -F required_pull_request_reviews.dismiss_stale_reviews=true \
  -F restrictions.push_restrictions='["<TA_GITHUB_USERNAME>"]'
```

Replace:

* `<OWNER>` → your org or username
* `<REPO>` → repository name
* `<TA_GITHUB_USERNAME>` → the GitHub usernames of instructors/TAs who are allowed to push

👉 This ensures:

* Students can’t push to `main`.
* Only instructors can push or merge via PR.

---

## 3. Allow students to push only to `3*` branches

Unfortunately, GitHub branch protection rules **cannot “allow push only if name matches”** — they only let you **restrict** certain branches.
So the clean approach is:

* Protect `main` (blocked).
* Leave `3*` unprotected (students free to push).

If you want to enforce branch naming more strictly, you can add a **GitHub Action check** that fails if a student pushes to a branch that doesn’t match `3*`. Example:

```yaml
# .github/workflows/enforce-branch.yml
name: Enforce Branch Naming

on:
  push:
    branches:
      - '*'

jobs:
  enforce-branch-name:
    runs-on: ubuntu-latest
    steps:
      - name: Check branch name
        run: |
          if [[ ! "${GITHUB_REF_NAME}" =~ ^3[0-9]{8}$ ]]; then
            echo "❌ Invalid branch name: ${GITHUB_REF_NAME}"
            echo "Branches must be student IDs like 300123456"
            exit 1
          fi
```

👉 With this, if someone pushes to `feature/foo` or `main`, CI fails immediately with a clear message.

---

## 4. Optional: JSON config version

If you want to script it instead of CLI flags:

```bash
gh api \
  -X PUT \
  repos/<OWNER>/<REPO>/branches/main/protection \
  -f '{
    "required_status_checks": { "strict": true, "contexts": [] },
    "enforce_admins": true,
    "required_pull_request_reviews": { "dismiss_stale_reviews": true },
    "restrictions": {
      "users": ["<TA_GITHUB_USERNAME>"],
      "teams": []
    }
  }'
```

---

⚡ Question for you: do you want **one repo shared by all 30 students** (each with their `300xxxxxx` branch), or would you prefer **30 individual repos via GitHub Classroom** (each student gets their own repo, cleaner permissions)?




Perfect 🚀 — here’s a **ready-to-run GitHub CLI script** that sets up your repository so:

* `main` is protected.
* Only instructors/TAs can push to `main`.
* Students (Team **Promo2024**) are blocked from `main` but free to push to their `300xxxxxx` branches.

---

## 1. Script: `protect-main.sh`

```bash
#!/usr/bin/env bash
# Usage: ./protect-main.sh <OWNER> <REPO> <TA_TEAM>
# Example: ./protect-main.sh my-org my-repo TAs

OWNER=$1
REPO=$2
TA_TEAM=$3

if [[ -z "$OWNER" || -z "$REPO" || -z "$TA_TEAM" ]]; then
  echo "Usage: $0 <OWNER> <REPO> <TA_TEAM>"
  exit 1
fi

echo "🔒 Protecting main branch in $OWNER/$REPO ..."
gh api \
  -X PUT \
  repos/$OWNER/$REPO/branches/main/protection \
  -f required_status_checks.strict=true \
  -f enforce_admins=true \
  -f required_pull_request_reviews.dismiss_stale_reviews=true \
  -f required_pull_request_reviews.required_approving_review_count=1 \
  -f restrictions.users='[]' \
  -f restrictions.teams="[\"$TA_TEAM\"]"

echo "✅ main branch protected. Only team $TA_TEAM can push/merge."
```

---

## 2. Run it

```bash
chmod +x protect-main.sh
./protect-main.sh <OWNER> <REPO> TAs
```

Replace:

* `<OWNER>` → your org name (e.g., `UniversityDept`)
* `<REPO>` → the repo students use (e.g., `assignment-1`)
* `TAs` → the GitHub team for instructors (must already exist in your org)

---

## 3. Outcome

* `main` is locked.
* Students in **Promo2024** cannot push to `main`.
* TAs/instructors can push/merge into `main`.
* Students push only to `300xxxxxx` branches → and your Actions workflow runs on those.


