import 'dart:convert';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Weather {
  // int me = 1;
  String icon = "";
  String city = "";
  String countryCode = "";
  String apiKey = "40ee76a33085129f390cf3a27b8737db";
  double latitude = 0;
  double longitude = 0;
  String sunset = "";
  String sunrise = "";
  String temperature = "";
  String minimum = "";
  String maximum = "";
  String visibility = "";

  String feelsLike = "";
  String date = "";
  String description = "";
  String humidity = "";
  String clouds = "";
  String windSpeed = "";
  Weather() {}
  Weather.city({tempCity}) {
    city = tempCity;
  }
  Weather.convertData(Map data) {
    city = data["city"];
    latitude = data["latitude"];
    longitude = data["longitude"];
    apiKey = data["apiKey"];
    temperature = data["temperature"];
    feelsLike = data["feelsLike"];
    description = data["description"];
    windSpeed = data["windSpeed"];
    humidity = data["humidity"];
    clouds = data["clouds"];
    countryCode = data["countryCode"];
    icon = data["icon"];
    minimum = data["minimum"];
    maximum = data["maximum"];
    visibility = data["visibility"];
    sunrise = data["sunrise"];
    sunset = data["sunset"];
    date = data["date"];
    if (icon.isEmpty)
      icon = "01d";
  }

  Future<Position> getCurrentPosition() async {
    Position position;
    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        // Handle the case where the user denied location permission
        throw Exception('Location permission denied.');
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      // Handle the case where the user denied location permission forever
      throw Exception(
          'Location permission denied forever. Please enable location services.');
    }

    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      // Handle any errors that occur while retrieving the current position
      throw Exception('Failed to retrieve the current position: $e');
    }
    return position;
  }

  Future<void> _getCoordinates({tempCity1, tempCountryCode1}) async {
    city = tempCity1;
    countryCode = tempCountryCode1;
    String url = "http://api.openweathermap.org/geo/1.0/direct?q=";
    url = "$url$city,$countryCode&limit=5&appid=$apiKey";
    Response response = await get(Uri.parse(url));
    List a = jsonDecode(response.body);
    Map a1 = a[0];
    double lat = a1['lat'];
    double long = a1['lon'];
    latitude = lat;
    longitude = long;
  }

  Future<void> _getWeatherSpecsByCoordinates(Position position) async {
    // await _getCoordinates(tempCity1: tempCity0, tempCountryCode1: tempCountryCode0 );
    try {
      latitude = position.latitude;
      longitude = position.longitude;
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      String? cityName = place.locality;
    } catch (e) {
      print("Error in City Finding by Coordinates");
      return;
    }
    String url = "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric";
    await _getWeatherSpecs(url);

  }

  Future<void> _getWeatherSpecsByCity() async {
    String url = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
    await _getWeatherSpecs(url);
  }

  Future<void> _getWeatherSpecs(String url) async {
    try {
      Response response = await get(Uri.parse(url));

      Map data = jsonDecode(response.body);
      List tempWeather = data['weather'];

      Map weather = tempWeather[0]; //weather
      Map main = data['main']; //main
      Map wind = data['wind']; //WIND
      Map cloud = data['clouds']; //CLOUD
      Map sys = data['sys']; //sys

      city = data['name'];
      visibility = data["visibility"].toString();
      temperature = main['temp'].toString();
      minimum = main['temp_min'].toString();
      maximum = main['temp_max'].toString();
      feelsLike = main['feels_like'].toString();
      description = weather['description'];
      icon = weather['icon'];
      humidity = main["humidity"].toString();
      windSpeed = wind["speed"].toString();
      clouds = cloud["all"].toString();

      DateTime sunsetTime =
          DateTime.fromMillisecondsSinceEpoch(sys['sunset'] * 1000);
      String sunsetHour = sunsetTime.hour.toString().padLeft(2, '0');
      String sunsetMinute = sunsetTime.minute.toString().padLeft(2, '0');
      sunset = "${int.parse(sunsetHour) - 12}:$sunsetMinute";

      DateTime sunriseTime =
          DateTime.fromMillisecondsSinceEpoch(sys['sunrise'] * 1000);
      String sunriseHour = sunriseTime.hour.toString().padLeft(2, '0');
      String sunriseMinute = sunriseTime.minute.toString().padLeft(2, '0');
      sunrise = "$sunriseHour:$sunriseMinute";

      DateTime currentDate =
          DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
      String currentMonth = currentDate.month.toString().padLeft(2, '0');
      String currentDay = currentDate.day.toString().padLeft(2, '0');
      date = "$currentMonth/$currentDay";
    } catch (e) {
      temperature = "N/A";
      feelsLike = "N/A";
      minimum = "N/A";
      maximum = "N/A";
      description = "N/A";
      humidity = "N/A";
      windSpeed = "N/A";
      clouds = "N/A";
      visibility = "N/A";
      temperature = "N/A";
      sunset = "N/A";
      sunrise = "N/A";
      icon = "01d";
      date = "N/A";
    }
  }
  Future<void> getData(String city) async {
    if (city == "N/A") {
      Position position = await getCurrentPosition();
      await _getWeatherSpecsByCoordinates(position);
    } else {
      this.city = city;
      await _getWeatherSpecsByCity();
    }
  }
  void printWeatherSpecs() {
    print(
        "city: $city: $longitude Latitude: $latitude \nTemperature: $temperature \nmaximum: $maximum \nminimum: $minimum \nclouds: $clouds \nwindSpeed: $windSpeed \nhumidity: $humidity\nfeelsLike: $feelsLike\ndescription: $description");
  }
}
