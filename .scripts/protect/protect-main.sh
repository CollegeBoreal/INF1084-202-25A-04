#!/usr/bin/env bash
set -e

OWNER=$1
REPO=$2
TA_TEAM=$3

if [[ -z "$OWNER" || -z "$REPO" || -z "$TA_TEAM" ]]; then
  echo "Usage: $0 <OWNER> <REPO> <TA_TEAM>"
  exit 1
fi

echo "🔹 Setting up repo $OWNER/$REPO ..."

# 1️⃣ Ensure TA team has repo access (push/admin)
echo "→ Granting $TA_TEAM push access to the repo..."
gh api \
  -X PUT \
  orgs/$OWNER/teams/$TA_TEAM/repos/$OWNER/$REPO \
  -f permission="push" >/dev/null || true

# 2️⃣ Protect main branch (empty restrictions first — required by Enterprise)
echo "→ Protecting main branch..."
gh api \
  -X PUT \
  repos/$OWNER/$REPO/branches/main/protection \
  --input <(cat <<EOF
{
  "required_status_checks": null,
  "required_pull_request_reviews": null,
  "enforce_admins": true,
  "restrictions": {
    "users": [],
    "teams": [],
    "apps": []
  }
}
EOF
)

# 3️⃣ Apply branch restriction for TA team
echo "→ Restricting push to main for $TA_TEAM..."
gh api \
  -X PUT \
  repos/$OWNER/$REPO/branches/main/protection/restrictions/teams \
  --input <(cat <<EOF
{
  "teams": ["$TA_TEAM"]
}
EOF
)

# 4️⃣ Verification
echo "→ Verifying branch protection..."
gh api repos/$OWNER/$REPO/branches/main/protection/restrictions \
  --jq '{teams:[.teams[].slug], users:[.users[].login]}'

echo "✅ Repo $OWNER/$REPO setup complete."
echo "Only team $TA_TEAM can push to main."
echo "Students should push to their own branches (300xxxxxx)."

