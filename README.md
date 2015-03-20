# WeatherVK
Weather forecast iOS app

Brief explanation:

The main user interface was created by using Storyboard and Auto Layout.

The main Networking class is WTHWebAPIClient and it was implemented by using NSURLSession class, which was introduced with iOS 7.
I've used blocks in order to organize callbacks from requests.

In WTHMacroDefinitions file I added a handy macro (TR()) for localization support and one more macro for easy creation of Singleton.

I’ve created two TableViewControllers: LocationsViewController & WeatherViewController.
LocationsViewController allows user to edit his locations list and choose location in order to show weather forecast.
WeatherViewController shows hourly weather forecast, grouped by days.

By default user will see weather forecast for 5 days with 6 hours time interval.
But he can change these configuration in Settings app.

Available Locations are stored using .plist file, because he’s easy to use and can be modified without touching the code.

The main data in the app is represented by three entities WTHLocation, WTHDayForecast, WTHHourlyForecast.
They also encapsulate logic related to theirs serialization and deserialization. 
Creating a date formatter is not a cheap operation. 
Therefore I’ve cached a single instance for each type, instead of creating and disposing multiple instances.

I've used AFNetworking category for UIImageView for asynchronous loading and caching of weather icons.
