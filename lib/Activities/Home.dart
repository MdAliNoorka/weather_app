import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/Activities/Loading.dart';
import 'package:weather_app/Working/GetData.dart';
import 'package:weather_app/Working/ScreenResolution.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // GetData weather = GetData();


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

    String currentTime = DateFormat('HH:mm').format(DateTime.now());
    // print(currentTime); // output: 19:36:01

    TextEditingController searchController = new TextEditingController();

    FocusNode searchNode = FocusNode();
    final refreshKey = GlobalKey<RefreshIndicatorState>();
    void SearchCity(String value)
    {
      Navigator.pushReplacementNamed(context, "/loading", arguments: { "city" : searchController.text,});
        print("Searched ${searchController.text}");

    }
    Future<void> OnRefresh() async
    {
      Navigator.pushReplacementNamed(context, "/loading", arguments: {

      "city" : weather.city,
      });
      // Navigator.pushNamed(context, "/loading", arguments: {
      //   "city" : searchController.text,
      // });
      print("Refreshed");
      // await weather.getData("indore");
      // await Future.delayed(Duration(milliseconds: 1));
      // setState(() {});
      // print("we cityyy: ${weather.city}");
      // weather.city = "iindore";
      // print(weather.city);
      setState(() {
      });
    }
    return Scaffold(
      backgroundColor: Colors.black,
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: OnRefresh,
          child: SingleChildScrollView(
              child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top * 0.99,
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
                        onTap: () {

                          // print(searchController.text);
                          FocusScope.of(context).requestFocus(searchNode);
                        },

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
                            // onTap: (){
                            //   Navigator.pushNamed(context, "/loading", arguments: {
                            //     "city" : searchController.text,
                            //   });
                            //   },
                            // onTapOutside: ,
                            // textInputAction: TextInputAction.,
                            focusNode: searchNode,
                            // onSubmitted: ( () {}),
                            textInputAction: TextInputAction.search,
                            onSubmitted: SearchCity,
                            // onEditingComplete: (){
                            //     Navigator.pushReplacementNamed(context, "/loading", arguments: {
                            //       "city" : searchController.text,
                            //     });
                            //   // print("hello");
                            // },
                            // onTapOutside: (),
                            // onSubmitted:
                            controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search $randomCity",
                          border: InputBorder.none,
                        ),
                      )),
                      GestureDetector(
                        child: Container(

                          padding: EdgeInsets.only(right: widthPercent(3)),
                          child: Icon(Icons.refresh_outlined,
                          size: averagePercent(8),
                            color: Colors.teal,

                          ),
                        ),
                        onTap: OnRefresh,

                      ),
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
                                      Container(
                                        padding: EdgeInsets.only(top: heightPercent(.3), right: widthPercent(1.2)),

                                        child: Icon(Icons.location_on_outlined,
                                            size: averagePercent(4),
                                          color: Colors.teal,
                                        ),
                                      ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        WeatherIcons.thermometer,
                                        size: averagePercent(27),
                                        color: Colors.red,
                                      ),
                                      Icon(
                                        WeatherIcons.celsius,
                                        size: averagePercent(39),
                                        // color: Colors.yellow,

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
                                            left: widthPercent(30),
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
                              vertical: heightPercent(1),
                              horizontal: widthPercent(2)),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row(
                                //   children: [
                                //     Icon(WeatherIcons.humidity),
                                //     Text(weather.humidity),
                                //   ],
                                // ),
                                Container( //windspeed
                                  padding:
                                      EdgeInsets.only(left: widthPercent(3.5)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        WeatherIcons.windy,
                                        size: averagePercent(7),
                                        color: Colors.blueGrey,

                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: heightPercent(2.2),
                                            left: widthPercent(3.5)),
                                        child: Row(
                                          children: [
                                            Text(
                                              weather.windSpeed,
                                              style: TextStyle(
                                                fontSize: averagePercent(4),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: heightPercent(.5)),
                                              child: Text(
                                                " km/h",
                                                style: TextStyle(
                                                  fontSize: averagePercent(2.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: heightPercent(.7),),

                                Container( //clouds
                                  padding:
                                  EdgeInsets.only(left: widthPercent(3.5)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        WeatherIcons.cloudy,
                                        size: averagePercent(7),
                                        color: Colors.blueGrey,

                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: heightPercent(2.2),
                                            left: widthPercent(3.5)),
                                        child: Row(
                                          children: [
                                            Text(
                                              weather.clouds,
                                              style: TextStyle(
                                                fontSize: averagePercent(4),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: heightPercent(.5)),
                                              child: Text(
                                                " %",
                                                style: TextStyle(
                                                  fontSize: averagePercent(3.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: heightPercent(.7),),

                                Container( //humidity
                                  padding:
                                  EdgeInsets.only(left: widthPercent(3.5)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        WeatherIcons.humidity,
                                        size: averagePercent(7),
                                        color: Colors.blueGrey,

                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: heightPercent(2.2),
                                            left: widthPercent(3.5)),
                                        child: Row(
                                          children: [
                                            Text(
                                              weather.humidity,
                                              style: TextStyle(
                                                fontSize: averagePercent(4),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: heightPercent(.5)),
                                              child: Text(
                                                " %",
                                                style: TextStyle(
                                                  fontSize: averagePercent(3.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
                              // horizontal: widthPercent(1)
                          ),
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              // alignment: Alignment.,
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container( //date
                                    // padding:
                                    // EdgeInsets.only(left: widthPercent(0)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.access_time_outlined,
                                          size: averagePercent(6),
                                          color: Colors.blueGrey,

                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: heightPercent(.8),
                                              left: widthPercent(6.5)),
                                          child: Text(
                                                weather.date,
                                                style: TextStyle(
                                                  fontSize: averagePercent(3.5),
                                                ),
                                              ),

                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: heightPercent(.7),),
                                  Container( //sunrise
                                    // padding:
                                    // EdgeInsets.only(left: widthPercent(0)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          WeatherIcons.sunrise,
                                          size: averagePercent(6),
                                          color: Colors.blueGrey,

                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: heightPercent(1.8),
                                              left: widthPercent(6.5)),
                                          child: Text(
                                            weather.sunrise,
                                            style: TextStyle(
                                              fontSize: averagePercent(3.5),
                                            ),
                                          ),

                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: heightPercent(.7),),

                                  Container( //sunset
                                    // padding:
                                    // EdgeInsets.only(left: widthPercent(0)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          WeatherIcons.sunset,
                                          size: averagePercent(6),
                                          color: Colors.blueGrey,


                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: heightPercent(1.8),
                                              left: widthPercent(6.5)),
                                          child: Text(
                                            weather.sunset,
                                            style: TextStyle(
                                              fontSize: averagePercent(3.5),
                                            ),
                                          ),

                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),),
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
      ),
    );
  }
}
