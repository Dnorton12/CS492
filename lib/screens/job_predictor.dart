import 'package:flutter/material.dart';
import '../models/random.dart';

class JobPredictor extends StatefulWidget {

  @override
  _JobState createState() => _JobState();
}

class _JobState extends State<JobPredictor> {

  // Create instance of the Predictor class from random.dart file
  late Predictor predictor = new Predictor();
  // Used to populate the answer returned from random.dart
  late String retanswer = '';

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Call me... Maybe?', style: Theme.of(context).textTheme.headline3,),
        Padding(
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {setState(() {retanswer = predictor.randomReturn();});},
            child: Text('Ask a question.. tap for an answer.', style: TextStyle(fontSize: 18,),),
          ),
        ),
        Center(
          child: Text('$retanswer', style: Theme.of(context).textTheme.headline4,),
        )
      ],
    );
  }
}