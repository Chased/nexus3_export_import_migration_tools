
# Nexus Repository Management Scripts

This repository contains several bash scripts for managing Nexus repositories, including importing, exporting, and deleting repositories.

## Scripts Overview

### 1. `compile_to_json.sh`
This script collects all JSON files from the specified directory and merges them into a single `repositories.json` file, adding each file as a JSON object.

#### Usage:
1. Ensure that the `REPO_DIR` variable points to the correct directory containing the `.json` files.
2. Run the script:
   ```bash
   ./compile_to_json.sh
   ```
3. The script will create or overwrite the `repositories.json` file, which will contain the merged data from all found JSON files.

### 2. `delete_repos.sh`
This script deletes all repositories from Nexus using the provided credentials.

#### Usage:
1. Ensure that your Nexus credentials are correctly specified in the `nexus_credentials.env` file.
2. Run the script:
   ```bash
   ./delete_repos.sh
   ```
3. The script will retrieve the list of repositories from Nexus and delete each one.

### 3. `import_to_nexus.sh`
This script imports repositories into Nexus from the `repositories.json` file by sending POST requests to create each repository.

#### Usage:
1. Ensure the `repositories.json` file exists and contains the correct data.
2. Make sure your Nexus credentials are specified in `nexus_credentials.env`.
3. Run the script:
   ```bash
   ./import_to_nexus.sh
   ```
4. The script will create repositories in Nexus based on the data in the `repositories.json` file.

### 4. `export.sh`
This script exports all repository settings from Nexus into a `repositories.json` file and organizes them into subfolders based on the repository type and format.

#### Usage:
1. Ensure your Nexus credentials are correctly specified in the `nexus_credentials.env` file.
2. Run the script:
   ```bash
   ./export.sh
   ```
3. The script will create a `repositories.json` file with information about all repositories and will distribute the data into corresponding subfolders.

## Environment Configuration

Before running any of the scripts, ensure that you have a properly configured `nexus_credentials.env` file, which contains the following environment variables:
```bash
USERNAME=<your-nexus-username>
PASSWORD=<your-nexus-password>
NEXUS_URL=<your-nexus-url>
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
