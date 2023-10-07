#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install Python3 and PIP
sudo apt install -y python3 python3-pip

# Clone the GitHub repository
git clone https://github.com/Brownster/SpotifyAlbumArt.py.git
cd SpotifyAlbumArt.py

# Install Python dependencies
pip3 install -r requirements.txt

# Install the RGB Matrix Library
cd ~
git clone https://github.com/hzeller/rpi-rgb-led-matrix.git
cd rpi-rgb-led-matrix
make
cd bindings/python
make build-python
sudo make install-python

# Permissions to run the script without needing root
cd ~/rpi-rgb-led-matrix/utils
sudo ./install-service.sh

# Prompt for Spotify API credentials
read -p "Enter your Spotify client_id: " client_id
read -p "Enter your Spotify client_secret: " client_secret

# Replace placeholders in the Python script with actual Spotify credentials
cd ~/spotify-album-art-display
sed -i "s/XXXXXXXXXXXXXXXXXXXXXX/$client_id/g" SpotifyAlbumArt.py
sed -i "s/XXXXXXXXXXXXXXXXXXXXXXXXX/$client_secret/g" SpotifyAlbumArt.py

echo "Installation completed. You can now run the SpotifyAlbumArt.py script."
