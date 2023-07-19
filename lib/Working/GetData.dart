import 'dart:convert';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
class Weather
{

  int me = 1;
  String icon = "";
  String city = "";
  String countryCode= "";
  String apiKey= "40ee76a33085129f390cf3a27b8737db";
  double latitude = 0;
  double longitude = 0;
  String sunset = "";
  String sunrise = "";
  String temperature= "";
  String minimum= "";
  String maximum= "";
  String visibility = "";

  String feelsLike= "";
  String date = "";
  String description= "";
  String humidity= "";
  String clouds= "";
  String windSpeed= "";
  Weather(){}
  Weather.city({tempCity}) {
    city = tempCity;
  }
  Weather.convertData(Map data)
  {

   city = data["city"];
   latitude = data["latitude"];
   longitude = data["longitude"];
   apiKey = data["apiKey"];
   temperature= data["temperature"];
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
  }


  Future<Position> getCurrentPosition() async {
    Position position;
    LocationPermission locationPermission = await Geolocator.checkPermission();
    print("Location permission: $locationPermission");

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        // Handle the case where the user denied location permission
        throw Exception('Location permission denied.');
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      // Handle the case where the user denied location permission forever
      throw Exception('Location permission denied forever. Please enable location services.');
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


  Future <void> _getCoordinates({tempCity1 , tempCountryCode1}) async {
    city=tempCity1;
    countryCode = tempCountryCode1;
    String url = "http://api.openweathermap.org/geo/1.0/direct?q=";
    url = "$url$city,$countryCode&limit=5&appid=$apiKey";
    Response response = await get(Uri.parse(url));
    List a = jsonDecode(response.body);
    Map a1 = a[0];
    double lat  = a1['lat'];
    double long  = a1['lon'];
    latitude = lat;
    longitude = long;
    // print("lat");
    // print(latitude);
    // print("long");
    // print(longitude);
  }
  Future<void> _getWeatherSpecsByCoordinates (Position position) async {
    // await _getCoordinates(tempCity1: tempCity0, tempCountryCode1: tempCountryCode0 );
    try {
      latitude = position.latitude;
      longitude = position.longitude;
      print("in getweatherbyco: $latitude $longitude");
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      String? cityName = place.locality;
      print("city is: $cityName");
      city = cityName!;

      String url = "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=40ee76a33085129f390cf3a27b8737db&units=metric";
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      List tempWeather = data['weather'];

      Map weather = tempWeather[0]; //weather
      Map main = data['main']; //main
      Map wind = data['wind']; //WIND
      Map cloud = data['clouds']; //CLOUD
      Map sys = data['sys']; //sys

      // city = data['name'];
      visibility = data["visibility"].toString();
      // print("ttemp: ${main['temp']}");
      temperature = main['temp'].toString();
      minimum = main['temp_min'].toString();
      maximum = main['temp_max'].toString();
      feelsLike = main['feels_like'].toString();
      description = weather['description'];
      icon = weather['icon'];
      humidity = main["humidity"].toString();
      windSpeed = wind["speed"].toString();
      clouds = cloud["all"].toString();

      DateTime sunsetTime = DateTime.fromMillisecondsSinceEpoch(sys['sunset'] * 1000);
      String sunsetHour = sunsetTime.hour.toString().padLeft(2, '0');
      String sunsetMinute = sunsetTime.minute.toString().padLeft(2, '0');
      sunset = "${int.parse(sunsetHour) - 12}:$sunsetMinute";
      print("Sunset: $sunset");


      DateTime sunriseTime = DateTime.fromMillisecondsSinceEpoch(sys['sunrise'] * 1000);
      String sunriseHour = sunriseTime.hour.toString().padLeft(2, '0');
      String sunriseMinute = sunriseTime.minute.toString().padLeft(2, '0');
      sunrise = "$sunriseHour:$sunriseMinute";
      print("sunrise: $sunrise");





      // print("Date: "+ date.toString());
      //
      // var date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(sys['sunrise'], true);
      // var local = date.toLocal().toString();
      // print(local);

      // countryCode =
    }catch(e) {
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
      date= "N/A";

      print(e);
    }


    printWeatherSpecs();
  }
  Future<void> _getWeatherSpecs () async {
    // await _getCoordinates(tempCity1: tempCity0, tempCountryCode1: tempCountryCode0 );
    try {
      String url = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      List tempWeather = data['weather'];

      Map weather = tempWeather[0]; //weather
      Map main = data['main']; //main
      Map wind = data['wind']; //WIND
      Map cloud = data['clouds']; //CLOUD
      Map sys = data['sys']; //sys

      // city = data['name'];
      visibility = data["visibility"].toString();
      // print("ttemp: ${main['temp']}");
      temperature = main['temp'].toString();
      minimum = main['temp_min'].toString();
      maximum = main['temp_max'].toString();
      feelsLike = main['feels_like'].toString();
      description = weather['description'];
      icon = weather['icon'];
      humidity = main["humidity"].toString();
      windSpeed = wind["speed"].toString();
      clouds = cloud["all"].toString();

      DateTime sunsetTime = DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000);
      String sunsetHour = sunsetTime.hour.toString().padLeft(2, '0');
      String sunsetMinute = sunsetTime.minute.toString().padLeft(2, '0');
      sunset = "${int.parse(sunsetHour) - 12}:$sunsetMinute";
      print("Sunset: $sunset");


      DateTime sunriseTime = DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000);
      String sunriseHour = sunriseTime.hour.toString().padLeft(2, '0');
      String sunriseMinute = sunriseTime.minute.toString().padLeft(2, '0');
      sunrise = "$sunriseHour:$sunriseMinute";
      print("sunrise: $sunrise");

      //
      // final Date = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
      // // print(date.day);
      // date = "${Date.month-12}/${Date.day}";
      // var date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(sys['sunrise'], true);
      // var local = date.toLocal().toString();
      // print(local);

      // countryCode =
    }catch(e) {
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
      date= "N/A";


      print(e);

    }


    printWeatherSpecs();
  }


  Future<void> getData()async {
    Position position = await getCurrentPosition();
    print("Position: $position");

    await _getWeatherSpecsByCoordinates(position);
  }
  void printWeatherSpecs() {
    print("city: $city: $longitude Latitude: $latitude \nTemperature: $temperature \nmaximum: $maximum \nminimum: $minimum \nclouds: $clouds \nwindSpeed: $windSpeed \nhumidity: $humidity\nfeelsLike: $feelsLike\ndescription: $description");
  }
  String get_Description() {
    return description;
  }


}
