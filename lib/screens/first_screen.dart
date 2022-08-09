import 'package:flutter/material.dart';
import '../screens/business_card.dart';
import '../screens/resume.dart';
import '../screens/job_predictor.dart';

class MainTabController extends StatelessWidget {

  // Set icons to be used within the AppBar
  static const tabs = [
    Tab(icon: Icon(Icons.account_box)),
    Tab(icon: Icon(Icons.newspaper)),
    Tab(icon: Icon(Icons.question_mark))
  ];

  // Three screens needed for the program
  final screens = [BusinessCard(), Resume(), JobPredictor()];

  @override
  Widget build(BuildContext context) {
    // Set up the tab controller
    return DefaultTabController(
        length: tabs.length,
        initialIndex: 0,
        child: Scaffold (
          appBar: AppBar(
            // Center align the title of program
            title: const Center( child: Text('Call Me Maybe'),),
            // Place icons at bottom of appbar
            bottom: const TabBar(tabs: tabs),
          ),
          body: TabBarView(children: screens),
        )
    );
  }
}