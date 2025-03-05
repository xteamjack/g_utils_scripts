import os
import subprocess
import logging
from datetime import datetime

# Function to check if a directory is a git repository
def is_git_repo(path):
    return subprocess.call(['git', '-C', path, 'status'], stderr=subprocess.STDOUT, stdout=open(os.devnull, 'w')) == 0

# Function to get the git status
def get_git_status(path):
    result = subprocess.run(['git', '-C', path, 'status'], capture_output=True, text=True)
    return result.stdout

# Function to add all changes and commit
def git_commit(path, message):
    subprocess.run(['git', '-C', path, 'add', '--all'])
    subprocess.run(['git', '-C', path, 'commit', '-m', message])

# Function to check how behind the repo is from the remote
def get_behind_status(path):
    result = subprocess.run(['git', '-C', path, 'rev-list', '--left-right', '--count', 'HEAD...@{u}'], capture_output=True, text=True)
    return result.stdout

# Function to push changes to remote
def git_push(path):
    subprocess.run(['git', '-C', path, 'push'])

# Function to log messages
def log_message(message):
    logging.info(message)
    print(message)

# Main function to walk through the folder structure and perform git operations
def main(repo_path):
    # Set up logging
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    log_file = f'./logs/log_{timestamp}.log'
    os.makedirs(os.path.dirname(log_file), exist_ok=True)
    logging.basicConfig(filename=log_file, level=logging.INFO, format='%(asctime)s - %(message)s')

    for root, dirs, files in os.walk(repo_path):
        # Limit the depth to 2 (repo/<l1>/<l2>)
        if root[len(repo_path):].count(os.sep) < 2:
            for dir in dirs:
                repo_dir = os.path.join(root, dir)
                if is_git_repo(repo_dir):
                    log_message(f"Checking repository: {repo_dir}")
                    status = get_git_status(repo_dir)
                    log_message(status)

                    if "Changes not staged for commit" in status or "Untracked files" in status:
                        commit = input(f"Do you want to commit changes in {repo_dir}? (yes/no): ").strip().lower()
                        if commit == 'yes':
                            commit_message = input("Enter commit message: ").strip()
                            git_commit(repo_dir, commit_message)
                            log_message(f"Committed changes in {repo_dir} with message: {commit_message}")

                    behind_status = get_behind_status(repo_dir)
                    log_message(behind_status)

                    if "0\t0" not in behind_status:
                        push = input(f"Do you want to push changes in {repo_dir}? (yes/no): ").strip().lower()
                        if push == 'yes':
                            git_push(repo_dir)
                            log_message(f"Pushed changes in {repo_dir}")

if __name__ == "__main__":
    repo_path = input("Enter the path of the repo: ").strip()
    main(repo_path)