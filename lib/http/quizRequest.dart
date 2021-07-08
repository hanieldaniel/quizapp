import 'package:boro_boro/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:boro_boro/Models/QuizModel.dart';

class QuizRequest {
  /// We return QuizModel from this method.
  /// Since we have to await for the request to be completed 
  /// we declare it as a future variable
  static Future<QuizModel> getQuestions() async {
    var url = Uri.parse(AppUrls.quizQuestions);
    http.Response response  = await http.get(url);
    //Handle Errors if required
    return quizModelFromJson(response.body);
  }
}