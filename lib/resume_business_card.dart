import 'package:flutter/material.dart';
import '../screens/first_screen.dart';

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Me Maybe',
      // Set the color of app header
      theme: ThemeData(primarySwatch: Colors.blueGrey,
        // Set main screen background color
        scaffoldBackgroundColor: Colors.grey,
      ),
      home: MainTabController(),
    );
  }
}