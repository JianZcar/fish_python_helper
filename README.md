# README for Python Project Management Script

## Overview

This Fish shell script provides a set of functions to manage Python projects easily. It allows users to create new Python projects, list existing projects, open projects, check project configurations, and set up virtual environments. The script is designed to streamline the workflow for Python developers by automating common tasks.

## Features

- **Create a New Python Project**: Easily create a new project with a specified name, including a README file and a main Python script.
- **List Existing Projects**: View all Python projects in the designated directory.
- **Open a Project**: Navigate to a specific project by name or number.
- **Check Project Configuration**: Verify if a project has a virtual environment and a requirements file.
- **Set Up Virtual Environment**: Create and activate a virtual environment for the project, with an option to install common packages.
- **Manage Dependencies**: Automatically update the `requirements.txt` file with installed packages.

## Installation

1. **Prerequisites**: Ensure you have Fish shell and Python 3 installed on your system.
2. **Copy the Script**: Save the script to a file, e.g., `python_project_manager.fish`.
3. **Source the Script**: Add the following line to your `config.fish` file to load the script automatically:
   ```fish
   source /path/to/python_project_manager.fish
   ```

## Usage

### Create a New Python Project

To create a new Python project, use the following command:

```fish
new-python-project <project_name>
```

### List Existing Projects

To list all existing Python projects, run:

```fish
list-python-project
```

### Open a Project

To open a project, you can specify either the project number or the project name:

```fish
python-project <project_number_or_name>
```

### Check Project Configuration

To check the configuration of the current project, simply run:

```fish
check-python-project
```

### Set Up Virtual Environment

To create a virtual environment for the current project, use:

```fish
make-python-venv
```

### Activate Virtual Environment

To activate the virtual environment, run:

```fish
run-python-venv
```

### Manage Dependencies

To manage dependencies, the `pip` function is overridden to automatically update the `requirements.txt` file after installing packages.

## Notes

- The script assumes that your projects are stored in the `~/Dev/Projects/Python/` directory. You can modify the script to change this path if needed.
- The script provides prompts for user input when necessary, making it user-friendly.
- Ensure that you have the necessary permissions to create directories and files in the specified project directory.

## License

This script is provided as-is. Feel free to modify and use it according to your needs.
