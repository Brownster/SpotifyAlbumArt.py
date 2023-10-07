#!/bin/bash

echo "Spotify Album Art Display Installation Script"

# Check if script is run as root
if [ "$(whoami)" != "root" ]; then
    echo "Please run this script as root."
    exit 1
fi

# Update and upgrade the system
echo "Updating and upgrading the system..."
apt-get update -y && apt-get upgrade -y
if [ $? -ne 0 ]; then
    echo "Failed to update and upgrade the system. Please check your network connection."
    exit 1
fi

# Install dependencies
echo "Installing dependencies..."
apt-get install -y python3-dev python3-pillow libgraphicsmagick++-dev libwebp-dev
if [ $? -ne 0 ]; then
    echo "Failed to install dependencies."
    exit 1
fi

# Clone the GitHub repository
echo "Cloning the SpotifyAlbumArt repository..."
cd /home/pi || exit
git clone https://github.com/Brownster/SpotifyAlbumArt.py.git
if [ $? -ne 0 ]; then
    echo "Failed to clone the repository. Please check your network connection."
    exit 1
fi

# Install Python requirements
echo "Installing Python requirements..."
pip3 install -r SpotifyAlbumArt.py/requirements.txt
if [ $? -ne 0 ]; then
    echo "Failed to install Python requirements."
    exit 1
fi

# Ask for Spotify API credentials
read -p "Enter your Spotify Client ID: " client_id
read -p "Enter your Spotify Client Secret: " client_secret

# Update the Python script with the Spotify API credentials
echo "Updating the Python script with your Spotify API credentials..."
sed -i "s/XXXXXXXXXXXXXXXXXXXXXX/$client_id/g" SpotifyAlbumArt.py/HDMI_SpotifyAlbumArt.py
sed -i "s/XXXXXXXXXXXXXXXXXXXXXXXXX/$client_secret/g" SpotifyAlbumArt.py/HDMI_SpotifyAlbumArt.py

# Ask the user for the display output type
attempt=0
while [ $attempt -lt 3 ]; do
    echo "Choose the display output type:"
    echo "1. HDMI"
    echo "2. LED Matrix"
    read -p "Enter the number (1 or 2): " choice
    
    if [ "$choice" -eq 1 ]; then
        echo "Running the HDMI_SpotifyAlbumArt.py script..."
        python3 SpotifyAlbumArt.py/HDMI_SpotifyAlbumArt.py
        break
    elif [ "$choice" -eq 2 ]; then
        echo "Running the LED_SpotifyAlbumArt.py script..."
        python3 SpotifyAlbumArt.py/LED_SpotifyAlbumArt.py
        break
    else
        echo "Invalid choice. Please try again."
        ((attempt++))
        if [ $attempt -eq 3 ]; then
            echo "Too many invalid attempts. Exiting."
            exit 1
        fi
    fi
done

echo "Installation completed successfully!"
