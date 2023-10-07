import random
import time
import requests
from io import BytesIO
import spotipy
from spotipy.oauth2 import SpotifyOAuth
from PIL import Image

# Your Spotify keys
client_id = 'XXXXXXXXXXXXXXXXXXXXXX'
client_secret = 'XXXXXXXXXXXXXXXXXXXXXXXXX'
redirect_url = 'http://localhost:8888/callback'

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
                
                # Code to display image
                response = requests.get(img_url)
                if response.status_code == 200:
                    img = Image.open(BytesIO(response.content))
                    img.show()
                else:
                    print(f"Failed to retrieve image from URL: {img_url}")
                time.sleep(5)  # Adjust the sleep time as needed
            else:
                print("Track hasn't changed.")
                time.sleep(5)
        else:
            print(f"No track is currently playing.")
            if album_dict:
                img_url = random.choice(list(album_dict.keys()))
                print(f"Displaying random album art: {img_url}")
                response = requests.get(img_url)
                if response.status_code == 200:
                    img = Image.open(BytesIO(response.content))
                    img.show()
                else:
                    print(f"Failed to retrieve image from URL: {img_url}")
            else:
                print("No album arts available for display.")
            time.sleep(2*60)  # Display a random album art every 2 minutes when nothing is playing
    except spotipy.exceptions.SpotifyException as e:
        print(f"Error encountered: {e}")
        time.sleep(5)
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        time.sleep(5)
