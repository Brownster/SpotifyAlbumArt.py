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


Spotify Album Art Display on RGB LED Matrix

This project displays the current Spotify album art on an RGB LED matrix using a Raspberry Pi. It utilizes the Spotify API to fetch the current playing song's album art and displays it on the LED matrix.
Requirements

    Raspberry Pi (tested on Model 3B+ and 4)
    RGB LED Matrix
    Internet connection to access the Spotify API

Dependencies

    spotipy
    requests
    Pillow (PIL Fork)
    rpi-rgb-led-matrix

Installation
1. Clone the Repository

bash

git clone [https://github.com/yourusername/https://github.com/Brownster/SpotifyAlbumArt.py/spotify-album-art-display.git
cd spotify-album-art-display

2. Install Python Dependencies

bash

pip install -r requirements.txt

3. Install the RGB Matrix Library

bash

cd ~
git clone https://github.com/hzeller/rpi-rgb-led-matrix.git
cd rpi-rgb-led-matrix
make
cd bindings/python
make build-python
sudo make install-python

4. Permissions

To run the script without needing root permissions:

bash

cd ~/rpi-rgb-led-matrix/utils
sudo ./install-service.sh

5. Restart the Raspberry Pi

bash

sudo reboot

Usage
Set Spotify Credentials

Open SpotifyAlbumArt.py and set your Spotify client_id, client_secret, and redirect_url.
Run the Script

bash

python3 SpotifyAlbumArt.py

Customization

You can adjust the size of the LED matrix and other parameters within the SpotifyAlbumArt.py file to fit your specific hardware setup.
Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
License

MIT
