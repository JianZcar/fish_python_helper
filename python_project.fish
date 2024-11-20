function new-python-project
    # Check if the user provided a project name
    if test (count $argv) -lt 1
        echo "Usage: new-python-project <project_name>"
        return 1
    end

    # Get the project name from the arguments
    set project_name $argv[1]

    # Check if the project directory already exists
    if test -d $project_name
        echo "Error: Directory '$project_name' already exists."
        return 1
    end

    # Create the project directory
    mkdir ~/Dev/Projects/Python/$project_name
    cd ~/Dev/Projects/Python/$project_name

    echo "# Python Project" > README.md
    touch main.py
    
    make-python-venv 

    # Print a success message
    echo "Python project '$project_name' has been created and virtual environment is set up."

end

function list-python-project
    # Set directory to ~/Dev/Projects/Python/
    set directory ~/Dev/Projects/Python

    # List all subdirectories under the given directory
    set projects (find $directory -mindepth 1 -maxdepth 1 -type d)

    if test (count $projects) -eq 0
        echo "No projects found in '$directory'."
    else
        echo "Listing all Python projects in '$directory':"
        
        # Initialize a counter for the numbered list
        set i 1
        
        # Loop through each project and print the numbered project name
        for project in $projects
            set project_name (basename $project)
            echo "$i. $project_name"
            set i (math $i + 1)  # Increment the counter
        end
    end
end

function python-project
    # Set directory to ~/Dev/Projects/Python/
    set directory ~/Dev/Projects/Python

    # List all subdirectories (projects) under the given directory
    set projects (find $directory -mindepth 1 -maxdepth 1 -type d)

    # Check if there are no projects in the directory

    if test (count $projects) -eq 0 -a (count $argv) -eq 0
        echo "No projects found in '$directory'."
        return 1
    end

    # If no argument is given, show a helpful message
    if test (count $argv) -eq 0
        echo "Usage: python-project <project_number_or_name>"      
        list-python-project
        return 1
    end

    # Case 1: If the argument is a number
    if test (string match -r '^\d+$' $argv[1])
        set project_number $argv[1]  # No need to subtract 1, Fish arrays are 1-based
        if test $project_number -ge 1 -a $project_number -le (count $projects)
            set project_name (basename $projects[$project_number])
            echo "Opening project: $project_name"
            # Open the project (replace `cd` with your desired command, e.g., `nvim .`)
            cd $projects[$project_number]
            check-python-project
        else
            echo "Project number '$argv[1]' not found"
            echo "Do you want to create a new project instead? (y,N)"
            read create_project
            if test "$create_project" = "y"
                echo "Project name↴"
                read project_name
                new-python-project "$project_name"
            end

            return 1
        end
    # Case 2: If the argument is a project name
    else
        set project_name $argv[1]
        set project_path "$directory/$project_name"
        if test -d $project_path
            echo "Opening project: $project_name"
            # Open the project (replace `cd` with your desired command, e.g., `nvim .`)
            cd $project_path
            check-python-project
        else
            echo "Project '$project_name' not found."
            echo "Do you want to create a new project instead? (y,N)" 
            read create_project
            if test "$create_project" = "y"
                echo "Use $project_name as Project name? (Y,n)"
                read use_default_name
                if test "$use_default_name" = "n"
                    echo "Project name↴"
                    read new_project_name
                    new-python-project "$new_project_name"
                else
                    new-python-project "$project_name"
                end
            end
            return 1
        end
    end
end


function check-python-project
    # Get the current directory (project)
    set directory .

    # Check if the directory contains .venv and requirements.txt
    set has_venv (test -d $directory/.venv; echo $status)
    set has_requirements (test -e $directory/requirements.txt; echo $status)

    # Display results
    echo "Checking project"

    if test $has_venv -eq 1 -a $has_requirements -eq 1
        echo "  This project has no .venv and no requirements.txt."
        echo "  To make a virtual envronment, run: make-python-venv"
    else
        if test $has_venv -eq 0
            echo "  This project has a virtual environment (.venv)."
            run-python-venv
        else
            echo "  This project does not have a virtual environment (.venv)."
        end

        if test $has_requirements -eq 0
            echo "  This project has a requirements.txt file."
        else
            echo "  This project does not have a requirements.txt file."
        end
    end
end

function make-python-venv
    # Define the virtual environment directory
    set venv_dir ./.venv
    set requirements_file ./requirements.txt

    # Check if the virtual environment already exists
    if test -d $venv_dir
        echo "Error: Virtual environment '.venv' already exists in the current directory."
        return 1
    end

    # Create the virtual environment
    python3 -m venv $venv_dir
    echo "Created virtual environment in '$venv_dir'."
    echo "Activating the virtual environment..."
    source $venv_dir/bin/activate.fish
    pip install --upgrade pip

    # Create an empty requirements.txt file
    touch $requirements_file
    echo "Created an empty requirements.txt file in the current directory."

    # Optionally, activate the virtual environment and install common packages
    echo "Do you want to install common packages? (y/N)"
    read install_packages

    if test "$install_packages" = "y"
        # Activate virtual environment and install some common packages (e.g., requests, numpy)    
        pip install requests numpy pytest
        echo "Installed common packages (requests, numpy, pytest) in the virtual environment."
    end

    echo "Python virtual environment setup is complete."
    # Optionally, provide instructions to the user
    echo "To activate the virtual environment, run: run-python-venv"
end

function run-python-venv
    source .venv/bin/activate.fish
end

function pip
    command pip $argv
    emit pip:after
end

function pip_after --on-event pip:after
    command pip freeze > requirements.txt
end


function hello

end
