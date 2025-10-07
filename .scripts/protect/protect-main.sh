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

