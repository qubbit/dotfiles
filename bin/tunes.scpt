if application "Spotify" is running then
  tell application "Spotify"
    set track_name to the name of the current track
    set artist_name to the artist of the current track
    try
      return "♫  " & track_name & " - " & artist_name
    on error err
    end try
  end tell
end if
