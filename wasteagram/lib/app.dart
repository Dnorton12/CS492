import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/camera_screens.dart';

class App extends StatelessWidget {
  final String title;
  num calledEntry = 0;

  App({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wasteagram',
        theme: ThemeData.dark(),
        home: Scaffold(body: CameraScreen(calledEntry)));
  }
}