import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        // Calls to place picture and static text on screen
        nameRow(context, 'assets/helmet.jpg', -1, 0),
        nameRow(context, 'Dan Norton', 20, .4),
        nameRow(context, 'Technical Product Manager', 13, .5),
        staticRow(context, 'sms:2925211712', '292 521 1712'),
        lastRow(context, 'https://github.com/Dnorton12', 'packerfn32@yahoo.com'),
      ])
    );
  }
}

// Helper to determine size of the image based orientation
double width(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.landscape) {
    return .2;
  } else {
    return .3;
  }
}

// Helper to determine padding based on orientation
double padding(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.landscape) {
    return MediaQuery.of(context).size.width * .01;
  } else {
    return MediaQuery.of(context).size.width * .02;
  }
}

// Helper to place picture, user name and title on screen
Row nameRow(BuildContext context, String name, double font, double size) {
  bool image = false;
  if (font == -1) {
    image = true;
  }

  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            //fit: FlexFit.loose,
            child: FractionallySizedBox(
              widthFactor: image ? width(context): size,
              child: Padding(
                padding: EdgeInsets.all(padding(context)),
                child: image ?
                // If image is passed in
                Image.asset('assets/helmet.jpg')
                :
                // If Text is passed in
                Center(child: Text(name, style: TextStyle(fontSize: font,))),
              ),
            )
        )
      ]);
}

// Helper used to launch sms functionality
Row staticRow(BuildContext context, String info, String number) {

  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: GestureDetector(
                // Launches sms viewing
                onTap: () => launch(info),
                child: FractionallySizedBox(
                  widthFactor: .4,
                  child: Padding(
                    // Displays phone number correctly on screen
                    padding: EdgeInsets.all(padding(context)),
                    child: Center(child: Text(number)),
                  ),
                )
            )
        )
      ]);
}

// Helper to correct place and format last row
Row lastRow (BuildContext context, String url, String email) {

  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Expanded(
          // Launches url to open designated webpage
          child: GestureDetector(
            // Display url on screen
            onTap: () => launch(url),
            child: Text(url, textAlign: TextAlign.center,),
          )
        ),

        Expanded(
          // Display email on screen
          child: Text(email, textAlign: TextAlign.center),
        )
      ]
  );
}