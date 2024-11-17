#!/bin/bash

# define application directory
APP_DIR=""

# navigate to the application directory
echo "Navigating to application directory: $APP_DIR"
cd $APP_DIR || { echo "Application directory not found!"; exit 1; }

# create a virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating a new virtual environment..."
    python3 -m venv venv
else
    echo "Virtual environment already exists."
fi

# check if the virtual environment is already activated
if [ -z "$VIRTUAL_ENV" ]; then
    echo "Activating the virtual environment..."
    source venv/bin/activate
else
    echo "Virtual environment already activated."
fi

# stop any running instance of the application
echo "Stopping any running instance of the application..."
pkill -f "app.py" || echo "No running instances found."

# start the application
echo "Starting the application..."
nohup ./venv/bin/python app.py > app.log 2>&1 &

# confirm deployment
echo "Deployment complete. Application is running."
echo "Logs are being written to app.log"