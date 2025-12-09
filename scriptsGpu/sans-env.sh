#!/bin/bash

# --- Shell Script Translation of setup_env.bat ---

echo "Setting environment variables for app development"
echo

# Note on Paths: 
# Windows paths (like D:\wspc3) have been converted to standard Unix paths 
# (e.g., /d/wspc3/repo). You may need to adjust the base path based on your 
# actual Linux/macOS/WSL file system structure.

# App parameters
export SANS_APP_VER="0.0.2" 

# Multi-tier parameters
export SANS_INSTANCE="internal"
export SANS_TARGET="local"
export SANS_ENV="dev"

# Key path variables
# Make sure folders do not end with /
export SANS_CODE_BASE="/d/wspc3/repo"
# Use this for the old modules using file based config.info
export SANS_CONFIG_BASE="/d/wspc3/repo/node/n_g_t_mw_api_config/server/vault"
export SANS_LOG_BASE="/d/wspc3/logs"
export SANS_STORE_BASE="/d/wspc3/store"
export SANS_TEMP_BASE="/d/wspc3/temp"

# Server configuration - Reserved for key app servers
export SANS_SERVER_NS="https://localhost:3101"

# Server starting 3201 to be removed after the name server implementation
export SANS_SERVER_CDN="https://localhost:3201"
export SANS_SERVER_CONFIG="https://localhost:3202"

# Application specific configuration
export DH_JWT_SECRET="s3cR3t!K3y@1234#AbCdEfGhIjKlMnOpQrStUvWxYz0987654321"

# Note: Paths here also converted to use forward slashes.
export DH_SSL_KEY="/d/wspc3/repo/other/config.info/vault.1/internal/local/dev/keys/dh_main.key"
export DH_SSL_CERT="/d/wspc3/repo/other/config.info/vault.1/internal/local/dev/keys/dh_main.crt"

# Node configuration
# Shell variable expansion uses $() or ``
export NODE_ENV="${SANS_ENV}"

# Update PATH for Node (using : separator)
# Note: The original batch file used a specific Node version path (v22.15.0) and a hardcoded Windows path (D:\bin).
# You should adjust /path/to/node/bin/ accordingly in your Unix environment.
export PATH="/data/v3/bin/vscode/v1.106:/data/v3/bin/node/v22.15.0/bin:${PATH}"

# configure ollama
export OLLAMA_HOST="0.0.0.0"
export PATH="/data/v3/bin/ollama/bin:${PATH}"

# configure docker
export PATH="/data/v3/bin/docker:${PATH}"

    
# Additional configurations
# This is required to run python application in monorepo configuration
# Shell variable expansion uses $() or ``
export PYTHONPATH="${SANS_CODE_BASE}/python:${PYTHONPATH}"

# Configure additional python tools
# Update PATH for pandoc, Tesseract, and ffmpeg (using : separator)
# You must update these paths to where these tools are installed on your Unix system.
export PATH="/path/to/pandoc/3.6.3:/usr/bin/tesseract:/path/to/ffmpeg/bin:${PATH}"

# PNPM configuration
export PNPM_HOME="/d/bin/pnpm/10.6.4"
export PATH="${PNPM_HOME}:${PATH}"

# Special config parameters

# Displaying SANS variables (env is common command to list environment variables)
echo "--- SANS Environment Variables ---"
env | grep "SANS"

# Displaying DH variables
echo
echo "--- DH Environment Variables ---"
env | grep "DH"

echo
# To run this script and apply variables to your current shell session, use:
source alias.sh