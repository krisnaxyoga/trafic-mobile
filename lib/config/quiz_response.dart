import '../data/model/question.dart';

class QuizResponse {
  final bool success;
  final String message;
  final List<Question> data;

  QuizResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List?)?.map((x) => Question.fromJson(x)).toList() ??
              [],
    );
  }
}
