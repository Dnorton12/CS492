import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'resume_business_card.dart';

void main() {
  // Set up allowed orientations
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);
  // Start the app
  runApp(MyApp());
}