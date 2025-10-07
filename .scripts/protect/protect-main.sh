#!/usr/bin/env bash
# Usage: ./protect-main.sh <OWNER> <REPO> <TA_TEAM>
# Example: ./protect-main.sh collegeboreal INF1084-202-25A-04 lab-assistants

OWNER=$1
REPO=$2
TA_TEAM=$3

if [[ -z "$OWNER" || -z "$REPO" || -z "$TA_TEAM" ]]; then
  echo "Usage: $0 <OWNER> <REPO> <TA_TEAM>"
  exit 1
fi

echo "🔒 Protecting main branch in $OWNER/$REPO ..."

gh api \
  --method PUT \
  repos/$OWNER/$REPO/branches/main/protection \
  --input <(cat <<EOF
{
  "required_status_checks": {
    "strict": true,
    "contexts": []
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "required_approving_review_count": 1
  },
  "restrictions": {
    "users": [],
    "teams": ["$TA_TEAM"],
    "apps": []
  }
}
EOF
)

echo "✅ main branch protected. Only team $TA_TEAM can push/merge."

