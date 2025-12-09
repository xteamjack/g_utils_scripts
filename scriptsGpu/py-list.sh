#!/usr/bin/env bash
# =============================================================================
# py-list.sh  —  List all available Python versions
# Usage:      py-list
#             (no arguments needed)
# =============================================================================

# Load the base configuration (sets PYTHON_BASE_DIR)
if [[ -f "./py-base.sh" ]]; then
    source "./py-base.sh" >/dev/null 2>&1
elif [[ -f "~/bin/pybase" ]]; then
    source "~/bin/pybase" >/dev/null 2>&1
else
    # Fallback if py-base.sh is not found — try to guess a common location
    PYTHON_BASE_DIR="${PYTHON_BASE_DIR:-/data/v3/bin/python}"
fi

echo "Available Python versions in $PYTHON_BASE_DIR :"
echo "──────────────────────────────────────────────"

if [[ ! -d "$PYTHON_BASE_DIR" ]]; then
    echo "Directory not found: $PYTHON_BASE_DIR"
    echo "Set PYTHON_BASE_DIR to the correct path."
    exit 1
fi

# List directories that actually contain a python binary (most reliable)
find "$PYTHON_BASE_DIR" -mindepth 1 -maxdepth 1 -type d -exec sh -c '
    dir="$1"
    base=$(basename "$dir")
    if [ -x "$dir/bin/python" ] || [ -x "$dir/bin/python3" ]; then
        echo "  $base   (ready)"
    else
        echo "  $base"
    fi
' _ {} \; | sort

echo "──────────────────────────────────────────────"
echo "Total: $(find "$PYTHON_BASE_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l) versions"