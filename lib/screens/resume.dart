import 'package:flutter/material.dart';

// Globals to used to populate the resume information
const String job = 'Technical Product Manager';
String orgName = 'Marine Credit Union';
String date = '4/2020 - Present';
String city = 'LaCrosse, WI';
const String description = 'A product manager is the person who identifies the customer need and '
    'the larger business objectives that a product or feature will fulfill, '
    'articulates what success looks like for a product, '
    'and rallies a team to turn that vision into a reality.';

class Resume extends StatelessWidget {
  const Resume({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
          child: Column(
            children: <Widget> [
              // Top level resume information
              resumeName('Dan Norton'),
              standardText('packerfn32@yahoo.com', true),
              standardText('https://github.com/Dnorton12', true),
              padding(),
              // Call to create the resume table/rows
              createTable(context),
            ],
          ),
      )
    );
  }
}

// Helper creates padding based on orientation
Padding padding() {
  return const Padding(
    padding: EdgeInsets.only(bottom: 10),
  );
}

// Helper creates a divide between resume sections
Divider mydivide() {
  return const Divider(
    thickness: 1,
    color: Colors.black,
  );
}

// Helper populates the Employment data
Row employerInfo(String name, String date, String city) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Text('Marine Credit Union', textAlign: TextAlign.left),
      Text('04/2020 - Present', textAlign: TextAlign.center),
      Text('LaCrosse, WI', textAlign: TextAlign.right),
    ],
  );
}

// Helper ensures text placed in correct location
Align standardText(String script, bool top) {
  return Align(
    alignment: top ? Alignment.topLeft : Alignment.centerLeft,
    child: Text(script),
  );
}

// Helper ensures user name has been enlarged
Align resumeName(String name) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(name, style: const TextStyle(fontSize: 20)),
  );
}

// Helper to bold the job title
Align jobTitle(String name) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}

// Creates a table of data with various table rows populated
Widget createTable (BuildContext context) {

  const int count = 12;
  int i = 0;

  return Table(
    children: [
    // Loop for count, can be varied as needed
    for (i=0; i < count; i++) ...[
      // Table row for the divide
      TableRow(
        children:[
          mydivide(),
        ]
      ),
      // Table row for job title
      TableRow(
        children: [
          jobTitle(job),
        ]
      ),
      // Table row for employment information
      TableRow(
        children: [
          employerInfo(orgName, date, city)
        ]
      ),
      // Table row for description of job
      TableRow(
        children: [
          standardText(description, true)
        ]
      ),
    ],

    ],
  );
}