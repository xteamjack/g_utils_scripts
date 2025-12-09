#!/usr/bin/env bash

# Default base directory where all Python versions are installed
# Change this to match your Linux setup, e.g. /opt/python, $HOME/.python, or /usr/local/python
PYTHON_BASE_DIR="${PYTHON_BASE_DIR:-/data/v3/bin/python}"

# Get Python version from first argument, or use default
pyVer="${1:-3.10.6}"

# If no argument was passed and we're not in interactive mode, show usage
if [[ -z "$1" ]] && [[ -t 0 ]]; then
    echo "Usage: source ./setup-python.sh [python-version]"
    echo "Example: source ./setup-python.sh 3.11.8"
    echo ""
    echo "No version specified. Using default: $pyVer"
fi

echo "Setting Python environment $pyVer"

verDir="$PYTHON_BASE_DIR/$pyVer"

if [[ ! -d "$verDir" ]]; then
    echo "Error: Python version directory not found: $verDir"
    echo "Make sure '$pyVer' is installed in $PYTHON_BASE_DIR/"
    return 1 2>/dev/null || exit 1
fi

echo "Python Dir: $verDir"

# Update PATH
export PATH="$verDir/bin:$PATH"

# Optional: set helpful environment variables (similar to your batch)
export PY_LIBS="$verDir/lib:$verDir/lib/site-packages"
export PY_PIP="$verDir/bin"
export PIP_INSTALLER_LOCATION="$verDir/get-pip.py"

# Optional: nice message
echo "Python $pyVer is now active and in PATH"
echo "You can now run: python, pip, etc."

# Show which python is active (very useful)
command -v python >/dev/null && python --version | grep -q "$pyVer" && \
    echo "Success: $(python --version) is active"