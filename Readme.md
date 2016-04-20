CoffeeShopLocator is the app that is looking for the nearest coffee shops around your current location.

The application is written in Swift version 2.2 using Xcode version 7.3.
It should work on iPhone and iPad (tested on iPhone5) and supports portrait and landscape orientations. Deployment target is iOS 9.3.

At the moment the radius of search is 400 meters.
The information is updated every 15 seconds.

The applications contains a tab bar with 2 tabs - map view showing your current location with available coffee shops and list view which is a table view containing information about each coffee shop (name, address and distance in meters). The elements in the table view are sorted by distance in ascending order. The list of nearest coffee shops is sorted by server (parameter sortByDistance in url request is set to true), so the application does not sort it. The application requests information about open shops only (parameter openNow in url request is set to true).
Selecting a row in the table view allows making a phone call to the coffee shop if the phone number is known.

After receiving and successfully parsing JSON data the app calls a delegate method. Both, map view and list view conforms to that protocol and have to update information.

Button My Location on the map view moves you back to the current location.
