import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/api.dart';
import '../model/quiz.dart';

class SourceQuiz {
  static Future<List<Question>> getQuiz(int idLevel) async {
    final url = '${Api.baseUrl}question/$idLevel'; // Tambahkan id_level
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['success']) {
        return (body['data'] as List)
            .map((item) => Question.fromJson(item))
            .toList();
      }
    }

    throw Exception('Failed to load quiz');
  }
}
