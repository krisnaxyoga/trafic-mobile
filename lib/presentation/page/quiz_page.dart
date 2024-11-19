import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/c_quiz.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CQuiz()).onInit();
    final int idLevel =
        Get.arguments as int; // Mendapatkan idLevel dari argumen
    final cQuiz = Get.put(CQuiz()); // Inisialisasi controller CQuiz
    // Fetch quiz data when the page is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cQuiz.fetchQuiz(idLevel); // Ambil data quiz berdasarkan idLevel
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Quiz',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black, // Set back button color to black
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => cQuiz.fetchQuiz(idLevel), // Refresh data quiz
              color: Colors.black,
            ),
          ],
        ),
        body: Obx(() {
          if (cQuiz.isLoading) {
            return const Center(
                child: CircularProgressIndicator()); // Loading indicator
          }

          if (cQuiz.listQuiz.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada data quiz.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final currentQuestion = cQuiz.currentQuestion;
          if (currentQuestion == null) {
            return const Center(
              child: Text(
                'Error loading question.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // Menampilkan informasi level dan sign (tanda)
          final level = currentQuestion.level; // Mengakses informasi level
          final sign = currentQuestion.sign; // Mengakses informasi sign

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menampilkan gambar tanda jika ada
                if (sign?.signImage != null) ...[
                  Image.network(
                    sign!
                        .imageUrl, // Menggunakan URL gambar dari getter imageUrl
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                ],
                // Menampilkan nama level
                if (level != null) ...[
                  Text(
                    'Level: ${level.levelNumber} - ${level.levelDesc}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                ],
                // Menampilkan pertanyaan saat ini
                Text(
                  'Pertanyaan ${cQuiz.currentIndex + 1} dari ${cQuiz.listQuiz.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  currentQuestion.questionText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                // Tombol Pilihan A, B, C, D
                OptionButton(
                  optionLabel: 'A',
                  optionText: currentQuestion.optionA,
                  onTap: cQuiz.isAnswered
                      ? null
                      : () => cQuiz.answer(0), // Disable if answered
                ),
                const SizedBox(height: 16),
                OptionButton(
                  optionLabel: 'B',
                  optionText: currentQuestion.optionB,
                  onTap: cQuiz.isAnswered
                      ? null
                      : () => cQuiz.answer(1), // Disable if answered
                ),
                const SizedBox(height: 16),
                OptionButton(
                  optionLabel: 'C',
                  optionText: currentQuestion.optionC,
                  onTap: cQuiz.isAnswered
                      ? null
                      : () => cQuiz.answer(2), // Disable if answered
                ),
                const SizedBox(height: 16),
                OptionButton(
                  optionLabel: 'D',
                  optionText: currentQuestion.optionD,
                  onTap: cQuiz.isAnswered
                      ? null
                      : () => cQuiz.answer(3), // Disable if answered
                ),
                const SizedBox(height: 24),
                // Menampilkan skor saat ini
                Text(
                  'Skor: ${cQuiz.score}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String optionLabel;
  final String optionText;
  final VoidCallback? onTap; // Nullable to disable the button

  const OptionButton({
    super.key,
    required this.optionLabel,
    required this.optionText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  optionLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  optionText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
