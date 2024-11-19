import 'dart:convert';
import 'dart:io';
import '../../config/api.dart';
import '../../config/app_request.dart';
import '../../config/quiz_response.dart';
import '../../config/session.dart';
import '../model/question.dart';

class SourceQuiz {
  static Future<List<Question>> getQuiz(int idLevel) async {
    try {
      // Ambil token untuk otentikasi
      final token = await Session.getToken();
      print('$token ini token'); // Debugging log untuk token
      if (token == null) return <Question>[];

      // URL API untuk mengambil data quiz berdasarkan idLevel
      String url = '${Api.question}/$idLevel';

      // Mengirim permintaan GET ke API dengan header Authorization
      final responseBody = await AppRequest.gets(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Debugging: menampilkan responseBody dari API
      print('responseBody from API: $responseBody');
      print('$idLevel >>>>ini id level di source<<<');

      // Pastikan bahwa responseBody berisi data yang valid
      if (responseBody != null && responseBody['success'] == true) {
        final List<dynamic> list = responseBody['data'] ?? [];

        // Mengonversi setiap item dalam list menjadi objek Question
        return list.map<Question>((json) => Question.fromJson(json)).toList();
      } else {
        // Mengembalikan list kosong jika `success` tidak true
        print('API response not successful or data is missing');
        return <Question>[];
      }
    } catch (e) {
      // Menangani error dan mencetak log
      print('Error getting quiz data: $e');
      return <Question>[]; // Mengembalikan list kosong jika terjadi error
    }
  }

  // Fungsi untuk mengirim jawaban ke API
  static Future<Map?> submitAnswer(int questionId, String answer) async {
    try {
      final token = await Session.getToken();
      if (token == null) return null;

      String url = '${Api.answer}/$questionId';
      final response = await AppRequest.post(
        url,
        jsonEncode({'answer': answer}), // Mengirimkan jawaban dalam format JSON
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      print('Error submitting answer: $e');
      return null;
    }
  }
}
