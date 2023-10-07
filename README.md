Spotify Now Playing Album Art Display

This Python script displays the current playing album art from Spotify on a 4:3 monitor connected to a Raspberry Pi. It uses the Spotify API to fetch the currently playing track and retrieves the album art associated with it. If no track is currently playing, it will display a random album art from the previously played tracks. I used cloudflared tunnel to forward my subdomain that i used to create the spotify app to the raspberry pi, then use local redirect uri.

Prerequisites

    Python 3.6 or later
    Raspberry Pi with a 4:3 monitor
    Cloudflared for tunneling  - https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/
    
Dependencies

The script uses several Python libraries. You can install them via pip:

bash

pip install spotipy
pip install requests
pip install Pillow

Spotify API

You need to have a Spotify Developer account and create an app to get the client_id and client_secret. Also, set the redirect_url in the Spotify Developer Dashboard. Replace 'XXXXXXXX', 'XXXXXXXXXXX', 

Usage

    Clone the repository:

bash

git clone https://github.com/Brownster/SpotifyAlbumArt.py.git

    Navigate to the repository folder:

bash

cd SpotifyAlbumArt

    Replace the placeholders for client_id, client_secret, and redirect_url in the script with your actual Spotify app credentials.

    Run the script:

bash

python3 SpotifyAlbumArt.py



LED - Spotify Album Art

You need to install several libraries to make this work, including spotipy for interacting with the Spotify API, requests for making HTTP requests to download the album art, PIL (Pillow) for working with images, and the RGB matrix library for controlling the LED matrix. Here are the steps:
1. Install spotipy, requests, and Pillow using pip

If you haven't installed these libraries yet, you can do so via pip. Open your terminal and type:

bash

pip install spotipy requests pillow

2. Install the RGB Matrix Library

The installation of the RGB matrix library is a bit more complex because it's not a Python package that you can simply install with pip. Follow these steps:
a. Install the library

Clone the library's source code from GitHub, build, and install it. Run the following commands in your terminal:

bash

cd ~
git clone https://github.com/hzeller/rpi-rgb-led-matrix.git
cd rpi-rgb-led-matrix
make

b. Build the Python bindings

Still, in the same directory, build the Python bindings:

bash

cd bindings/python
make build-python
sudo make install-python

c. Test the installation

You can test whether the installation was successful by running one of the included examples:

bash

cd examples-api-use
sudo ./runtext.py

Replace ./runtext.py with the path to any other example if you want to try something different.
3. Permissions

To run the script without needing root permissions, you should also add a udev rule to allow the current user to access the devices connected to the GPIO pins:

bash

cd ~/rpi-rgb-led-matrix/utils
sudo ./install-service.sh

4. Restart your Raspberry Pi

Finally, restart your Raspberry Pi to ensure that all changes take effect:

bash

sudo reboot

5. Run your Python script

Now you should be able to run your Python script without any issues:

bash

python3 your-script.py

Replace "your-script.py" with the name of your Python script.
