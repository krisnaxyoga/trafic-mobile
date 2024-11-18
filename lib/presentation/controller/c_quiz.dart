import 'package:get/get.dart';
import '../../data/model/quiz.dart';
import '../../data/source/source_quiz.dart';

class CQuiz extends GetxController {
  final _listQuiz = RxList<Question>();
  final _currentIndex = 0.obs;
  final _score = 0.obs;
  final _isLoading = true.obs;

  List<Question> get listQuiz => _listQuiz;
  int get currentIndex => _currentIndex.value;
  int get score => _score.value;
  bool get isLoading => _isLoading.value;

  // Fungsi untuk mengambil data quiz berdasarkan idLevel
  void fetchQuiz(int idLevel) async {
    _isLoading.value = true;
    try {
      final result = await SourceQuiz.getQuiz(idLevel);
      _listQuiz.assignAll(result);
    } finally {
      _isLoading.value = false;
    }
  }

  // Fungsi untuk menangani jawaban pengguna
  void answer(int selectedIndex) {
    if (currentIndex >= listQuiz.length) return;

    final currentQuestion = listQuiz[currentIndex];

    // Cek apakah jawaban benar
    final correctOptionIndex = _getOptionIndex(currentQuestion.correctOption);
    if (correctOptionIndex == selectedIndex) {
      _score.value += 1; // Tambah skor jika benar
    }

    // Lanjut ke pertanyaan berikutnya
    if (_currentIndex.value < listQuiz.length - 1) {
      _currentIndex.value += 1;
    } else {
      // Quiz selesai
      Get.snackbar(
        "Quiz Selesai",
        "Skor kamu: $_score/${listQuiz.length}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Fungsi untuk mendapatkan indeks dari opsi yang benar
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
        return -1;
    }
  }
}
