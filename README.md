**TODO:**

- see about form height responsiveness
- form vaidation
- clear list of orders after ordering
- cart responsiveness / disable landscape on this screen
- work on changing theme option
- read from json
- snackbar
- firestore backend
- add photos to README

# Ștefan MĂGIRESCU

## ALBOOM - Listen and buy your favorite records!

<br>
This is an app designed to let the user listen to online previews of the albums it is selling and read the latest news in the music world.
<br><br>

### **UI - Main screens:**

- **HOME**
  - loads the most listened to albums in the community
  - gives the option of liking favorite albums - tapping the album art sends the user to the "add to cart" dialog which features _EXTRA DATA_ regarding the album (band, year, label), the _PREVIEW_ button (which takes the user to YouTube), the _+1_ button and the _ADD TO CART_ button
  - loads the latest news
  - tapping the article thumbnail takes the user to YouTube (a random song of the band in question), while tapping the dot menu opens up the _SHARE_ and _HIDE_ options
    <br><br>
- **CART**
  - loads up the list of albums added to the cart
  - each item features the album art, name, artist, quantity (instantly modifiable by using the +/- buttons) and price in dollars
  - the _REMOVE ALL_ buttons clears the list, while the _PAYMENT INFO_ button sends the user to the final dialog before sending the order
  - the total prices update instantly, according to the changes done to the list
    <br><br>
- **SETTINGS**
  - one option to change theme
  - credits to the author section
