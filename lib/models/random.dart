import 'dart:math';
import 'package:dart_random_choice/dart_random_choice.dart';

// Return a random sting from the pre-populated list
class Predictor {

  final Random random = Random();

  // List of available random answers to be returned
  List<String> answers = [ //remove
    'It is certain',
    'Without a doubt',
    'Yes-definitely',
    'Ask again later',
    'Cannot predict now',
    'Don\'t count on it',
    'My sources say no',
    'Very doubtful',
  ];

  // Helper to return the answers
  String randomReturn() {
    return (randomChoice<String>(answers));
  }
}