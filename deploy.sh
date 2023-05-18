#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Installing now..."
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null
then
    echo "Docker Compose is not installed. Installing now..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Clone your repository (replace YOUR_REPO_URL with your actual repository URL)
git clone YOUR_REPO_URL

# Go to your project directory (replace YOUR_PROJECT_DIRECTORY with your actual project directory)
cd YOUR_PROJECT_DIRECTORY

# Start Docker Compose
sudo docker-compose up -d

# Wait for the containers to be ready
echo "Waiting for the containers to be ready..."
sleep 60

# Run the Python script to create a backup of the database
echo "Creating a backup of the database..."
sudo python3 db_dump.py

echo "Deployment completed successfully!"
