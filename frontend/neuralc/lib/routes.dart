
import 'package:flutter/material.dart';
import 'package:neuralc/screens/home/home_screen.dart';
import 'package:neuralc/screens/splash/splash_screen.dart';

final Map<String,WidgetBuilder> routes = {
  SplashScreen.routeName:(context) => SplashScreen(),
  HomeScreen.routeName:(context) =>  HomeScreen(),
};