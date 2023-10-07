import random
import time
import requests
from io import BytesIO
import spotipy
from spotipy.oauth2 import SpotifyOAuth
from PIL import Image
from rgbmatrix import RGBMatrix, RGBMatrixOptions

# Your Spotify keys
client_id = 'XXXXXXXXXXXXXXXXXXXXXX'
client_secret = 'XXXXXXXXXXXXXXXXXXXXXXXXX'
redirect_url = 'http://localhost:8888/callback'

# Configuration for the matrix
options = RGBMatrixOptions()
options.rows = 32
options.chain_length = 1
options.parallel = 1
options.hardware_mapping = 'regular'  # If you have an Adafruit HAT: 'adafruit-hat'
matrix = RGBMatrix(options=options)

# Setup Spotify API connection with additional scope
scope = "user-read-currently-playing user-read-playback-state"
sp = spotipy.Spotify(auth_manager=SpotifyOAuth(
    scope=scope,
    client_id=client_id,
    client_secret=client_secret,
    redirect_uri=redirect_url
))

album_dict = {}
current_track_id = None

while True:
    try:
        result = sp.current_playback()
        if result is not None and result['item'] is not None:
            img_url = result['item']['album']['images'][0]['url']
            album_dict[img_url] = True  # Store album art URL
            track_id = result['item']['id']
            if track_id != current_track_id:
                current_track_id = track_id
                print(f"Display Album Art: {img_url}")

                # Code to display image on the LED matrix
                response = requests.get(img_url)
                if response.status_code == 200:
                    img = Image.open(BytesIO(response.content))
                    img.thumbnail((matrix.width, matrix.height), Image.ANTIALIAS)
                    matrix.SetImage(img.convert('RGB'))
                else:
                    print(f"Failed to retrieve image from URL: {img_url}")

                time.sleep(5)  # Adjust the sleep time as needed
            else:
                print("Track hasn't changed.")
                time.sleep(5)
        else:
            print(f"No track is currently playing.")
            matrix.Clear()
            time.sleep(2*60)  # Clear the display when nothing is playing
    except spotipy.exceptions.SpotifyException as e:
        print(f"Error encountered: {e}")
        time.sleep(5)
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        time.sleep(5)
