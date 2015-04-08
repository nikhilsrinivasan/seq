|App Name       | URL Scheme    | Context       | Functions     | Notes         |
|:--------------|:--------------|:--------------|:--------------|:--------------|
| Apple Maps    | http://maps.apple.com/? | | query: q=QUERY             | https://developer.apple.com/library/ios/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html              |
| Airbnb        | airbnb:// | | room: rooms/ROOM_ID | need search scheme (ROOM_ID from web API) |
| Expedia       | expda:/<br>expediahotels:/<br>expediaflights:/<br>expediabookings:/ | | itineraries: trips/ | need hotel + flight search schemes |
| Foursquare    | foursquare:// || venue: venues/VENUE_ID<br>user: users/USER_ID | need search scheme (VENUE_ID, USER_ID from web API)|
| Genius        | genius:/ |               | artist: api.genius.com//search/artists/ARTIST_ID<br> song: api.genius.com//search/songs/SONG_ID | ARTIST_ID, SONG_ID from web API |
| Google Maps   | comgooglemaps://? |  | query: q=QUERY |               |
| Hipmunk       |  hipmunk:/  | | hotel: search/hotels<br>flight: search/flights | need params for search schemes |
| Lyft          |  fb275560259205767:// |               |               |               |
| Rdio          | rdio:/ |    |  any rdio link: rdio.com/*  |               | 
| Spotify       | spotify: |    | artist: artist:ARTIST_ID<br>track: track:TRACK_ID | ARTIST_ID, TRACK_ID from web API |
| Uber          | uber:/ |               |               |  use internal API to retreive ETA |
| Yelp          | yelp:/// |               |  search: search?terms=TERMS |               |
|               |               |               |               |               |