import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/Activities/Loading.dart';
import 'package:weather_app/Working/GetData.dart';
import 'package:weather_app/Working/ScreenResolution.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // GetData weather = GetData();

  void getdata() async {
    // Weather weather = Weather(temp_City: "Sharaqpur");
    // await weather.getData();
    // weather.printWeatherSpecs();
    // Response response = await get(Uri.parse("http://api.openweathermap.org/geo/1.0/direct?q=Sharaqpur,PK&limit=5&appid=40ee76a33085129f390cf3a27b8737db"));
    // List a = jsonDecode(response.body);
    // Map a1 = a[0];
    // double lat  = a1['lat'];
    // double long  = a1['lon'];
    // print(lat);
    // print(a);

    //
    //
    // Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Sharaqpur&appid=40ee76a33085129f390cf3a27b8737db"));
    // // print(response.body);
    // Map weather = jsonDecode(response.body);
    // List weather0 = weather['weather'];
    //
    // Map weather00 = weather0[0];
    // print (weather00['description']);

    // Map weather = data['weather'];
    // print(data);
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    // getdata();
    print(("This is set state"));
  }

  int counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("THis is a init state");

    // getdata();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("this is dispose state");
  }

  @override
  Widget build(BuildContext context) {
    // Map? data = ModalRoute.of(context)?.settings.arguments as Map?;
    Map data = ModalRoute.of(context)!.settings.arguments as Map;

    Weather weather = Weather.convertData(data);

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

    // print(data);
    // Map data = ModalRoute.of(context).settings.arguments;
    var cities = [
      "Lahore",
      "Karachi",
      "Sharaqpur",
      "Quetta",
      "Peshawar",
      "Mumbai",
      "Delhi"
    ];
    var random = Random();
    var randomCity = cities[random.nextInt(cities.length)];
    // print(weather.description);
    // print(weather.icon);
    return Scaffold(
      backgroundColor: Colors.black,
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          // height: double.maxFinite,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // stops: [0.5, 0.5],
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
          )),

          child: Column(
            children: [
              Container(
                //search container
                // color: Colors.blueGrey,
                height: heightPercent(6.5),
                width: widthPercent(93.6),
                padding: EdgeInsets.symmetric(
                  horizontal: widthPercent(1.2),
                ),
                margin: EdgeInsets.only(
                  left: widthPercent(3.2),
                  right: widthPercent(3.2),
                  top: heightPercent(3.5),
                  bottom: heightPercent(3.5),
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          margin: EdgeInsets.fromLTRB(
                              widthPercent(1.2), 0, widthPercent(1.7), 0),
                          child: Icon(
                            Icons.search,
                            color: Colors.blue,
                          )),
                    ),
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search $randomCity",
                        border: InputBorder.none,
                      ),
                    )),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      //description

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white.withOpacity(0.45),
                      ),
                      height: heightPercent(15),
                      margin: EdgeInsets.symmetric(
                        horizontal: widthPercent(3.2),
                        // vertical: heightPercent(2.5),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: heightPercent(2),
                          horizontal: widthPercent(2)),
                      // padding: EdgeInsets.all(40),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        // alignment: Alignment.,
                        alignment: Alignment.topLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   height: heightPercent(30),
                            //   width: widthPercent(100),
                            Image.network(
                              "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
                              // fit: BoxFit.cover,
                              // scale: 0,
                              // ),
                            ),
                            Column(
                              children: [
                                Text(
                                  weather.description,
                                  // "Description datta",
                                  style: TextStyle(
                                    fontSize: averagePercent(5),
                                    // letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: heightPercent(1.5),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on_outlined,
                                        size: averagePercent(4)),
                                    Text(
                                      weather.city,
                                      // Text("{data[city]}",
                                      style: TextStyle(
                                          fontSize: averagePercent(4)),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          //main widget

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white.withOpacity(0.45),
                          ),
                          // padding: EdgeInsets.all(40),
                          height: heightPercent(27),
                          width: widthPercent(100),
                          margin: EdgeInsets.symmetric(
                            horizontal: widthPercent(3.2),
                            vertical: heightPercent(2),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: heightPercent(2),
                              horizontal: widthPercent(2)),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            // alignment: Alignment.,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      WeatherIcons.thermometer,
                                      size: averagePercent(17),
                                    ),
                                    Icon(
                                      WeatherIcons.celsius,
                                      size: averagePercent(29),
                                    ),
                                    // Padding(
                                    //   padding:  EdgeInsets.only(top: heightPercent(6), left: 0),
                                    //   child: Text("C", style: TextStyle(
                                    //     fontSize: averagePercent(17),
                                    //   ),),
                                    // )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: widthPercent(70),
                                          bottom: heightPercent(15)),
                                      child: Text(
                                        ("${weather.temperature}"),
                                        // "{data[temperature]}",
                                        style: TextStyle(
                                          fontSize: averagePercent(70),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: widthPercent(200)),
                                  child: Text(
                                    "Feels like: ${weather.feelsLike}",
                                    style: TextStyle(
                                      fontSize: averagePercent(15),
                                      // fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: widthPercent(3.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        //left hand

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white.withOpacity(0.45),
                        ),
                        // padding: EdgeInsets.all(40),
                        height: heightPercent(22),
                        // margin: EdgeInsets.symmetric(
                        //   horizontal: widthPercent(3.2),
                        //   vertical: heightPercent(3.5)),
                        // ),
                        padding: EdgeInsets.symmetric(
                            vertical: heightPercent(2),
                            horizontal: widthPercent(2)),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          // alignment: Alignment.,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(WeatherIcons.humidity),
                                  Text(weather.humidity),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(WeatherIcons.wind),
                                  Text(weather.windSpeed),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(WeatherIcons.cloud),
                                  Text(weather.clouds),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.visibility),
                                  Text("${weather.visibility}km/h"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: widthPercent(2.8),
                    ),
                    Expanded(
                      child: Container(
                        //right hand

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white.withOpacity(0.45),
                        ),
                        // padding: EdgeInsets.all(40),
                        height: heightPercent(22),
                        // margin: EdgeInsets.symmetric(
                        //   horizontal: widthPercent(3.2),
                        //   // vertical: heightPercent(3.5)),
                        // ),
                        padding: EdgeInsets.symmetric(
                            vertical: heightPercent(2),
                            horizontal: widthPercent(2)),
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            // alignment: Alignment.,
                            child: Text(
                              "RIGHT hand",
                              style: TextStyle(
                                fontSize: averagePercent(20),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: heightPercent(4),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                // alignment: Alignment.,
                child: Text(
                  "Developed by Muhammad Ali",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    fontSize: averagePercent(2),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
