
import 'package:flutter/material.dart';
// import 'package:neuralc/constants.dart';
import 'package:neuralc/screens/home/components/pick_image.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ImageCapture();

  }
}

