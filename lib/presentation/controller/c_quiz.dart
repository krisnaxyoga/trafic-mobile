import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/question.dart';
import '../../data/source/source_quiz.dart';
import '../page/level_page.dart';
import 'c_user.dart';

class CQuiz extends GetxController {
  final RxList<Question> _listQuiz = <Question>[].obs; // Daftar soal kuis
  final RxInt _currentIndex = 0.obs; // Indeks soal saat ini
  final RxInt _score = 0.obs; // Skor pengguna
  final RxBool _isLoading = true.obs; // Status loading
  final RxBool _isAnswered = false.obs; // Status apakah jawaban sudah diberikan

  // Getter untuk mengakses data
  List<Question> get listQuiz => _listQuiz.toList();
  int get currentIndex => _currentIndex.value;
  int get score => _score.value;
  bool get isLoading => _isLoading.value;
  bool get isAnswered => _isAnswered.value; // Getter untuk status jawaban
  Question? get currentQuestion =>
      _listQuiz.isNotEmpty && currentIndex < _listQuiz.length
          ? _listQuiz[currentIndex]
          : null;

  // Fungsi untuk mengambil data kuis berdasarkan idLevel
  void fetchQuiz(int idLevel) async {
    _isLoading.value = true; // Menandakan loading dimulai
    try {
      final result =
          await SourceQuiz.getQuiz(idLevel); // Ambil data kuis dari API
      _listQuiz.assignAll(result); // Menyimpan hasil di _listQuiz
      _currentIndex.value = 0; // Reset indeks ke 0
      _score.value = 0; // Reset skor
    } catch (e) {
      print('Error fetching quiz: $e');
      _listQuiz.clear(); // Kosongkan list jika terjadi error
      // Tampilkan pesan error ke pengguna
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat memuat kuis.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false; // Set status loading selesai
    }
  }

  // Fungsi untuk memilih jawaban dan mengecek kebenaran jawaban
  void answer(int selectedIndex) async {
    if (_isAnswered.value) return;

    final current = currentQuestion;
    if (current == null) return;

    final correctOptionIndex = _getOptionIndex(current.correctOption);
    final selectedOption = _getOptionLabel(selectedIndex);

    final response = await SourceQuiz.submitAnswer(current.id, selectedOption);

    if (response != null && response['message'] != null) {
      Get.snackbar(
        "Hasil Jawaban",
        response['message'],
        snackPosition: SnackPosition.TOP,
        backgroundColor:
            response['message'] == 'Benar' ? Colors.green : Colors.red,
        colorText: Colors.white,
      );

      if (response['message'] == 'Benar') {
        _score.value += 10;
      }

      _isAnswered.value = true;
    } else {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat mengirim jawaban.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return; // Exit if there's an error
    }

    if (_currentIndex.value < _listQuiz.length - 1) {
      _currentIndex.value += 1;
      _isAnswered.value = false;
    } else {
      Get.offAll(() => LevelPage());
      Get.snackbar(
        "Quiz Selesai",
        "Anda telah menyelesaikan semua pertanyaan.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
      Get.put(CUser()).onInit(); // Reload data user
      Get.offAll(() => LevelPage()); // Pindah ke halaman LevelPage
    }
  }

  // Fungsi untuk menentukan indeks dari opsi yang benar (A, B, C, D)
  int _getOptionIndex(String correctOption) {
    switch (correctOption.toUpperCase()) {
      case 'A':
        return 0;
      case 'B':
        return 1;
      case 'C':
        return 2;
      case 'D':
        return 3;
      default:
        return -1; // Jika tidak ada yang sesuai
    }
  }

  // Fungsi untuk mendapatkan label opsi berdasarkan index
  String _getOptionLabel(int index) {
    switch (index) {
      case 0:
        return 'A';
      case 1:
        return 'B';
      case 2:
        return 'C';
      case 3:
        return 'D';
      default:
        return '';
    }
  }
}
