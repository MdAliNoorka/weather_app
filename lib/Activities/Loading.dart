import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/Working/GetData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Weather weather = Weather();

  void RunApp([String city = "N/A"]) async {
    await weather.getData(city);
    // GetCurrentPosition();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temperature": weather.temperature,
        "city": weather.city,
        "latitude": weather.latitude,
        "longitude": weather.longitude,
        "description": weather.description,
        "countryCode": weather.countryCode,
        "clouds": weather.clouds,
        "windSpeed": weather.windSpeed,
        "humidity": weather.humidity,
        "feelsLike": weather.feelsLike,
        "apiKey": weather.apiKey,
        "icon": weather.icon,
        "minimum": weather.minimum,
        "maximum": weather.maximum,
        "visibility": weather.visibility,
        "sunset": weather.sunset,
        "sunrise": weather.sunrise,
        "date": weather.date,
        // "": weather
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // RunApp();
    print("init states loading");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state loading");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose loading");
  }

  Widget build(BuildContext context) {
    print("outside");

    if (ModalRoute.of(context)!.settings.arguments != null &&
        ModalRoute.of(context)!.settings.arguments is Map &&
        (ModalRoute.of(context)!.settings.arguments as Map).isNotEmpty) {
      // Arguments have been passed.
      // print("argument passed: ");
      Map searchedData = ModalRoute.of(context)!.settings.arguments as Map;
      
      RunApp(searchedData['city']);
    } else {
      // No arguments have been passed.
      print("No argument passed: ");

      RunApp();
    }

    // if (ModalRoute.of(context)?.settings?.arguments == null) {
    //     print("inside  if");
    //     RunApp();
    //   }
    // else
    //   {
    //     Map searchedData = ModalRoute.of(context)!.settings.arguments as Map;
    //     print("outside $searchedData");
    //     if (searchedData.isNotEmpty) {
    //       print("inside else if $searchedData");
    //       RunApp(searchedData['city']);
    //     }
    //   }
    // Map searchedData = ModalRoute.of(context)!.settings.arguments as Map;
    //
    // print("outside $searchedData");
    // if (searchedData?.isNotEmpty ?? false) {
    //   // weather
    //   // print(searchedData['city']);
    //   print("inside if $searchedData");
    //
    //   RunApp(searchedData['city']);
    // } else
    //   {
    //   }

    double widthPercent(double a) {
      return (MediaQuery.of(context).size.width * a) / 100.0;
    }

    double heightPercent(double a) {
      return (MediaQuery.of(context).size.height * a) / 100.0;
    }

    double averagePercent(double a) {
      return ((((MediaQuery.of(context).size.height +
                      MediaQuery.of(context).size.width) /
                  2) *
              a) /
          100.0);
    }

    double greaterPercent(double a) {
      return (max(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height) *
              a) /
          100.0;
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightPercent(2.0), top: heightPercent(20)),
                  child: Image.asset(
                    "Assets/Images/weather-app.png",
                    width: widthPercent(100),
                    height: heightPercent(25),
                  ),
                ),
                Text(
                  "Weather App",
                  style: TextStyle(
                    fontSize: greaterPercent(4.5),
                    // fontSize: averagePercent(6),
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    // fontStyle: FontStyl    outside
                  ),
                ),
                SizedBox(
                  height: heightPercent(2),
                ),
                Text(
                  "Developed by Muhammad Ali",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    fontSize: greaterPercent(2.0),
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: heightPercent(8),
                ),
                SpinKitWave(
                  color: Colors.white,
                  size: heightPercent(8),
                ),
                SizedBox(
                  height: heightPercent(5),
                ),
                Text(
                  "Data Being fetched by openweather.org",
                  style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    // fontStyle: FontStyle.italic,
                    fontSize: greaterPercent(2.0),
                    color: Colors.white60,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }
}
