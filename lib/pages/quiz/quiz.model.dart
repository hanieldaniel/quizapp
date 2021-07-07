import 'package:boro_boro/Models/QuizModel.dart';
import 'package:flutter/material.dart';
class QuizPageModel{
  List<int> correctAnswers = List<int>.filled(10, 0, growable: true);
  List<int> selectedAnswers = List<int>.filled(10, null, growable: true);

  QuizModel questions;
  String validationText = '';
  bool isValidated = false;

  /// page settings
  /// Save these so that we can access set state 
  /// and context from controller
  StateSetter pageState;
  BuildContext context;
}