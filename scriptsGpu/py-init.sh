#!/usr/bin/env bash
# =============================================================================
# py-init.sh  —  Initialize a new Python virtual environment with a chosen version
# Usage:     source py-init.sh [python-version]    (or just ./py-init.sh 3.11.8)
# Must be sourced from the same directory as py-base.sh / setup-python.sh
# =============================================================================

# Load the base Python version selector (your first script)
# Adjust the path if your setup-python.sh lives elsewhere
if [[ -f "./py-base.sh" ]]; then
    source "./py-base.sh"
elif [[ -f "./setup-python.sh" ]]; then
    source "./setup-python.sh"
else
    echo "Error: py-base.sh (or setup-python.sh) not found in current directory"
    return 1 2>/dev/null || exit 1
fi

# -------------------------------------------------------------------------
# 1. Check that a version was passed
# -------------------------------------------------------------------------
if [[ -z "$1" ]]; then
    echo "Python version not specified"
    echo "Pick from the available versions below:"
    echo "--------------------------------------------------"
    # List only directories that actually contain a python executable
    find "$PYTHON_BASE_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
    echo "--------------------------------------------------"
    echo "Usage: source $0 <version>"
    echo "Example: source $0 3.11.8"
    return 1 2>/dev/null || exit 1
fi

requested_version="$1"

# -------------------------------------------------------------------------
# 2. Prevent re-initialization if version.cnf already exists
# -------------------------------------------------------------------------
if [[ -f "version.cnf" ]]; then
    echo "Python version already initialized in this project."
    echo "Current version:"
    cat version.cnf
    echo ""
    echo "To change it, delete version.cnf and run this script again,"
    echo "or use your own py-cnf / reconfiguration script."
    return 1 2>/dev/null || exit 1
fi

# -------------------------------------------------------------------------
# 3. Activate the requested Python version
# -------------------------------------------------------------------------
echo "Initializing project with Python $requested_version ..."
source ./py-base.sh "$requested_version" || {
    echo "Failed to set up Python $requested_version"
    return 1 2>/dev/null || exit 1
}

# -------------------------------------------------------------------------
# 4. Save the chosen version for future reference
# -------------------------------------------------------------------------
echo "$requested_version" > version.cnf
echo "Saved version $requested_version to version.cnf"

# -------------------------------------------------------------------------
# 5. Create and activate virtual environment
# -------------------------------------------------------------------------
echo "Creating virtual environment (venv) with Python $requested_version ..."
python -m venv venv || {
    echo "Failed to create venv. Is 'venv' module available?"
    return 1 2>/dev/null || exit 1
}

# Activate it in the current shell
# shellcheck source=/dev/null
source venv/bin/activate

echo "All done!"
echo "Virtual environment is now active: $(python --version) (in $(which python))"
echo "You can now: pip install -r requirements.txt  etc."

# Optional: show the active version again for confirmation
deactivate 2>/dev/null  # just in case something was already active
source venv/bin/activate 2>/dev/null