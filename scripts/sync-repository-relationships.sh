#!/usr/bin/env bash
# sync-repository-relationships.sh
# 04_Repository_Relationships.md と 05_Folder_Structure_Convention.md を他 4 リポジトリへコピーし、バージョン情報を更新する。
# Canonical Source: complex-physics-scale
#
# 使い方:
#   ./scripts/sync-repository-relationships.sh                    # 親ディレクトリの兄弟リポジトリへコピー
#   ./scripts/sync-repository-relationships.sh /path/to/repos    # 指定ディレクトリ内の各リポジトリへコピー
#   ./scripts/sync-repository-relationships.sh -v v2.1.1        # バージョン指定してコピー

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE_04="$REPO_ROOT/04_Repository_Relationships.md"
SOURCE_05="$REPO_ROOT/05_Folder_Structure_Convention.md"
SOURCE_06="$REPO_ROOT/06_Universal_Schema_Concept.md"

TARGET_REPOS=(
  "universal-guideline"
  "GAAS-dissipative-constraints"
  "law-of-scale-verificator"
  "homotopical-coherence-engine"
)

get_version() {
  if git -C "$REPO_ROOT" rev-parse --git-dir >/dev/null 2>&1; then
    git -C "$REPO_ROOT" describe --tags --abbrev=0 2>/dev/null || echo "v2.1.1"
  else
    echo "v2.1.1"
  fi
}

get_date() {
  date +%Y-%m-%d
}

update_metadata() {
  local content="$1"
  local version="$2"
  local date="$3"
  echo "$content" | sed \
    -e "s/| \*\*Framework version\*\* | .* |/| **Framework version** | $version |/" \
    -e "s/| \*\*Last sync\*\* | .* |/| **Last sync** | $date |/"
}

VERSION=$(get_version)
DATE=$(get_date)
BASE_DIR="$REPO_ROOT/.."

while [[ $# -gt 0 ]]; do
  case $1 in
    -v|--version)
      VERSION="$2"
      shift 2
      ;;
    *)
      BASE_DIR="$1"
      shift
      ;;
  esac
done

if [[ ! -f "$SOURCE_04" ]]; then
  echo "Error: $SOURCE_04 not found."
  exit 1
fi

echo "Syncing from complex-physics-scale ($VERSION) to:"
echo "  - 04_Repository_Relationships.md"
[[ -f "$SOURCE_05" ]] && echo "  - 05_Folder_Structure_Convention.md"
[[ -f "$SOURCE_06" ]] && echo "  - 06_Universal_Schema_Concept.md"
echo ""

COPIED=0
for repo in "${TARGET_REPOS[@]}"; do
  TARGET_DIR="$BASE_DIR/$repo"
  if [[ -d "$TARGET_DIR" ]]; then
    CONTENT=$(update_metadata "$(cat "$SOURCE_04")" "$VERSION" "$DATE")
    echo "$CONTENT" > "$TARGET_DIR/04_Repository_Relationships.md"
    if [[ -f "$SOURCE_05" ]]; then
      cp "$SOURCE_05" "$TARGET_DIR/05_Folder_Structure_Convention.md"
    fi
    if [[ -f "$SOURCE_06" ]]; then
      cp "$SOURCE_06" "$TARGET_DIR/06_Universal_Schema_Concept.md"
    fi
    echo "  ✓ $repo"
    ((COPIED++)) || true
  else
    echo "  - $repo (not found: $TARGET_DIR)"
  fi
done

CONTENT=$(update_metadata "$(cat "$SOURCE_04")" "$VERSION" "$DATE")
echo "$CONTENT" > "$SOURCE_04"

echo ""
echo "Done. Copied to $COPIED repositories."
echo "Version: $VERSION | Date: $DATE"
echo ""
echo "Next steps for each target repo:"
echo "  git add 04_Repository_Relationships.md 05_Folder_Structure_Convention.md 06_Universal_Schema_Concept.md"
echo "  git commit -m \"docs: sync 04/05 from complex-physics-scale $VERSION (version rules)\""
echo "  git push"
