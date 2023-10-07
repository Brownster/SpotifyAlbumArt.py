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

# Prompt for output type
read -p "Do you want to use HDMI or LED Matrix for album art display? (hdmi/led): " output_type

# Install the RGB Matrix Library if LED Matrix is selected
if [ "$output_type" == "led" ]; then
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
fi

# Prompt for Spotify API credentials
read -p "Enter your Spotify client_id: " client_id
read -p "Enter your Spotify client_secret: " client_secret

# Replace placeholders in the selected Python script with actual Spotify credentials
cd ~/SpotifyAlbumArt.py
if [ "$output_type" == "led" ]; then
    sed -i "s/XXXXXXXXXXXXXXXXXXXXXX/$client_id/g" LED_SpotifyAlbumArt.py
    sed -i "s/XXXXXXXXXXXXXXXXXXXXXXXXX/$client_secret/g" LED_SpotifyAlbumArt.py
    echo "Installation completed. You can now run the LED_SpotifyAlbumArt.py script."
elif [ "$output_type" == "hdmi" ]; then
    sed -i "s/XXXXXXXXXXXXXXXXXXXXXX/$client_id/g" HDMI_SpotifyAlbumArt.py
    sed -i "s/XXXXXXXXXXXXXXXXXXXXXXXXX/$client_secret/g" HDMI_SpotifyAlbumArt.py
    echo "Installation completed. You can now run the HDMI_SpotifyAlbumArt.py script."
else
    echo "Invalid option selected. Please run the script again and select either 'hdmi' or 'led'."
    exit 1
fi
