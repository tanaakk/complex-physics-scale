#!/usr/bin/env bash
# commit-sync-all.sh
# 同期した 04/05 を全 5 リポジトリでコミットする。
# 実行後、各リポジトリで git push が必要。
#
# 使い方: ./scripts/commit-sync-all.sh [version]
# 例: ./scripts/commit-sync-all.sh v2.1.1

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BASE_DIR="$REPO_ROOT/.."
VERSION="${1:-v2.1.1}"

REPOS=(
  "universal-guideline"
  "GAAS-dissipative-constraints"
  "complex-physics-scale"
  "law-of-scale-verificator"
  "homotopical-coherence-engine"
)

MSG="docs: sync 04/05 from complex-physics-scale $VERSION (version rules)"

echo "Committing sync in 5 repositories..."
echo ""

for repo in "${REPOS[@]}"; do
  if [[ "$repo" == "complex-physics-scale" ]]; then
    DIR="$REPO_ROOT"
  else
    DIR="$BASE_DIR/$repo"
  fi

  if [[ ! -d "$DIR" ]]; then
    echo "  - $repo (not found)"
    continue
  fi

  cd "$DIR"
  if git status --porcelain | grep -q .; then
    git add 04_Repository_Relationships.md 2>/dev/null || true
    git add 05_Folder_Structure_Convention.md 2>/dev/null || true
    git add scripts/sync-repository-relationships.sh 2>/dev/null || true
    git add scripts/commit-sync-all.sh 2>/dev/null || true
    git commit -m "$MSG" || true
    echo "  ✓ $repo (committed)"
  else
    echo "  - $repo (no changes)"
  fi
done

echo ""
echo "Done. Run 'git push' in each repo to push to GitHub."
