import 'dart:math';
import 'package:boro_boro/constants/strings.dart';
import 'package:boro_boro/http/quizRequest.dart';
import 'package:boro_boro/pages/quiz/quiz.model.dart';

class QuizPageController with QuizPageModel{
  void initialize(){
    getQuizQuestions();
    insertCorrectAnswer();
  }

  void getQuizQuestions() async {
    questions = await QuizRequest.getQuestions();
    /// Instead of setstate we use the pagestate stored in model
    pageState(() { });
  }

  void insertCorrectAnswer(){
    correctAnswers.asMap().forEach((key, value) {
      Random random = new Random();
      int randomNumber = random.nextInt(4);
      correctAnswers[key] = randomNumber;
    });
  }
  //callbacks
  void radioSelectedCallback(){
    isValidated = false;
    pageState(() { });
  }

  void resetButtonCallback(){
    selectedAnswers = List<int>.filled(10, null, growable: true);
    validationText = "";
    isValidated = false;
    pageState(() { });
  }

  void validateButtonCallback(){
    int correctCount = 0;
    correctAnswers.asMap().forEach((key, value) {
    if(selectedAnswers[key] == value){
      correctCount++;
     }
    });
    isValidated = true;
    validationText = AppStrings.correctMessage(correctCount.toString(), selectedAnswers.length.toString());
    pageState(() { });
  }
}