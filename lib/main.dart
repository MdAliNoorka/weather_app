import 'package:flutter/material.dart';
import 'package:weather_app/Activities/Home.dart';
import 'package:weather_app/Activities/Location.dart';
import 'package:weather_app/Activities/Loading.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/" : (context) => Loading(),
      "/home" : (context) => Home(),
      "/loading" : (context) => Loading(),
    },
  ));
}
