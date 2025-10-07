#!/usr/bin/env bash
set -e

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
  "required_status_checks": null,
  "required_pull_request_reviews": null,
  "enforce_admins": true,
  "restrictions": {
    "users": [],
    "teams": ["$TA_TEAM"],
    "apps": []
  }
}
EOF
)

echo "✅ main branch protected. Only team $TA_TEAM can push/merge."

