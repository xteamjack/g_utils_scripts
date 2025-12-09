echo "Installing packages: $@ ..."
# 1. Install the packages
pip install "$@"

# Check if installation was successful before updating requirements.txt
if [ $? -eq 0 ]; then
    echo "Installation successful. Generating updated requirements.txt..."
    # 2. Freeze the current environment and write to requirements.txt
    # We redirect pip freeze output to a temporary file first
    pip freeze > temp_requirements.txt
    
    # 3. Overwrite the main requirements.txt file with the new dependencies
    # This includes all currently installed packages with their versions
    mv temp_requirements.txt requirements.txt
    echo "requirements.txt updated successfully."
else
    echo "Error: Installation failed. requirements.txt was not modified."
    return 1
fi