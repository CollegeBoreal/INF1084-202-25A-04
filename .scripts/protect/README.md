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


