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
