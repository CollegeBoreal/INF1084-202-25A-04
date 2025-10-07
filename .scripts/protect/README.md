Automate branch protection using the **GitHub CLI** (`gh`). This way, you don’t need to manually set rules in the web UI.

---

## 1. Install GitHub CLI

If you don’t have it:

```bash
# macOS / Linux
brew install gh
```
<details>

```powershell
==> Auto-updating Homebrew...
Adjust how often this is run with `$HOMEBREW_AUTO_UPDATE_SECS` or disable with
`$HOMEBREW_NO_AUTO_UPDATE=1`. Hide these hints with `$HOMEBREW_NO_ENV_HINTS=1` (see `man brew`).
==> Auto-updated Homebrew!
==> Updated Homebrew from 4.6.15 (75e6421a35) to 4.6.16 (3269773003).
Updated 3 taps (azure/functions, homebrew/core and homebrew/cask).
==> New Formulae
airtable-mcp-server: MCP Server for Airtable
archgw: CLI for Arch Gateway
cagent: Agent Builder and Runtime by Docker Engineering
chrome-devtools-mcp: Chrome DevTools for coding agents
cliproxyapi: Wrap Gemini CLI, Codex, Claude Code, Qwen Code as an API service
config-file-validator: CLI tool to validate different configuration file types
container-compose: Manage Apple Container with Docker Compose files
ctrld: Highly configurable, multi-protocol DNS forwarding proxy
dnote: Simple command-line notebook
libptytty: Library for OS-independent pseudo-TTY management
mcp-google-sheets: MCP server integrates with your Google Drive and Google Sheets
mdserve: Fast markdown preview server with live reload and theme support
n8n-mcp: MCP for Claude Desktop, Claude Code, Windsurf, Cursor to build n8n workflows
openblas64: Optimized BLAS library
openssl@3.5: Cryptography and SSL/TLS Toolkit
radvd: IPv6 Router Advertisement Daemon
snooze: Run a command at a particular time
wassette: Security-oriented runtime that runs WebAssembly Components via MCP
yamlresume: Resumes as code in YAML
yuque-dl: Knowledge base downloader for Yuque
==> New Casks
4k-image-compressor: Image compressor
4k-tokkit: Download TikTok videos and accounts
atuin-desktop: Runbook editor for terminal workflows
browseros: Open-source agentic browser
font-kedebideri
font-momo-signature
font-momo-trust-display
font-momo-trust-sans
glide-browser: Extensible, firefox-based web browser
graalvm-jdk@25: GraalVM from Oracle
iaito: GUI for radare2
oracle-jdk-javadoc@25: Documentation for the Oracle JDK
oracle-jdk@25: JDK from Oracle
semeru-jdk-open@25: Production-ready JDK with the OpenJDK class libraries and the Eclipse OpenJ9 JVM
socialstream: Consolidate, control, and customise live social messaging streams
temurin@25: JDK from the Eclipse Foundation (Adoptium)
zulu@25: OpenJDK distribution from Azul

You have 158 outdated formulae and 24 outdated casks installed.


The 4.6.16 changelog can be found at:
  https://github.com/Homebrew/brew/releases/tag/4.6.16
==> Fetching downloads for: gh
==> Downloading https://ghcr.io/v2/homebrew/core/gh/manifests/2.81.0
########################################################################################################### 100.0%
==> Fetching gh
==> Downloading https://ghcr.io/v2/homebrew/core/gh/blobs/sha256:d419fc9cfecf80e6c91bdcb2ee980677c7d7cddecc64d3e5f
########################################################################################################### 100.0%
==> Pouring gh--2.81.0.arm64_sequoia.bottle.tar.gz
🍺  /opt/homebrew/Cellar/gh/2.81.0: 220 files, 51MB
==> Running `brew cleanup gh`...
Disable this behaviour by setting `HOMEBREW_NO_INSTALL_CLEANUP=1`.
Hide these hints with `HOMEBREW_NO_ENV_HINTS=1` (see `man brew`).
==> `brew cleanup` has not been run in the last 30 days, running now...
Disable this behaviour by setting `HOMEBREW_NO_INSTALL_CLEANUP=1`.
Hide these hints with `HOMEBREW_NO_ENV_HINTS=1` (see `man brew`).
Removing: /Users/valiha/Library/Caches/Homebrew/azure-cli_bottle_manifest--2.73.0... (28.3KB)
Removing: /Users/valiha/Library/Caches/Homebrew/azure-cli--2.73.0... (40.6MB)
Removing: /Users/valiha/Library/Caches/Homebrew/binutils_bottle_manifest--2.44... (41.5KB)
Removing: /Users/valiha/Library/Caches/Homebrew/binutils--2.44... (54.9MB)
Removing: /opt/homebrew/Cellar/ca-certificates/2025-02-25... (4 files, 235.9KB)
Removing: /opt/homebrew/Cellar/ca-certificates/2025-05-20... (4 files, 225.8KB)
Removing: /Users/valiha/Library/Caches/Homebrew/ca-certificates_bottle_manifest--2025-05-20... (2.0KB)
Removing: /Users/valiha/Library/Caches/Homebrew/ca-certificates--2025-05-20... (126.4KB)
Removing: /opt/homebrew/Cellar/capstone/5.0.3... (31 files, 22.4MB)
Removing: /opt/homebrew/Cellar/capstone/5.0.5... (31 files, 22.4MB)
Removing: /Users/valiha/Library/Caches/Homebrew/certifi_bottle_manifest--2025.4.26... (2.2KB)
Removing: /Users/valiha/Library/Caches/Homebrew/certifi--2025.4.26... (5.2KB)
Removing: /Users/valiha/Library/Caches/Homebrew/dfu-util_bottle_manifest--0.11... (17.5KB)
Removing: /Users/valiha/Library/Caches/Homebrew/dfu-util--0.11... (54.4KB)
Removing: /opt/homebrew/Cellar/gettext/0.24... (2,189 files, 19.9MB)
Removing: /opt/homebrew/Cellar/gettext/0.25... (2,418 files, 27.7MB)
Removing: /Users/valiha/Library/Caches/Homebrew/gettext_bottle_manifest--0.25... (14.9KB)
Removing: /Users/valiha/Library/Caches/Homebrew/gettext--0.25... (9.0MB)
Removing: /opt/homebrew/Cellar/glib/2.82.4... (504 files, 36.3MB)
Removing: /opt/homebrew/Cellar/glib/2.82.5... (504 files, 36.3MB)
Removing: /opt/homebrew/Cellar/glib/2.84.1... (504 files, 36.6MB)
Removing: /opt/homebrew/Cellar/gnutls/3.8.9... (1,296 files, 11.0MB)
Removing: /Users/valiha/Library/Caches/Homebrew/gobject-introspection_bottle_manifest--1.84.0_1... (39.6KB)
Removing: /Users/valiha/Library/Caches/Homebrew/gobject-introspection--1.84.0_1... (1.7MB)
Removing: /opt/homebrew/Cellar/jpeg-turbo/3.1.0... (47 files, 3.5MB)
Removing: /opt/homebrew/Cellar/libnghttp2/1.65.0... (14 files, 767.1KB)
Removing: /opt/homebrew/Cellar/libpng/1.6.47... (28 files, 1.3MB)
Removing: /opt/homebrew/Cellar/libpng/1.6.48... (28 files, 1.3MB)
Removing: /Users/valiha/Library/Caches/Homebrew/libpng_bottle_manifest--1.6.48... (9.5KB)
Removing: /Users/valiha/Library/Caches/Homebrew/libpng--1.6.48... (446.2KB)
Removing: /opt/homebrew/Cellar/libslirp/4.9.0... (12 files, 419.8KB)
Removing: /opt/homebrew/Cellar/libssh/0.11.1... (25 files, 1.4MB)
Removing: /opt/homebrew/Cellar/libusb/1.0.28... (23 files, 629KB)
Removing: /Users/valiha/Library/Caches/Homebrew/lld_bottle_manifest--20.1.5... (22.7KB)
Removing: /Users/valiha/Library/Caches/Homebrew/lld--20.1.5... (1.7MB)
Removing: /Users/valiha/Library/Caches/Homebrew/llvm_bottle_manifest--20.1.5... (42.5KB)
Removing: /Users/valiha/Library/Caches/Homebrew/llvm--20.1.5... (406.6MB)
Removing: /Users/valiha/Library/Caches/Homebrew/locust_bottle_manifest--2.37.5... (23.9KB)
Removing: /Users/valiha/Library/Caches/Homebrew/locust--2.37.5... (7.2MB)
Removing: /Users/valiha/Library/Caches/Homebrew/meson_bottle_manifest--1.8.1... (4.8KB)
Removing: /Users/valiha/Library/Caches/Homebrew/meson--1.8.1... (863.7KB)
Removing: /Users/valiha/Library/Caches/Homebrew/mpdecimal_bottle_manifest--4.0.1... (9.5KB)
Removing: /Users/valiha/Library/Caches/Homebrew/mpdecimal--4.0.1... (181.3KB)
Removing: /opt/homebrew/Cellar/nettle/3.10.1... (96 files, 2.7MB)
Removing: /Users/valiha/Library/Caches/Homebrew/openssl@3_bottle_manifest--3.5.0... (11.9KB)
Removing: /Users/valiha/Library/Caches/Homebrew/openssl@3--3.5.0... (10.2MB)
Removing: /opt/homebrew/Cellar/pcre2/10.45... (242 files, 6.7MB)
Removing: /opt/homebrew/Cellar/pixman/0.44.2... (10 files, 655.6KB)
Removing: /opt/homebrew/Cellar/pixman/0.46.0... (10 files, 687.3KB)
Removing: /Users/valiha/Library/Caches/Homebrew/pixman_bottle_manifest--0.46.0... (8KB)
Removing: /Users/valiha/Library/Caches/Homebrew/pixman--0.46.0... (188.8KB)
Removing: /Users/valiha/Library/Caches/Homebrew/python@3.10_bottle_manifest--3.10.17_1... (26.7KB)
Removing: /Users/valiha/Library/Caches/Homebrew/python@3.10--3.10.17_1... (14.3MB)
Removing: /Users/valiha/Library/Caches/Homebrew/python@3.11_bottle_manifest--3.11.12_1... (26.4KB)
Removing: /Users/valiha/Library/Caches/Homebrew/python@3.11--3.11.12_1... (15.1MB)
Removing: /Users/valiha/Library/Caches/Homebrew/python@3.12_bottle_manifest--3.12.10_1... (32KB)
Removing: /Users/valiha/Library/Caches/Homebrew/python@3.12--3.12.10_1... (17.3MB)
Removing: /opt/homebrew/Cellar/readline/8.2.13... (51 files, 1.7MB)
Removing: /opt/homebrew/Cellar/snappy/1.2.1... (19 files, 172.2KB)
Removing: /opt/homebrew/Cellar/sqlite/3.49.1... (13 files, 4.7MB)
Removing: /opt/homebrew/Cellar/sqlite/3.49.2... (13 files, 4.7MB)
Removing: /Users/valiha/Library/Caches/Homebrew/sqlite_bottle_manifest--3.49.2... (11.2KB)
Removing: /Users/valiha/Library/Caches/Homebrew/sqlite--3.49.2... (2.2MB)
Removing: /opt/homebrew/Cellar/unbound/1.22.0... (59 files, 6MB)
Removing: /Users/valiha/Library/Caches/Homebrew/util-linux_bottle_manifest--2.40.4... (17.5KB)
Removing: /Users/valiha/Library/Caches/Homebrew/util-linux--2.40.4... (5MB)
Removing: /Users/valiha/Library/Caches/Homebrew/yosys_bottle_manifest--0.53... (16.5KB)
Removing: /Users/valiha/Library/Caches/Homebrew/yosys--0.53... (12.8MB)
Removing: /Users/valiha/Library/Caches/Homebrew/yt-dlp_bottle_manifest--2025.5.22... (21.1KB)
Removing: /Users/valiha/Library/Caches/Homebrew/yt-dlp--2025.5.22... (5MB)
Removing: /Users/valiha/Library/Caches/Homebrew/z3_bottle_manifest--4.15.0... (8.5KB)
Removing: /Users/valiha/Library/Caches/Homebrew/z3--4.15.0... (12.6MB)
Removing: /Users/valiha/Library/Caches/Homebrew/portable-ruby-3.4.5.arm64_big_sur.bottle.tar.gz... (11.6MB)
Removing: /Users/valiha/Library/Caches/Homebrew/portable-ruby-3.4.4.arm64_big_sur.bottle.tar.gz... (11.4MB)
Removing: /Users/valiha/Library/Caches/Homebrew/api-source/Homebrew/homebrew-cask/b6959122b6d748e9e6e62850d8074cdda55a0dd9/Cask/miniforge.rb... (1.6KB)
Removing: /Users/valiha/Library/Caches/Homebrew/bootsnap/e97374e1588ac90c9d40698c0ac5dacbd3791fe9a6c1fa338e6a7aeee18eda0c... (648 files, 5.3MB)
Removing: /Users/valiha/Library/Caches/Homebrew/bootsnap/f9b8d65d58d2b0fee3f1c5cd7096cca76618552ba7c091a9dcfc51705ad0778c... (649 files, 5.3MB)
Removing: /Users/valiha/Library/Caches/Homebrew/bootsnap/c3958faadd4bf40f4f682c4144ee7bd112f321e05565a0f0f6547bc841e51c2c... (643 files, 5.3MB)
Removing: /Users/valiha/Library/Caches/Homebrew/bootsnap/c08d8b21d5ae87b7c7fa27d7ebbe99025543c98fc45b251a5cf6d61c209749b9... (642 files, 5.2MB)
Removing: /Users/valiha/Library/Caches/Homebrew/bootsnap/d0221a6d90f5a9b4f58529011aac91a86ed9332e2f68488c6b9c79c9e1036f98... (643 files, 5.3MB)
Removing: /Users/valiha/Library/Caches/Homebrew/bootsnap/3af6c5705cd73a21d31294e455e5d3047b8425fcd1b4bb9730f385091c2317ae... (655 files, 5.3MB)
Removing: /opt/homebrew/lib/python3.10/site-packages/__pycache__/ipykernel_launcher.cpython-310.pyc... (502B)
Pruned 0 symbolic links and 5 directories from /opt/homebrew
==> Caveats
zsh completions have been installed to:
  /opt/homebrew/share/zsh/site-functions
```
  
</details>

```sh
# Ubuntu/Debian
sudo apt install gh
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


